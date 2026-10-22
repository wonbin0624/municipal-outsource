package com.platform.config;

import com.platform.utils.JwtUtil;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 放行 OPTIONS 请求（跨域预检）
        if ("OPTIONS".equals(request.getMethod())) {
            return true;
        }

        // 从请求头获取 token
        String token = request.getHeader("Authorization");
        if (token == null || token.isEmpty()) {
            response.setStatus(401);
            response.getWriter().write("{\"code\":401,\"msg\":\"未登录，请先登录\"}");
            return false;
        }

        // 去掉 "Bearer " 前缀
        if (token.startsWith("Bearer ")) {
            token = token.substring(7);
        }

        // 验证 token
        if (!JwtUtil.validateToken(token)) {
            response.setStatus(401);
            response.getWriter().write("{\"code\":401,\"msg\":\"登录已过期，请重新登录\"}");
            return false;
        }

        // 把用户名和角色存入请求属性，供后续使用
        request.setAttribute("username", JwtUtil.getUsername(token));
        request.setAttribute("role", JwtUtil.getRole(token));

        return true;
    }
}