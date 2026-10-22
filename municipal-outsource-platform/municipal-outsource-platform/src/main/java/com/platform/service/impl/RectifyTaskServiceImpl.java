package com.platform.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.platform.entity.RectifyTask;
import com.platform.mapper.RectifyTaskMapper;
import com.platform.service.RectifyTaskService;
import org.springframework.stereotype.Service;

@Service
public class RectifyTaskServiceImpl extends ServiceImpl<RectifyTaskMapper, RectifyTask> implements RectifyTaskService {
}