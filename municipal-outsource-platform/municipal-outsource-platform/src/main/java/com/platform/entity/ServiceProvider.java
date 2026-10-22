package com.platform.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("service_provider")
public class ServiceProvider {

    @TableId(type = IdType.AUTO)
    private Long id;

    @TableField("company_name")
    private String companyName;

    // 👇 新增三个字段
    @TableField("credit_code")
    private String creditCode;

    @TableField("business_scope")
    private String businessScope;

    @TableField("legal_person")
    private String legalPerson;

    @TableField("contact_person")
    private String contactPerson;

    @TableField("contact_phone")
    private String contactPhone;

    @TableField("address")
    private String address;

    @TableField("status")
    private Integer status;

    @TableField("category")
    private String category;

    @TableField("area")
    private String area;

    @TableField("business_license")
    private String businessLicense;

    @TableField("qualification")
    private String qualification;

    @TableField("qualification_cert")
    private String qualificationCert;

    @TableField("license_expire_date")
    private LocalDate licenseExpireDate;

    @TableField("qualification_expire_date")
    private LocalDate qualificationExpireDate;

    @TableField("credit_rating")
    private String creditRating;

    @TableField("created_at")
    private LocalDateTime createdAt;

    @TableField("updated_at")
    private LocalDateTime updatedAt;

    @TableField(exist = false)
    private String password;
}