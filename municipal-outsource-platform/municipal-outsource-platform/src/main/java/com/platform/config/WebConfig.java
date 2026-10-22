package com.platform.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Autowired
    private AuthInterceptor authInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(authInterceptor)
                .addPathPatterns("/api/**")
                .excludePathPatterns(
                        "/api/auth/login",
                        "/api/auth/register",
                        "/api/user/add",
                        "/api/provider/register",
                        "/api/file/upload",
                        "/api/provider/{id}",
                        "/api/user/logs",
                        "/api/settlement/export"
                );
    }

    // 👇 新增：配置静态资源访问
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:D:/municipal-outsource/uploads/");
        System.out.println("===== 静态资源映射已配置: /uploads/** -> file:D:/municipal-outsource/uploads/ =====");
    }
}