package com.platform.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.platform.common.Result;
import com.platform.entity.ServiceProvider;
import com.platform.entity.SysUser;
import com.platform.service.ServiceProviderService;
import com.platform.service.SysLogService;
import com.platform.service.SysUserService;
import com.platform.utils.PasswordUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/provider")
@CrossOrigin
public class ServiceProviderController {

    @Autowired
    private ServiceProviderService providerService;

    @Autowired
    private SysLogService sysLogService;

    @Autowired
    private SysUserService sysUserService;

    @GetMapping("/list")
    public Result<List<ServiceProvider>> list() {
        return Result.success(providerService.list());
    }

    @PostMapping("/add")
    public Result<String> add(@RequestBody ServiceProvider provider) {
        if (provider.getStatus() == null) {
            provider.setStatus(1);
        }
        provider.setCreatedAt(LocalDateTime.now());
        provider.setUpdatedAt(LocalDateTime.now());
        providerService.save(provider);
        sysLogService.saveLog("管理员", "手动添加服务商：" + provider.getCompanyName());
        return Result.success("添加成功");
    }

    @PutMapping("/update")
    public Result<String> update(@RequestBody ServiceProvider provider) {
        provider.setUpdatedAt(LocalDateTime.now());
        providerService.updateById(provider);
        sysLogService.saveLog("管理员", "修改服务商信息：" + provider.getCompanyName());
        return Result.success("修改成功");
    }

    @DeleteMapping("/{id}")
    public Result<String> delete(@PathVariable Long id) {
        ServiceProvider provider = providerService.getById(id);
        if (provider != null) {
            sysLogService.saveLog("管理员", "删除服务商：" + provider.getCompanyName());
        }
        providerService.removeById(id);
        return Result.success("删除成功");
    }

    // ===== 服务商在线入驻申请 =====
    @PostMapping("/register")
    public Result<String> register(@RequestBody ServiceProvider provider) {
        // 1. 校验公司名称是否已存在
        QueryWrapper<ServiceProvider> wrapper = new QueryWrapper<>();
        wrapper.eq("company_name", provider.getCompanyName());
        if (providerService.count(wrapper) > 0) {
            return Result.error("该公司名称已存在，请勿重复申请");
        }

        // 2. 校验必填字段
        if (provider.getCompanyName() == null || provider.getCompanyName().isEmpty()) {
            return Result.error("请填写公司名称");
        }
        if (provider.getContactPerson() == null || provider.getContactPerson().isEmpty()) {
            return Result.error("请填写联系人");
        }
        if (provider.getContactPhone() == null || provider.getContactPhone().isEmpty()) {
            return Result.error("请填写联系电话");
        }
        if (provider.getPassword() == null || provider.getPassword().isEmpty()) {
            return Result.error("请设置登录密码");
        }

        // 3. 设置默认状态为 0（待审核）
        provider.setStatus(0);
        provider.setCreatedAt(LocalDateTime.now());
        provider.setUpdatedAt(LocalDateTime.now());

        // 4. 保存服务商
        providerService.save(provider);

        // 5. 👇 自动创建服务商登录账号
        SysUser user = new SysUser();
        user.setUsername(provider.getCompanyName());
        user.setPassword(PasswordUtil.encrypt(provider.getPassword()));
        user.setRealName(provider.getContactPerson());
        user.setPhone(provider.getContactPhone());
        user.setRole("provider");
        user.setStatus(0);  // 账号状态为 0（待审核）
        user.setCreateTime(LocalDateTime.now());
        sysUserService.save(user);

        // 6. 记录操作日志
        sysLogService.saveLog("系统", "服务商入驻申请：" + provider.getCompanyName() + "，账号已创建");

        return Result.success("入驻申请已提交，账号已创建，请等待管理员审核！");
    }

    // ===== 管理员审核通过 =====
    @PutMapping("/audit/{id}")
    public Result<String> audit(@PathVariable Long id) {
        ServiceProvider provider = providerService.getById(id);
        if (provider == null) {
            return Result.error("服务商不存在");
        }

        // 1. 更新服务商状态
        provider.setStatus(1);
        provider.setUpdatedAt(LocalDateTime.now());
        providerService.updateById(provider);

        // 2. 👇 同时启用对应的用户账号
        QueryWrapper<SysUser> userWrapper = new QueryWrapper<>();
        userWrapper.eq("username", provider.getCompanyName());
        userWrapper.eq("role", "provider");
        SysUser user = sysUserService.getOne(userWrapper);
        if (user != null) {
            user.setStatus(1);
            sysUserService.updateById(user);
            sysLogService.saveLog("管理员", "审核通过服务商入驻：" + provider.getCompanyName() + "，账号已启用");
        } else {
            sysLogService.saveLog("管理员", "审核通过服务商入驻：" + provider.getCompanyName() + "，但未找到对应账号");
        }

        return Result.success("审核通过，服务商已入驻，账号已启用");
    }

    // ===== 管理员驳回 =====
    @PutMapping("/reject/{id}")
    public Result<String> reject(@PathVariable Long id, @RequestBody(required = false) Map<String, String> params) {
        ServiceProvider provider = providerService.getById(id);
        if (provider == null) {
            return Result.error("服务商不存在");
        }

        provider.setStatus(2);
        provider.setUpdatedAt(LocalDateTime.now());
        providerService.updateById(provider);

        String reason = params != null ? params.getOrDefault("reason", "未填写驳回原因") : "未填写驳回原因";
        sysLogService.saveLog("管理员", "驳回服务商入驻：" + provider.getCompanyName() + "，原因：" + reason);

        return Result.success("已驳回");
    }
}