package com.platform.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.platform.common.Result;
import com.platform.entity.CitizenWorkorder;
import com.platform.entity.ServiceProvider;
import com.platform.service.CitizenWorkorderService;
import com.platform.service.ServiceProviderService;
import com.platform.service.SysLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@RestController
@RequestMapping("/api/workorder")
@CrossOrigin
public class CitizenWorkorderController {

    @Autowired
    private CitizenWorkorderService workorderService;

    @Autowired
    private ServiceProviderService serviceProviderService;

    @Autowired
    private SysLogService sysLogService;

    @GetMapping("/list")
    public Result<List<CitizenWorkorder>> list() {
        return Result.success(workorderService.list());
    }

    @PostMapping("/add")
    public Result<String> add(@RequestBody CitizenWorkorder workorder) {
        workorder.setWorkorderCode("WO-" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")));
        workorder.setStatus(0);
        workorder.setSubmitTime(LocalDateTime.now());
        workorder.setCreatedAt(LocalDateTime.now());
        workorder.setProjectId(0L);

        String category = workorder.getCategory();
        String area = workorder.getArea();
        ServiceProvider matchedProvider = null;

        if (category != null && !category.isEmpty()) {
            QueryWrapper<ServiceProvider> wrapper = new QueryWrapper<>();
            wrapper.eq("category", category);
            wrapper.eq("status", 1);

            if (area != null && !area.isEmpty()) {
                wrapper.eq("area", area);
            }

            List<ServiceProvider> providers = serviceProviderService.list(wrapper);

            if (providers != null && !providers.isEmpty()) {
                matchedProvider = providers.get(0);
                workorder.setProviderId(matchedProvider.getId());
                workorder.setStatus(1);
                System.out.println("智能分派成功！[" + category + "/" + area + "] -> " + matchedProvider.getCompanyName());
            } else {
                System.out.println("暂无服务商同时匹配类别[" + category + "]和片区[" + area + "]，工单待人工分配");
            }
        }

        workorderService.save(workorder);

        // ===== 新增：记录操作日志 =====
        String logContent;
        if (matchedProvider != null) {
            logContent = "提交了诉求工单：" + workorder.getWorkorderCode()
                    + "（" + area + "+" + category + "），系统自动分派至：" + matchedProvider.getCompanyName();
        } else {
            logContent = "提交了诉求工单：" + workorder.getWorkorderCode()
                    + "（" + area + "+" + category + "），系统匹配失败，等待人工分派";
        }
        sysLogService.saveLog(workorder.getCitizenName(), logContent);

        return Result.success("诉求提交成功！");
    }

    @PutMapping("/assign")
    public Result<String> assign(@RequestBody CitizenWorkorder workorder) {
        CitizenWorkorder existing = workorderService.getById(workorder.getId());
        if (existing == null) {
            return Result.error("工单不存在");
        }
        existing.setProviderId(workorder.getProviderId());
        existing.setStatus(1);
        workorderService.updateById(existing);
        return Result.success("分配成功");
    }

    @GetMapping("/my-list")
    public Result<List<CitizenWorkorder>> getMyWorkorders(@RequestParam Long providerId) {
        QueryWrapper<CitizenWorkorder> wrapper = new QueryWrapper<>();
        wrapper.eq("provider_id", providerId);
        wrapper.orderByDesc("created_at");
        return Result.success(workorderService.list(wrapper));
    }

    @PutMapping("/update-status")
    public Result<String> updateStatus(@RequestBody CitizenWorkorder workorder) {
        CitizenWorkorder existing = workorderService.getById(workorder.getId());
        if (existing == null) {
            return Result.error("工单不存在");
        }

        if (existing.getProviderId() == null || !existing.getProviderId().equals(workorder.getProviderId())) {
            return Result.error("无权操作此工单");
        }

        existing.setStatus(workorder.getStatus());
        if (workorder.getStatus() == 2) {
            existing.setFinishTime(LocalDateTime.now());
        }

        if (workorder.getComment() != null) {
            existing.setComment(workorder.getComment());
        }

        if (workorder.getImages() != null) {
            existing.setImages(workorder.getImages());
        }

        workorderService.updateById(existing);
        return Result.success("整改状态更新成功");
    }

    // 👇 新增：市民评价工单
    @PutMapping("/evaluate")
    public Result<String> evaluate(@RequestBody CitizenWorkorder workorder) {
        CitizenWorkorder existing = workorderService.getById(workorder.getId());
        if (existing == null) {
            return Result.error("工单不存在");
        }

        if (existing.getStatus() != 2) {
            return Result.error("工单尚未完成，无法评价");
        }

        if (existing.getSatisfaction() != null) {
            return Result.error("您已评价过该工单");
        }

        existing.setSatisfaction(workorder.getSatisfaction());
        existing.setEvaluation(workorder.getEvaluation());
        existing.setEvaluatedAt(LocalDateTime.now());
        workorderService.updateById(existing);

        sysLogService.saveLog("市民", "评价工单：" + existing.getWorkorderCode() + "，满意度：" + workorder.getSatisfaction() + "星");

        return Result.success("评价成功，感谢您的反馈！");
    }

    /**
     * 市民获取自己提交的工单列表
     */
    @GetMapping("/my-orders")
    public Result<List<CitizenWorkorder>> getMyOrders(@RequestParam String citizenName) {
        QueryWrapper<CitizenWorkorder> wrapper = new QueryWrapper<>();
        wrapper.eq("citizen_name", citizenName);
        wrapper.orderByDesc("created_at");
        return Result.success(workorderService.list(wrapper));
    }
}