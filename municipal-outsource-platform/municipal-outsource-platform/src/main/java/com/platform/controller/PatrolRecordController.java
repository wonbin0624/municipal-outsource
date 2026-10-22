package com.platform.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.platform.common.Result;
import com.platform.entity.*;
import com.platform.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.platform.service.SysLogService;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/patrol")
@CrossOrigin
public class PatrolRecordController {

    @Autowired
    private PatrolRecordService patrolRecordService;

    @Autowired
    private MunicipalProjectService municipalProjectService;

    @Autowired
    private ServiceProviderService serviceProviderService;

    @Autowired
    private RectifyTaskService rectifyTaskService;

    @Autowired
    private SysLogService sysLogService;   // ← 新增这一行

    @GetMapping("/list")
    public Result<List<PatrolRecord>> list() {
        return Result.success(patrolRecordService.list());
    }

    @PostMapping("/add")
    public Result<String> add(@RequestBody PatrolRecord record) {
        // 1. 生成编号
        record.setPatrolCode("PC-" + System.currentTimeMillis());
        record.setPatrolTime(LocalDateTime.now());
        record.setCreatedAt(LocalDateTime.now());

        // 2. 获取关联的项目名称
        String projectName = "";
        if (record.getProjectId() != null) {
            MunicipalProject project = municipalProjectService.getById(record.getProjectId());
            if (project != null) {
                projectName = project.getName();
            }
        }

        // 3. 智能识别违规类型（关键词匹配）
        String content = record.getContent();
        String type = "其他";

        if (content != null) {
            // ===== 环境卫生 =====
            if (content.contains("垃圾") || content.contains("垃圾桶") || content.contains("垃圾堆") ||
                    content.contains("厕所") || content.contains("公厕") || content.contains("卫生间") ||
                    content.contains("异味") || content.contains("臭味") || content.contains("臭气") ||
                    content.contains("脏乱") || content.contains("污渍") || content.contains("油污") ||
                    content.contains("污水") || content.contains("积水") || content.contains("满地") ||
                    content.contains("清扫") || content.contains("保洁") || content.contains("环卫") ||
                    content.contains("分类") || content.contains("混投") || content.contains("垃圾房") ||
                    content.contains("脏") || content.contains("乱扔") || content.contains("满地垃圾") ||
                    content.contains("恶臭") || content.contains("泔水") || content.contains("油垢") ||
                    content.contains("垃圾未清") || content.contains("垃圾堆积") || content.contains("垃圾满溢")) {
                type = "环境卫生";

                // ===== 绿化养护 =====
            } else if (content.contains("枯死") || content.contains("枯萎") || content.contains("枯黄") ||
                    content.contains("杂草") || content.contains("杂草丛生") ||
                    content.contains("生病") || content.contains("虫蛀") || content.contains("病虫害") ||
                    content.contains("斑秃") || content.contains("裸土") || content.contains("枯草") ||
                    content.contains("修剪") || content.contains("养护") || content.contains("浇水") ||
                    content.contains("花坛") || content.contains("草坪") || content.contains("绿化带") ||
                    content.contains("植被") || content.contains("苗木") || content.contains("枯枝") ||
                    content.contains("干枯") || content.contains("枯叶") || content.contains("落叶") ||
                    content.contains("生长不良") || content.contains("死亡") || content.contains("枯") ||
                    content.contains("植物") || content.contains("绿化") || content.contains("花卉")) {
                type = "绿化养护";

                // ===== 设施维修 =====
            } else if (content.contains("损坏") || content.contains("坏了") || content.contains("破损") ||
                    content.contains("裂") || content.contains("裂缝") || content.contains("断裂") ||
                    content.contains("松动") || content.contains("脱落") || content.contains("缺失") ||
                    content.contains("路灯") || content.contains("照明") || content.contains("灯") ||
                    content.contains("井盖") || content.contains("护栏") || content.contains("围栏") ||
                    content.contains("座椅") || content.contains("健身器材") || content.contains("器材") ||
                    content.contains("门禁") || content.contains("单元门") || content.contains("大门") ||
                    content.contains("电梯") || content.contains("故障") || content.contains("失灵") ||
                    content.contains("水管") || content.contains("破裂") || content.contains("漏水") ||
                    content.contains("指示牌") || content.contains("标识") || content.contains("路牌") ||
                    content.contains("监控") || content.contains("摄像头") ||
                    content.contains("老化") || content.contains("生锈") || content.contains("锈蚀") ||
                    content.contains("不亮") || content.contains("故障")) {
                type = "设施维修";

                // ===== 公共安全 =====
            } else if (content.contains("消防") || content.contains("灭火器") || content.contains("消防通道") ||
                    content.contains("堵塞") || content.contains("占用") || content.contains("杂物") ||
                    content.contains("围墙") || content.contains("倒塌") || content.contains("倾斜") ||
                    content.contains("监控") || content.contains("摄像头") || content.contains("门禁") ||
                    content.contains("安保") || content.contains("保安") || content.contains("巡逻") ||
                    content.contains("流浪狗") || content.contains("流浪猫") || content.contains("动物") ||
                    content.contains("陌生人") || content.contains("传销") || content.contains("可疑") ||
                    content.contains("电动车") || content.contains("充电") || content.contains("私拉电线") ||
                    content.contains("安全隐患") || content.contains("危险") || content.contains("紧急") ||
                    content.contains("安全") || content.contains("防护") || content.contains("隐患")) {
                type = "公共安全";

                // ===== 供水供电 =====
            } else if (content.contains("供水") || content.contains("水压") || content.contains("水") ||
                    content.contains("停电") || content.contains("供电") || content.contains("电压") ||
                    content.contains("水管") || content.contains("管道") || content.contains("爆裂") ||
                    content.contains("水质") || content.contains("浑浊") || content.contains("发黄") ||
                    content.contains("用电") || content.contains("电") || content.contains("线路") ||
                    content.contains("水厂") || content.contains("泵房") || content.contains("水表") ||
                    content.contains("电表") || content.contains("水箱") || content.contains("二次供水") ||
                    content.contains("跳闸") || content.contains("断电") || content.contains("没电") ||
                    content.contains("没水") || content.contains("无水") || content.contains("缺水")) {
                type = "供水供电";

                // ===== 噪音扰民 =====
            } else if (content.contains("噪音") || content.contains("噪声") || content.contains("扰民") ||
                    content.contains("广场舞") || content.contains("音响") || content.contains("喇叭") ||
                    content.contains("施工") || content.contains("工地") || content.contains("打桩") ||
                    content.contains("鸣笛") || content.contains("按喇叭") || content.contains("汽车") ||
                    content.contains("装修") || content.contains("电钻") || content.contains("敲墙") ||
                    content.contains("深夜") || content.contains("凌晨") || content.contains("烧烤") ||
                    content.contains("划拳") || content.contains("喧哗") || content.contains("吵闹") ||
                    content.contains("噪音污染") || content.contains("声") || content.contains("音响声")) {
                type = "噪音扰民";
            }
        }

        record.setPatrolType(type);

        if (record.getResult() == null) {
            record.setResult("发现隐患");
        }

        // 4. 保存巡检记录
        patrolRecordService.save(record);
        // ===== 新增：记录操作日志 =====
        sysLogService.saveLog(
                record.getPatrolPerson(),
                "提交了巡检记录：" + record.getPatrolCode() + "，系统自动识别类型为：" + type
        );

        // 5. 如果发现问题，自动生成整改任务
        if ("1".equals(record.getResult())) {
            MunicipalProject project = municipalProjectService.getById(record.getProjectId());

            Long providerId = null;
            if (project != null && project.getProviderId() != null) {
                QueryWrapper<ServiceProvider> wrapper = new QueryWrapper<>();
                wrapper.eq("company_name", project.getProviderId());
                ServiceProvider provider = serviceProviderService.getOne(wrapper);
                if (provider != null) {
                    providerId = provider.getId();
                }
            }

            RectifyTask task = new RectifyTask();
            task.setPatrolRecordId(record.getId());
            task.setProjectId(record.getProjectId());
            task.setProviderId(providerId);
            task.setTaskCode("RT-" + System.currentTimeMillis());
            task.setDescription(record.getContent());
            task.setDeadline(LocalDateTime.now().plusDays(7));
            task.setStatus(0);
            task.setCreatedAt(LocalDateTime.now());
            rectifyTaskService.save(task);
            System.out.println("已自动生成整改任务: " + task.getTaskCode() + ", 服务商ID: " + providerId);
        }

        return Result.success("巡检提交成功");
    }

    @DeleteMapping("/{id}")
    public Result<String> delete(@PathVariable Long id) {
        patrolRecordService.removeById(id);
        return Result.success("删除成功");
    }
}