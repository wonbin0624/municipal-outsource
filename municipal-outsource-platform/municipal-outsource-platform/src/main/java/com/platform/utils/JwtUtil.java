package com.platform.utils;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Component
public class JwtUtil {

    // 秘钥（实际项目应该配置在application.yml里）
    private static final String SECRET = "municipal_platform_secret_key_2026";

    // 过期时间（7天）
    private static final long EXPIRE = 1000 * 60 * 60 * 24 * 7;

    /**
     * 生成JWT令牌
     */
    public static String generateToken(String username, String role) {
        Map<String, Object> claims = new HashMap<>();
        claims.put("username", username);
        claims.put("role", role);
        return Jwts.builder()
                .setClaims(claims)
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRE))
                .signWith(SignatureAlgorithm.HS256, SECRET)
                .compact();
    }

    /**
     * 解析JWT令牌
     */
    public static Claims parseToken(String token) {
        return Jwts.parser()
                .setSigningKey(SECRET)
                .parseClaimsJws(token)
                .getBody();
    }

    /**
     * 从token中获取用户名
     */
    public static String getUsername(String token) {
        return parseToken(token).get("username", String.class);
    }

    /**
     * 从token中获取角色
     */
    public static String getRole(String token) {
        return parseToken(token).get("role", String.class);
    }

    /**
     * 验证token是否有效
     */
    public static boolean validateToken(String token) {
        try {
            parseToken(token);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}