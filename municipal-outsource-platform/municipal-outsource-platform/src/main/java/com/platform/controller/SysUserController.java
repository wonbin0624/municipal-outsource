package com.platform.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.platform.common.Result;
import com.platform.entity.SysLog;
import com.platform.entity.SysUser;
import com.platform.service.SysUserService;
import com.platform.utils.PasswordUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/user")
@CrossOrigin
public class SysUserController {

    @Autowired
    private SysUserService sysUserService;

    /**
     * 查询所有用户
     */
    @GetMapping("/list")
    public Result<List<SysUser>> list() {
        List<SysUser> list = sysUserService.list();
        return Result.success(list);
    }

    // ================= 新增：获取操作日志列表接口 =================
    @GetMapping("/logs")
    public Result<List<SysLog>> logs() {
        // 按时间倒序排列，最新的在最上面
        QueryWrapper<SysLog> wrapper = new QueryWrapper<>();
        wrapper.orderByDesc("created_at");
        return Result.success(sysUserService.listLogs(wrapper));
    }

    // ================= 增删改接口 =================

    /**
     * 新增用户
     */
    @PostMapping("/add")
    public Result<String> add(@RequestBody SysUser user) {
        // 1. 如果前端没传角色，默认给普通巡查员
        if (user.getRole() == null || user.getRole().isEmpty()) {
            user.setRole("inspector");
        }

        // 2. 将前端传来的明文密码进行加密
        String encryptedPassword = PasswordUtil.encrypt(user.getPassword());
        user.setPassword(encryptedPassword);


        // 4. 保存用户
        sysUserService.save(user);

        // 👇 记录日志：添加用户
        sysUserService.saveLog("管理员", "添加了用户: " + user.getUsername());

        return Result.success("添加成功");
    }

    /**
     * 根据ID删除用户
     */
    @DeleteMapping("/{id}")
    public Result<String> delete(@PathVariable Long id) {
        // 👇 删除前先把名字查出来（为了记录日志）
        SysUser user = sysUserService.getById(id);
        String username = user != null ? user.getUsername() : "未知用户";

        sysUserService.removeById(id);

        // 👇 记录日志：删除用户
        sysUserService.saveLog("管理员", "删除了用户: " + username);

        return Result.success("删除成功");
    }

    /**
     * 修改用户信息
     */
    @PutMapping("/update")
    public Result<String> update(@RequestBody SysUser user) {
        // 【关键修复】：如果前端传了密码，并且不是空字符串，才进行加密
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            String encryptedPassword = PasswordUtil.encrypt(user.getPassword());
            user.setPassword(encryptedPassword);
        } else {
            // 如果前端没传密码，说明只是改角色和状态，不碰原来的密码！
            user.setPassword(null);
        }

        sysUserService.updateById(user);
        return Result.success("修改成功");
    }
}