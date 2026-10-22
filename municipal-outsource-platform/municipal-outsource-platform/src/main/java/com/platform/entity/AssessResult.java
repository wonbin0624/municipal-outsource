package com.platform.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("assess_result")
public class AssessResult {

    @TableId(type = IdType.AUTO)
    private Long id;

    // 对应表里的 project_id
    @TableField("project_id")
    private Long projectId;

    // 对应表里的 assess_period
    @TableField("assess_period")
    private String assessPeriod;

    @TableField(exist = false)
    private String projectName;      // 项目名称

    @TableField(exist = false)
    private String providerName;     // 服务商名称

    // 对应表里的 total_score
    @TableField("total_score")
    private BigDecimal totalScore;

    // 对应表里的 comment
    private String comment;

    // 对应表里的 status
    private Integer status;

    // 对应表里的 assess_time
    @TableField("assess_time")
    private LocalDateTime assessTime;

    // 对应表里的 created_at
    @TableField("created_at")
    private LocalDateTime createdAt;
}