package com.platform.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.platform.entity.MunicipalProject;
import com.platform.mapper.MunicipalProjectMapper;
import com.platform.service.MunicipalProjectService;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class MunicipalProjectServiceImpl extends ServiceImpl<MunicipalProjectMapper, MunicipalProject> implements MunicipalProjectService {

    // 无参版本（兼容旧代码）
    @Override
    public List<MunicipalProject> listWithStatus() {
        return listWithStatus(new QueryWrapper<>());
    }

    // 带查询条件的版本
    @Override
    public List<MunicipalProject> listWithStatus(QueryWrapper<MunicipalProject> wrapper) {
        List<MunicipalProject> projects = this.list(wrapper);
        LocalDate today = LocalDate.now();

        for (MunicipalProject p : projects) {
            if (p.getEndDate() != null && p.getEndDate().isBefore(today)) {
                p.setStatus(2);
            } else if (p.getStartDate() != null && p.getStartDate().isAfter(today)) {
                p.setStatus(0);
            } else {
                p.setStatus(1);
            }
        }
        return projects;
    }
}