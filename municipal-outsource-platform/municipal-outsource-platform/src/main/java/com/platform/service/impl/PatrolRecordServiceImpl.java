package com.platform.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.platform.entity.PatrolRecord;
import com.platform.mapper.PatrolRecordMapper;
import com.platform.service.PatrolRecordService;
import org.springframework.stereotype.Service; // <--- 这个注解必须要有！

@Service // <--- 确保这里有 @Service
public class PatrolRecordServiceImpl extends ServiceImpl<PatrolRecordMapper, PatrolRecord> implements PatrolRecordService {
}