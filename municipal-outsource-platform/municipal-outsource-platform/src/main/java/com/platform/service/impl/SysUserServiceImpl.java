package com.platform.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.platform.entity.SysLog;
import com.platform.entity.SysUser;
import com.platform.mapper.SysLogMapper;
import com.platform.mapper.SysUserMapper;
import com.platform.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUser> implements SysUserService {

    @Autowired
    private SysLogMapper sysLogMapper; // 注入日志Mapper

    @Override
    public void saveLog(String username, String operation) {
        SysLog log = new SysLog();
        log.setUsername(username);
        log.setOperation(operation);
        log.setCreatedAt(LocalDateTime.now());
        sysLogMapper.insert(log);
    }

    @Override
    public List<SysLog> listLogs(QueryWrapper<SysLog> wrapper) {
        return sysLogMapper.selectList(wrapper);
    }
}