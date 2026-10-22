package com.platform.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.platform.entity.AssessIndex;
import com.platform.mapper.AssessIndexMapper;
import com.platform.service.AssessIndexService;
import org.springframework.stereotype.Service;

@Service
public class AssessIndexServiceImpl extends ServiceImpl<AssessIndexMapper, AssessIndex> implements AssessIndexService {
}