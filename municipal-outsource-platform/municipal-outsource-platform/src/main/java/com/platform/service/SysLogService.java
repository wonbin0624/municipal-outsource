package com.platform.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.platform.entity.SysLog;

public interface SysLogService extends IService<SysLog> {
    void saveLog(String username, String operation);
}