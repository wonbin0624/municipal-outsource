package com.platform.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class CorsConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**") // 允许所有路径
                .allowedOriginPatterns("*") // 允许所有来源（前端5173）
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS") // 允许所有请求方式
                .allowCredentials(true)
                .allowedHeaders("*") // 允许所有请求头
                .maxAge(3600);
    }
}