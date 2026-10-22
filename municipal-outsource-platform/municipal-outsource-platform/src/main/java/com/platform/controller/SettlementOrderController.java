package com.platform.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.platform.common.Result;
import com.platform.entity.AssessResult;
import com.platform.entity.SettlementOrder;
import com.platform.entity.ServiceProvider;
import com.platform.entity.MunicipalProject;
import com.platform.service.AssessResultService;
import com.platform.service.SettlementOrderService;
import com.platform.service.ServiceProviderService;
import com.platform.service.MunicipalProjectService;
import com.platform.service.SysLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import com.platform.utils.ExcelExportUtil;
import com.platform.entity.SettlementOrderExportDTO;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/settlement")
@CrossOrigin
public class SettlementOrderController {

    @Autowired
    private SettlementOrderService settlementOrderService;

    @Autowired
    private AssessResultService assessResultService;

    @Autowired
    private MunicipalProjectService municipalProjectService;

    @Autowired
    private ServiceProviderService serviceProviderService;

    @Autowired
    private SysLogService sysLogService;

    // 1. 获取结算列表
    @GetMapping("/list")
    public Result<List<SettlementOrder>> list(
            @RequestParam(required = false) Long providerId,
            @RequestParam(required = false) String period,
            @RequestParam(required = false) Integer status) {

        QueryWrapper<SettlementOrder> wrapper = new QueryWrapper<>();

        // 按服务商筛选
        if (providerId != null) {
            wrapper.eq("provider_id", providerId);
        }

        // 按结算周期筛选（created_at 的月份）
        if (period != null && !period.isEmpty()) {
            wrapper.apply("DATE_FORMAT(created_at, '%Y-%m') = {0}", period);
        }

        // 按结算状态筛选
        if (status != null) {
            wrapper.eq("status", status);
        }

        wrapper.orderByDesc("created_at");
        return Result.success(settlementOrderService.list(wrapper));
    }

    // 2. 核心功能：一键自动生成当月结算单（支持重复生成）
    @PostMapping("/generate")
    public Result<String> generateSettlement() {
        String currentPeriod = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM"));

        // ===== 允许重复生成：注释掉重复校验 =====
        // QueryWrapper<SettlementOrder> checkWrapper = new QueryWrapper<>();
        // checkWrapper.apply("DATE_FORMAT(created_at, '%Y-%m') = {0}", currentPeriod);
        // if (settlementOrderService.count(checkWrapper) > 0) {
        //     return Result.error("当前月份已有结算单，请勿重复生成！");
        // }

        // 获取所有服务商
        List<ServiceProvider> providers = serviceProviderService.list();
        if (providers.isEmpty()) {
            return Result.error("系统中暂无服务商，无法生成结算单！");
        }

        int successCount = 0;

        System.out.println("=== 开始执行结算生成逻辑 ===");
        System.out.println("查到的服务商数量: " + providers.size());

        for (ServiceProvider provider : providers) {
            System.out.println("--- 正在处理服务商: ID=" + provider.getId() + ", 名称=" + provider.getCompanyName() + " ---");

            // 1. 如果该服务商没有任何项目，跳过
            QueryWrapper<MunicipalProject> projectQuery = new QueryWrapper<>();
            projectQuery.eq("provider_id", provider.getCompanyName());
            List<MunicipalProject> projects = municipalProjectService.list(projectQuery);
            System.out.println("该服务商关联的项目数量: " + projects.size());

            if (projects.isEmpty()) {
                System.out.println("-> 无关联项目，跳过此服务商");
                continue;
            }

            // 2. 计算基础服务费总和
            BigDecimal totalBaseAmount = BigDecimal.ZERO;
            for (MunicipalProject p : projects) {
                if (p.getAmount() != null) {
                    totalBaseAmount = totalBaseAmount.add(p.getAmount());
                    System.out.println("项目: " + p.getName() + " 金额: " + p.getAmount());
                }
            }
            System.out.println("该服务商基础服务费总和: " + totalBaseAmount);

            // 3. 查考核分，并记录下考核记录ID
            BigDecimal score = BigDecimal.valueOf(80);
            BigDecimal totalScoreSum = BigDecimal.ZERO;
            int scoreCount = 0;
            Long latestResultId = null;

            for (MunicipalProject p : projects) {
                QueryWrapper<AssessResult> assessWrapper = new QueryWrapper<>();
                assessWrapper.eq("project_id", p.getId());
                assessWrapper.eq("assess_period", currentPeriod);
                AssessResult assessResult = assessResultService.getOne(assessWrapper);
                if (assessResult != null && assessResult.getTotalScore() != null) {
                    totalScoreSum = totalScoreSum.add(assessResult.getTotalScore());
                    scoreCount++;
                    latestResultId = assessResult.getId();
                    System.out.println("项目ID: " + p.getId() + " 查到考核分: " + assessResult.getTotalScore());
                } else {
                    System.out.println("项目ID: " + p.getId() + " 未找到当月考核分");
                }
            }

            if (scoreCount > 0) {
                score = totalScoreSum.divide(BigDecimal.valueOf(scoreCount), 2, RoundingMode.HALF_UP);
            }
            System.out.println("最终核定的考核分: " + score);

            // 4. 计算扣减金额和实发金额
            BigDecimal deductAmount = BigDecimal.ZERO;
            if (score.compareTo(BigDecimal.valueOf(80)) < 0) {
                deductAmount = totalBaseAmount.multiply(BigDecimal.valueOf(0.1));
            }
            if (score.compareTo(BigDecimal.valueOf(60)) < 0) {
                deductAmount = totalBaseAmount.multiply(BigDecimal.valueOf(0.2));
            }
            if (deductAmount.compareTo(totalBaseAmount) > 0) {
                deductAmount = totalBaseAmount;
            }
            BigDecimal paidAmount = totalBaseAmount.subtract(deductAmount);
            System.out.println("扣减金额: " + deductAmount + ", 实发金额: " + paidAmount);

            // 5. 👇 先删除该服务商本月的旧结算单（允许重复生成）
            QueryWrapper<SettlementOrder> deleteWrapper = new QueryWrapper<>();
            deleteWrapper.eq("provider_id", provider.getId());
            deleteWrapper.apply("DATE_FORMAT(created_at, '%Y-%m') = {0}", currentPeriod);
            settlementOrderService.remove(deleteWrapper);
            System.out.println("-> 已删除该服务商本月的旧结算单");

            // 6. 生成新结算单
            SettlementOrder order = new SettlementOrder();
            order.setProviderId(provider.getId());
            order.setSettlementCode("SET-" + System.currentTimeMillis());
            order.setBaseAmount(totalBaseAmount);
            order.setDeductAmount(deductAmount);
            order.setPaidAmount(paidAmount);

            if (latestResultId != null) {
                order.setAssessResultId(latestResultId);
            }

            order.setRemark("根据 " + currentPeriod + " 月考核得分自动结算");
            order.setStatus(0);
            order.setSettlementTime(LocalDateTime.now());
            order.setCreatedAt(LocalDateTime.now());

            System.out.println("-> 准备执行插入: " + order.toString());
            settlementOrderService.save(order);
            System.out.println("-> 数据库插入成功！");

            successCount++;
        }
        System.out.println("=== 结算生成完毕，成功生成 " + successCount + " 条 ===");

        // 记录操作日志
        sysLogService.saveLog("管理员", "生成了 " + currentPeriod + " 月的结算单，共 " + successCount + " 条");

        return Result.success("【结算生成成功】共为 " + successCount + " 家服务商生成了 " + currentPeriod + " 月的结算单！");
    }

    // ====== 3. 管理员审核接口 ======
    @PutMapping("/audit/{id}")
    public Result<String> audit(@PathVariable Long id) {
        SettlementOrder order = settlementOrderService.getById(id);
        if (order == null) {
            return Result.error("结算单不存在");
        }
        // 将状态从 0（待审核） 改为 1（已结算）
        order.setStatus(1);
        settlementOrderService.updateById(order);

        sysLogService.saveLog("管理员", "审核通过结算单 ID:" + id);
        return Result.success("审核通过，已标记为已结算");
    }

    /**
     * 导出结算报表（Excel）
     */
    @GetMapping("/export")
    public void export(@RequestParam(required = false) Long providerId,
                       @RequestParam(required = false) String period,
                       @RequestParam(required = false) Integer status,
                       HttpServletResponse response) throws IOException {

        // 1. 查询数据
        QueryWrapper<SettlementOrder> wrapper = new QueryWrapper<>();
        if (providerId != null) {
            wrapper.eq("provider_id", providerId);
        }
        if (period != null && !period.isEmpty()) {
            wrapper.apply("DATE_FORMAT(created_at, '%Y-%m') = {0}", period);
        }
        if (status != null) {
            wrapper.eq("status", status);
        }
        wrapper.orderByDesc("created_at");

        List<SettlementOrder> orders = settlementOrderService.list(wrapper);

        // 2. 转换为导出DTO
        List<SettlementOrderExportDTO> exportList = orders.stream().map(order -> {
            SettlementOrderExportDTO dto = new SettlementOrderExportDTO();
            dto.setId(order.getId());

            ServiceProvider provider = serviceProviderService.getById(order.getProviderId());
            dto.setProviderName(provider != null ? provider.getCompanyName() : "未知");

            dto.setBaseAmount(order.getBaseAmount());
            dto.setDeductAmount(order.getDeductAmount());
            dto.setPaidAmount(order.getPaidAmount());
            dto.setStatusText(order.getStatus() == 0 ? "待审核" : "已结算");
            dto.setCreatedAt(order.getCreatedAt() != null ? order.getCreatedAt().toString() : "");
            return dto;
        }).collect(Collectors.toList());

        // 3. 导出Excel
        String fileName = "结算报表_" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        ExcelExportUtil.export(response, exportList, SettlementOrderExportDTO.class, fileName);
    }
}