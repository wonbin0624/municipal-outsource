package com.platform.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.platform.common.Result;
import com.platform.entity.AssessIndex;
import com.platform.entity.AssessResult;
import com.platform.entity.CitizenWorkorder;
import com.platform.entity.MunicipalProject;
import com.platform.entity.PatrolRecord;
import com.platform.entity.RectifyTask;
import com.platform.entity.ServiceProvider;
import com.platform.service.AssessIndexService;
import com.platform.service.AssessResultService;
import com.platform.service.CitizenWorkorderService;
import com.platform.service.MunicipalProjectService;
import com.platform.service.PatrolRecordService;
import com.platform.service.RectifyTaskService;
import com.platform.service.ServiceProviderService;
import com.platform.service.SysLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/assessResult")
@CrossOrigin
public class AssessResultController {

    @Autowired
    private AssessResultService assessResultService;

    @Autowired
    private MunicipalProjectService municipalProjectService;

    @Autowired
    private PatrolRecordService patrolRecordService;

    @Autowired
    private SysLogService sysLogService;

    // ===== 新增4个注入 =====
    @Autowired
    private AssessIndexService assessIndexService;

    @Autowired
    private RectifyTaskService rectifyTaskService;

    @Autowired
    private CitizenWorkorderService citizenWorkorderService;

    @Autowired
    private ServiceProviderService serviceProviderService;

    @GetMapping("/list")
    public Result<List<AssessResult>> list() {
        List<AssessResult> list = assessResultService.list();
        if (list.isEmpty()) {
            return Result.success(list);
        }

        List<MunicipalProject> projects = municipalProjectService.list();
        Map<Long, MunicipalProject> projectMap = projects.stream()
                .collect(Collectors.toMap(MunicipalProject::getId, p -> p));

        for (AssessResult result : list) {
            MunicipalProject project = projectMap.get(result.getProjectId());
            if (project != null) {
                result.setProjectName(project.getName());
                result.setProviderName(project.getProviderId());
            }
        }

        return Result.success(list);
    }

    // ======= 智能核算逻辑（加权求和）=======
    @PostMapping("/calculate")
    public Result<String> calculate() {
        String currentPeriod = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM"));

        List<MunicipalProject> projects = municipalProjectService.list();
        if (projects.isEmpty()) {
            return Result.error("暂无项目数据，无法进行考核核算！");
        }

        // 1. 读取管理员配置的考核指标权重
        List<AssessIndex> indexes = assessIndexService.list(
                new QueryWrapper<AssessIndex>().eq("status", 1));
        Map<String, BigDecimal> weightMap = indexes.stream()
                .collect(Collectors.toMap(AssessIndex::getIndexCode, AssessIndex::getWeight));

        BigDecimal wPass    = weightMap.getOrDefault("PJ-001", new BigDecimal("40"));
        BigDecimal wRectify = weightMap.getOrDefault("PJ-002", new BigDecimal("40"));
        BigDecimal wSatisfy = weightMap.getOrDefault("PJ-003", new BigDecimal("20"));

        int count = 0;
        for (MunicipalProject project : projects) {
            // 先删除该项目的旧考核记录
            QueryWrapper<AssessResult> deleteWrapper = new QueryWrapper<>();
            deleteWrapper.eq("project_id", project.getId());
            deleteWrapper.eq("assess_period", currentPeriod);
            assessResultService.remove(deleteWrapper);

            // ===== 指标1：巡检合格率 =====
            QueryWrapper<PatrolRecord> patrolQuery = new QueryWrapper<>();
            patrolQuery.eq("project_id", project.getId());
            List<PatrolRecord> records = patrolRecordService.list(patrolQuery);
            int totalPatrol = records.size();
            int problemCount = 0;
            for (PatrolRecord r : records) {
                if ("1".equals(r.getResult())) problemCount++;
            }
            double passRate = totalPatrol == 0 ? 1.0
                    : (double) (totalPatrol - problemCount) / totalPatrol;

            // ===== 指标2：整改完成率 =====
            QueryWrapper<RectifyTask> taskQuery = new QueryWrapper<>();
            taskQuery.eq("project_id", project.getId());
            List<RectifyTask> tasks = rectifyTaskService.list(taskQuery);
            int totalTask = tasks.size();
            int completedTask = 0;
            for (RectifyTask t : tasks) {
                if (t.getStatus() != null && t.getStatus() == 3) completedTask++;
            }
            double rectifyRate = totalTask == 0 ? 1.0
                    : (double) completedTask / totalTask;

            // ===== 指标3：市民满意率 =====
            QueryWrapper<ServiceProvider> providerQuery = new QueryWrapper<>();
            providerQuery.eq("company_name", project.getProviderId());
            ServiceProvider provider = serviceProviderService.getOne(providerQuery);

            double satisfyRate = 1.0;
            if (provider != null) {
                QueryWrapper<CitizenWorkorder> woQuery = new QueryWrapper<>();
                woQuery.eq("provider_id", provider.getId());
                woQuery.isNotNull("satisfaction");
                List<CitizenWorkorder> evaluated = citizenWorkorderService.list(woQuery);
                if (!evaluated.isEmpty()) {
                    int satisfied = 0;
                    for (CitizenWorkorder w : evaluated) {
                        try {
                            if (Integer.parseInt(w.getSatisfaction()) >= 4) satisfied++;
                        } catch (NumberFormatException ignored) {
                        }
                    }
                    satisfyRate = (double) satisfied / evaluated.size();
                }
            }

            // ===== 加权求和 =====
            double totalScore = passRate * wPass.doubleValue()
                    + rectifyRate * wRectify.doubleValue()
                    + satisfyRate * wSatisfy.doubleValue();
            BigDecimal finalScore = BigDecimal.valueOf(totalScore)
                    .setScale(2, RoundingMode.HALF_UP);

            // 保存
            AssessResult result = new AssessResult();
            result.setProjectId(project.getId());
            result.setAssessPeriod(currentPeriod);
            result.setTotalScore(finalScore);
            result.setComment(String.format(
                    "巡检%d次，问题%d次，合格率%.1f%%；整改完成率%.1f%%；满意率%.1f%%",
                    totalPatrol, problemCount,
                    passRate * 100, rectifyRate * 100, satisfyRate * 100));
            result.setStatus(1);
            result.setAssessTime(LocalDateTime.now());
            result.setCreatedAt(LocalDateTime.now());

            assessResultService.save(result);
            count++;
        }

        sysLogService.saveLog("管理员", "执行了智能考核核算，生成了 " + count + " 条考核记录");

        return Result.success("智能核算完成！共为 " + count + " 个项目生成了 " + currentPeriod + " 月的考核记录。");
    }

    // ======= 人工微调接口 =======
    @PutMapping("/adjust")
    public Result<String> adjust(@RequestBody AssessResult adjustData) {
        AssessResult old = assessResultService.getById(adjustData.getId());
        if (old == null) {
            return Result.error("考核记录不存在");
        }

        String oldScore = old.getTotalScore() != null ? old.getTotalScore().toString() : "null";
        String newScore = adjustData.getTotalScore() != null ? adjustData.getTotalScore().toString() : "null";

        sysLogService.saveLog("管理员",
                "人工微调考核结果 ID:" + old.getId() +
                        "，项目ID:" + old.getProjectId() +
                        "，分数从 " + oldScore + " 调整为 " + newScore +
                        (adjustData.getComment() != null ? "，备注：" + adjustData.getComment() : ""));

        old.setTotalScore(adjustData.getTotalScore());
        if (adjustData.getComment() != null && !adjustData.getComment().isEmpty()) {
            old.setComment(adjustData.getComment());
        }
        old.setStatus(1);

        assessResultService.updateById(old);

        return Result.success("调整成功，已记录操作日志");
    }
}