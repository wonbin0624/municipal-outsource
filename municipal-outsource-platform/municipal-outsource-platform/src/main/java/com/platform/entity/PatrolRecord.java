package com.platform.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("patrol_record")
public class PatrolRecord {

    @TableId(type = IdType.AUTO)
    private Long id;

    // 关联的项目 ID
    @TableField("project_id")
    private Long projectId;

    // 巡查编号（数据库表里没有的话可以忽略，或者后端自动生成）
    @TableField("patrol_code")
    private String patrolCode;

    // 巡查类型（如果数据库表里是 patrol_type）
    @TableField("patrol_type")
    private String patrolType;

    // 巡查内容
    @TableField("content")
    private String content;

    // 巡查结果
    @TableField("result")
    private String result;

    // 巡查人
    @TableField("patrol_person")
    private String patrolPerson;

    // 巡查时间
    @TableField("patrol_time")
    private LocalDateTime patrolTime;

    // 图片链接
    @TableField("img_url")
    private String imgUrl;

    // 创建时间
    @TableField("created_at")
    private LocalDateTime createdAt;

    // 更新时间
    @TableField("updated_at")
    private LocalDateTime updatedAt;
}