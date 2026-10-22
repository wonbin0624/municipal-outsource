package com.platform.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.platform.entity.CitizenWorkorder;
import com.platform.mapper.CitizenWorkorderMapper;
import com.platform.service.CitizenWorkorderService;
import org.springframework.stereotype.Service;

@Service
public class CitizenWorkorderServiceImpl extends ServiceImpl<CitizenWorkorderMapper, CitizenWorkorder> implements CitizenWorkorderService {
}