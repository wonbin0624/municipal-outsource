package com.platform.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.platform.entity.AssessResult;
import com.platform.mapper.AssessResultMapper;
import com.platform.service.AssessResultService;
import org.springframework.stereotype.Service;

@Service
public class AssessResultServiceImpl extends ServiceImpl<AssessResultMapper, AssessResult> implements AssessResultService {
}