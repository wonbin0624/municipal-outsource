package com.platform.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("assess_index")
public class AssessIndex {

    @TableId(type = IdType.AUTO)
    private Long id;

    @TableField("index_name")
    private String indexName;

    @TableField("index_code")
    private String indexCode;

    @TableField("weight")
    private BigDecimal weight;

    private String description;

    private Integer status;

    @TableField("created_at")
    private LocalDateTime createdAt;
}