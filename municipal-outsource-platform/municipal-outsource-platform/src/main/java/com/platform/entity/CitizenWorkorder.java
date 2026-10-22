package com.platform.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("citizen_workorder")
public class CitizenWorkorder {

    @TableId(type = IdType.AUTO)
    private Long id;

    @TableField("project_id")
    private Long projectId;

    @TableField("provider_id")
    private Long providerId;

    @TableField("workorder_code")
    private String workorderCode;

    @TableField("citizen_name")
    private String citizenName;

    @TableField("citizen_phone")
    private String citizenPhone;

    @TableField("content")
    private String content;

    @TableField("category")
    private String category;
    @TableField("area")
    private String area;

    @TableField("submit_time")
    private LocalDateTime submitTime;

    @TableField("finish_time")
    private LocalDateTime finishTime;

    @TableField("status")
    private Integer status;

    @TableField("created_at")
    private LocalDateTime createdAt;

    @TableField("updated_at")
    private LocalDateTime updatedAt;

    @TableField("comment")
    private String comment;  // 整改说明

    @TableField("images")
    private String images;  // 整改照片，多张用逗号分隔

    @TableField("satisfaction")
    private String satisfaction;

    @TableField("evaluation")
    private String evaluation;

    @TableField("evaluated_at")
    private LocalDateTime evaluatedAt;
}