package com.platform.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.platform.entity.SettlementOrder;
import com.platform.mapper.SettlementOrderMapper;
import com.platform.service.SettlementOrderService;
import org.springframework.stereotype.Service;

@Service
public class SettlementOrderServiceImpl extends ServiceImpl<SettlementOrderMapper, SettlementOrder> implements SettlementOrderService {
}