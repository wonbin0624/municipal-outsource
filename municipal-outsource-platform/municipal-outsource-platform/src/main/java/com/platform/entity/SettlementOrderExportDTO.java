package com.platform.entity;

import com.alibaba.excel.annotation.ExcelProperty;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class SettlementOrderExportDTO {

    @ExcelProperty("结算单号")
    private Long id;

    @ExcelProperty("服务商")
    private String providerName;

    @ExcelProperty("基础服务费")
    private BigDecimal baseAmount;

    @ExcelProperty("扣减金额")
    private BigDecimal deductAmount;

    @ExcelProperty("实发金额")
    private BigDecimal paidAmount;

    @ExcelProperty("状态")
    private String statusText;

    @ExcelProperty("结算时间")
    private String createdAt;
}