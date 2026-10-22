package com.platform.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.platform.entity.SysUserRole;
import org.apache.ibatis.annotations.Mapper;

/**
 * 用户-角色关联 Mapper 接口
 */
@Mapper
public interface SysUserRoleMapper extends BaseMapper<SysUserRole> {
}