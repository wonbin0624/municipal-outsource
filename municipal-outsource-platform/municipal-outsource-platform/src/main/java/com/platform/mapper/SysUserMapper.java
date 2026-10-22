package com.platform.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.platform.entity.SysUser;
import org.apache.ibatis.annotations.Mapper;

/**
 * 系统用户 Mapper 接口
 */
@Mapper
public interface SysUserMapper extends BaseMapper<SysUser> {
    // 基础 CRUD 由 BaseMapper 提供，无需写任何方法
    // 如需复杂查询，在这里添加自定义方法
}