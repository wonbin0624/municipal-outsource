package com.platform.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.platform.common.Result;
import com.platform.entity.MunicipalProject;
import com.platform.entity.RectifyTask;
import com.platform.entity.ServiceProvider;
import com.platform.service.MunicipalProjectService;
import com.platform.service.RectifyTaskService;
import com.platform.service.ServiceProviderService;
import com.platform.service.SysLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/rectify")
@CrossOrigin
public class RectifyTaskController {

    @Autowired
    private RectifyTaskService rectifyTaskService;

    @Autowired
    private ServiceProviderService providerService;

    @Autowired
    private MunicipalProjectService projectService;

    @Autowired
    private SysLogService sysLogService;

    // 管理员查看所有整改任务（带项目名、服务商名）
    @GetMapping("/list")
    public Result<List<RectifyTask>> list() {
        List<RectifyTask> list = rectifyTaskService.list();
        for (RectifyTask t : list) {
            fillNames(t);
        }
        return Result.success(list);
    }

    // 服务商查看自己的整改任务
    @GetMapping("/my-list")
    public Result<List<RectifyTask>> myList(@RequestParam Long providerId) {
        QueryWrapper<RectifyTask> wrapper = new QueryWrapper<>();
        wrapper.eq("provider_id", providerId);
        wrapper.orderByDesc("created_at");
        List<RectifyTask> list = rectifyTaskService.list(wrapper);
        for (RectifyTask t : list) {
            fillNames(t);
        }
        return Result.success(list);
    }

    // 巡查员查看待复核的任务（status=2）
    @GetMapping("/review-list")
    public Result<List<RectifyTask>> reviewList() {
        QueryWrapper<RectifyTask> wrapper = new QueryWrapper<>();
        wrapper.eq("status", 2);
        wrapper.orderByDesc("updated_at");
        List<RectifyTask> list = rectifyTaskService.list(wrapper);
        for (RectifyTask t : list) {
            fillNames(t);
        }
        return Result.success(list);
    }

    // 服务商提交整改
    @PutMapping("/submit")
    public Result<String> submit(@RequestBody RectifyTask data) {
        RectifyTask task = rectifyTaskService.getById(data.getId());
        if (task == null) {
            return Result.error("整改任务不存在");
        }
        if (task.getStatus() != 0 && task.getStatus() != 4) {
            return Result.error("当前状态不允许提交整改");
        }
        task.setRectifyComment(data.getRectifyComment());
        task.setRectifyImages(data.getRectifyImages());
        task.setStatus(2);
        task.setUpdatedAt(LocalDateTime.now());
        rectifyTaskService.updateById(task);

        sysLogService.saveLog("服务商", "提交整改任务：" + task.getTaskCode());
        return Result.success("整改提交成功，等待巡查员复核");
    }

    // 巡查员复核
    @PutMapping("/review")
    public Result<String> review(@RequestBody RectifyTask data) {
        RectifyTask task = rectifyTaskService.getById(data.getId());
        if (task == null) {
            return Result.error("整改任务不存在");
        }
        if (task.getStatus() != 2) {
            return Result.error("该任务不在待复核状态");
        }
        task.setReviewComment(data.getReviewComment());
        task.setStatus(data.getStatus());
        task.setUpdatedAt(LocalDateTime.now());
        rectifyTaskService.updateById(task);

        String action = (data.getStatus() == 3) ? "通过" : "驳回";
        sysLogService.saveLog("巡查员", "复核整改任务：" + task.getTaskCode() + "，结果：" + action);
        return Result.success("复核完成：" + action);
    }

    // 补项目名和服务商名（临时字段）
    private void fillNames(RectifyTask t) {
        if (t.getProjectId() != null) {
            MunicipalProject p = projectService.getById(t.getProjectId());
            if (p != null) {
                t.setProjectName(p.getName());
            }
        }
        if (t.getProviderId() != null) {
            ServiceProvider sp = providerService.getById(t.getProviderId());
            if (sp != null) {
                t.setProviderName(sp.getCompanyName());
            }
        }
    }
}