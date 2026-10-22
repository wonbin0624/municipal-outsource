package com.platform.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import com.platform.entity.SysLog;
import com.platform.entity.SysUser;

import java.util.List;

public interface SysUserService extends IService<SysUser> {
    // 写入日志的方法
    void saveLog(String username, String operation);

    // 新增：读取日志列表的方法
    List<SysLog> listLogs(QueryWrapper<SysLog> wrapper);
}