package com.platform.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.platform.entity.ServiceProvider;
import com.platform.mapper.ServiceProviderMapper;
import com.platform.service.ServiceProviderService;
import org.springframework.stereotype.Service;

@Service
public class ServiceProviderServiceImpl extends ServiceImpl<ServiceProviderMapper, ServiceProvider> implements ServiceProviderService {
}