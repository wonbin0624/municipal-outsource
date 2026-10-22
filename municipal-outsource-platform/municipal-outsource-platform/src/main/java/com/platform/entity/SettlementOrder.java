package com.platform.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("settlement_order")
public class SettlementOrder {

    @TableId(type = IdType.AUTO)
    private Long id;

    // 对应表里的 assess_result_id
    @TableField("assess_result_id")
    private Long assessResultId;

    // 对应表里的 provider_id
    @TableField("provider_id")
    private Long providerId;

    // 对应表里的 settlement_code
    @TableField("settlement_code")
    private String settlementCode;

    // 对应表里的 base_amount
    @TableField("base_amount")
    private BigDecimal baseAmount;

    // 对应表里的 deduct_amount
    @TableField("deduct_amount")
    private BigDecimal deductAmount;

    // 对应表里的 paid_amount
    @TableField("paid_amount")
    private BigDecimal paidAmount;

    // 对应表里的 remark
    private String remark;

    // 对应表里的 status
    private Integer status;

    // 👇 新增：对应表里的 settlement_time (不让它为空)
    @TableField("settlement_time")
    private LocalDateTime settlementTime;

    // 对应表里的 created_at
    @TableField("created_at")
    private LocalDateTime createdAt;

    // 对应表里的 updated_at
    @TableField("updated_at")
    private LocalDateTime updatedAt;
}