package com.platform.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("rectify_task")
public class RectifyTask {

    @TableId(type = IdType.AUTO)
    private Long id;

    @TableField("patrol_record_id")
    private Long patrolRecordId;

    @TableField("project_id")
    private Long projectId;

    @TableField("provider_id")
    private Long providerId;

    @TableField("task_code")
    private String taskCode;

    @TableField("description")
    private String description;

    @TableField("deadline")
    private LocalDateTime deadline;

    @TableField("status")
    private Integer status;

    @TableField("rectify_comment")
    private String rectifyComment;

    @TableField("rectify_images")
    private String rectifyImages;

    @TableField("review_comment")
    private String reviewComment;

    @TableField("created_at")
    private LocalDateTime createdAt;

    @TableField("updated_at")
    private LocalDateTime updatedAt;
    @TableField(exist = false)
    private String projectName;

    @TableField(exist = false)
    private String providerName;
}