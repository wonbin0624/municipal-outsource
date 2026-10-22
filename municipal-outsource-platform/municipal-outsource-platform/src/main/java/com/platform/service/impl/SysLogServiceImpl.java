package com.platform.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.platform.entity.SysLog;
import com.platform.mapper.SysLogMapper;
import com.platform.service.SysLogService;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class SysLogServiceImpl extends ServiceImpl<SysLogMapper, SysLog> implements SysLogService {

    @Override
    public void saveLog(String username, String operation) {
        SysLog log = new SysLog();
        log.setUsername(username);
        log.setOperation(operation);
        log.setCreatedAt(LocalDateTime.now());
        this.save(log);
    }
}