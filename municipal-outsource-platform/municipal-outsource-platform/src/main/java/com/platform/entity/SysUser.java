package com.platform.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.time.LocalDateTime;

/**
 * 系统用户实体类
 */
@Data
@TableName("sys_user")
public class SysUser {

    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 登录用户名
     */
    private String username;

    /**
     * 登录密码（加密存储）
     */
    private String password;

    /**
     * 真实姓名
     */
    private String realName;

    /**
     * 手机号
     */
    private String phone;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 状态：0-禁用，1-启用
     */
    private Integer status;

    /**
     * 用户角色: admin 管理员, inspector 巡查员, provider 服务商
     */
    @TableField("role")
    private String role;

    /**
     * 创建时间
     */
    @TableField("created_at")
    private LocalDateTime createTime;

    /**
     * 更新时间
     */
    @TableField("updated_at")
    private LocalDateTime updateTime;
}