package com.platform.utils;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordUtil {

    // 创建一个加密器实例
    private static final BCryptPasswordEncoder ENCODER = new BCryptPasswordEncoder();

    /**
     * 对明文密码进行加密
     */
    public static String encrypt(String rawPassword) {
        return ENCODER.encode(rawPassword);
    }

    /**
     * 校验 明文密码 和 加密密码 是否匹配
     */
    public static boolean matches(String rawPassword, String encodedPassword) {
        return ENCODER.matches(rawPassword, encodedPassword);
    }
}