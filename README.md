# 市政外包一体化平台 (Municipal Outsourcing Platform)

> 一个基于 SpringBoot + Vue3 开发的市政外包服务管理平台。


## 项目简介
本项目面向市政外包业务场景，实现外包服务商管理、服务考核评分、费用结算的完整业务闭环。后端基于SpringBoot开发接口，前端使用Vue3实现页面交互；重点实现考核评分自动核算、分级扣费规则、权限管控、数据统计展示，满足市政外包业务的规范化管理需求。

## 技术栈
*   **后端语言**：Java (JDK 8+)
*   **Web核心**：SpringBoot, MyBatis
*   **数据库与持久层**：MySQL
*   **前端技术**：Vue3, Element Plus, Axios
*   **运行环境**：Maven

## 核心功能与技术亮点
### 1. 权限与用户管理
*   基于角色的权限控制，区分管理员、服务商等不同角色，控制页面与接口访问权限。
*   实现登录校验，拦截未登录请求，保障业务数据访问安全。

### 2. 服务商信息管理
*   支持外包服务商信息录入、编辑、查询、状态管理，统一维护服务商基础档案。
*   提供条件筛选、分页查询，方便快速检索服务商资料。

### 3. 考核评分与分级扣费（核心业务）
*   支持录入考核分数，系统内置结算规则：分数低于60分扣除20%服务费，低于80分扣除10%服务费。
*   根据考核得分自动计算结算金额，生成本次考核结算记录，减少人工计算失误。

### 4. 数据统计与记录留存
*   保存每一次考核记录、扣费明细，可追溯历史考核与结算数据。
*   前端展示考核记录列表，支持查看历史评分和扣费详情。

## 快速启动指南
### 1. 环境准备
*   JDK 8 或更高版本
*   MySQL 5.7 或 8.0
*   Maven 3.6+
*   IntelliJ IDEA / VS Code

### 2. 数据库配置（一键还原）
1. 在本地 MySQL 中创建一个名为 `municipal_outsource` 的数据库。
2. 导入本项目根目录下的 **`municipal_outsource.sql`** 脚本（已包含建表语句和测试数据）。
3. 检查并修改 `application.yml` 中的数据库连接信息（默认账号为 `root`，密码为 `123456`）：
```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/municipal_outsource?useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai
    username: root
    password: 123456
