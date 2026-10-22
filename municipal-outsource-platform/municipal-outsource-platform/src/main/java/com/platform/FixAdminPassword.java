package com.platform;

import org.springframework.web.client.RestTemplate;
import java.util.HashMap;
import java.util.Map;

public class FixAdminPassword {
    public static void main(String[] args) {
        RestTemplate rest = new RestTemplate();
        // 注意：这必须是你后端正在运行的端口
        String url = "http://localhost:8080/api/user/update";

        Map<String, Object> user = new HashMap<>();
        user.put("id", 1); // 假设 admin 的 id 是 1
        user.put("username", "admin");
        user.put("password", "123456"); // 这里强制改成明文 123456！
        user.put("realName", "超级管理员");
        user.put("status", 1);

        try {
            System.out.println("正在强制修改 admin 密码为明文 123456...");
            rest.put(url, user);
            System.out.println("✅ 修改成功！请去重启后端，然后用 admin/123456 登录！");
        } catch (Exception e) {
            System.out.println("❌ 修改失败，请检查后端是否已启动，或者 admin 的 id 是不是 1。");
            e.printStackTrace();
        }
    }
}