package com.platform.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import com.platform.entity.MunicipalProject;
import java.util.List;

public interface MunicipalProjectService extends IService<MunicipalProject> {
    // 无参版本
    List<MunicipalProject> listWithStatus();

    // 带查询条件的版本
    List<MunicipalProject> listWithStatus(QueryWrapper<MunicipalProject> wrapper);
}