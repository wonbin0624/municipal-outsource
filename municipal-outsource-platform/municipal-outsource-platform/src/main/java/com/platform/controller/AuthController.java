package com.platform.controller;

import com.platform.common.Result;
import com.platform.entity.LoginDTO;
import com.platform.entity.SysUser;
import com.platform.service.SysUserService;
import com.platform.utils.PasswordUtil;
import com.platform.utils.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@CrossOrigin
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private SysUserService sysUserService;

    @PostMapping("/login")
    public Result<Map<String, Object>> login(@RequestBody LoginDTO loginDTO) {

        // 1. 根据前端传来的用户名去数据库查询用户
        SysUser user = sysUserService.list().stream()
                .filter(u -> u.getUsername().equals(loginDTO.getUsername()))
                .findFirst()
                .orElse(null);

        // 2. 验证账号是否存在
        if (user == null) {
            return Result.error("用户名不存在");
        }

        // 3. 验证密码是否正确（只用加密比对，不支持明文）
        String inputPassword = loginDTO.getPassword();
        String dbPassword = user.getPassword();

        // 只用 BCrypt 加密比对
        boolean isPasswordCorrect = PasswordUtil.matches(inputPassword, dbPassword);

        if (!isPasswordCorrect) {
            return Result.error("密码错误");
        }

        // 4. 登录成功！生成JWT Token
        String token = JwtUtil.generateToken(user.getUsername(), user.getRole());

        Map<String, Object> data = new HashMap<>();
        data.put("id", user.getId());
        data.put("username", user.getUsername());
        data.put("realName", user.getRealName());
        data.put("role", user.getRole());
        data.put("status", user.getStatus());
        data.put("token", token);

        return Result.success(data);
    }
}