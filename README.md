# 市政外包一体化平台 (Municipal Outsourcing Platform)

> 一个基于 SpringBoot + Vue3 开发的前后端分离市政外包服务管理平台。

## 项目简介
本项目面向市政外包业务场景，致力于解决传统外包服务中**信息分散、人工核算易错、权限管控难**等问题。系统实现了外包服务商全生命周期管理、服务考核评分自动核算、分级扣费以及数据可视化统计的完整业务闭环。满足市政外包业务规范化、数字化的管理需求。

## 技术栈
*   **后端：** Java (JDK 8+)、SpringBoot、MyBatis (或 MyBatis-Plus)、JWT (登录鉴权)
*   **前端：** Vue3 (Composition API)、Element Plus、Axios、Vite、Pinia
*   **数据库：** MySQL 5.7 / 8.0
*   **构建工具：** Maven

## 核心功能与技术亮点

### 1. RBAC 权限与安全管控
*   基于角色的权限控制（RBAC），严格区分管理员与服务商等不同角色，实现页面与接口级别的访问控制。
*   结合 JWT 实现无状态登录校验，通过全局拦截器拦截未登录请求，保障业务数据访问安全。

### 2. 服务商档案管理
*   支持外包服务商信息录入、编辑、查询与状态管理，统一维护基础档案。
*   提供多维度条件筛选与分页查询，方便快速检索服务商资料。

### 3. 智能考核与分级扣费（核心业务）
*   支持考核分数的灵活录入，系统内置自动化结算规则（如：分数 < 60 扣除 20% 服务费；60 ≤ 分数 < 80 扣除 10% 服务费）。
*   *(亮点)* 扣费规则基于策略模式设计，便于后续扩展不同级别的考核标准，降低代码耦合度。
*   系统根据得分自动计算结算金额，一键生成本次结算记录，彻底告别人工计算失误。

### 4. 数据追溯与统计留存
*   全量保存每一次考核记录与扣费明细，支持历史数据溯源。
*   前端提供清晰的考核记录列表，支持查看历史评分和扣费详情。

## 快速启动指南

### 1. 环境准备
*   JDK 8 或更高版本
*   MySQL 5.7 或 8.0
*   Maven 3.6+
*   Node.js (建议 16+)
*   IntelliJ IDEA / VS Code

### 2. 数据库配置（一键还原）
1. 在本地 MySQL 中创建一个名为 `municipal_outsource` 的数据库。
2. 导入本项目根目录下的 `municipal_outsource.sql` 脚本（已包含建表语句和测试数据）。
3. 检查并修改 `application.yml` 中的数据库连接信息（默认账号为 root，密码为 123456）：

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/municipal_outsource?useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai
    username: root
    password: 123456
