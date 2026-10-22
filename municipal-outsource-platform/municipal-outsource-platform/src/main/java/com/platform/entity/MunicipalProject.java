package com.platform.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDate;

@Data
@TableName("municipal_project")
public class MunicipalProject {

    @TableId(type = IdType.AUTO)
    private Long id;

    // 项目名称
    @TableField("project_name")
    private String name;

    // 合同编号
    @TableField("project_code")
    private String contractNo;

    // 服务商名称 (已改为 String 接收)
    @TableField("provider_id")
    private String providerId;

    // 所属片区
    @TableField("project_type")
    private String area;

    // 月度费用
    @TableField("budget_amount")
    private BigDecimal amount;

    // 状态
    @TableField("status")
    private Integer status;

    @TableField("start_date")
    private LocalDate startDate;

    @TableField("end_date")
    private LocalDate endDate;
}