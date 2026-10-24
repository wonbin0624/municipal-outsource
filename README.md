# 市政外包一体化平台 (Municipal-outsource)

> A SpringBoot + Vue integrated platform for municipal outsourcing service management, including supplier information management, scoring assessment and settlement of service fees.（一个基于 SpringBoot+Vue 的市政外包服务一体化平台，包含供应商信息管理、考核评分以及服务费结算功能。）


基于 Vue3 + Spring Boot 的前后端分离全栈项目，旨在实现市政外包服务从“服务商入驻”到“巡检考核”，再到“费用结算”的全流程线上化闭环管理。



 技术栈

\- 前端：Vue3 (Composition API), Vite, Element Plus, ECharts, Axios

\- 后端：Spring Boot, MyBatis-Plus, JWT (认证), BCrypt (加密)

\- 数据库：MySQL, Redis



核心功能

1\. 权限管理：基于 JWT + RBAC 实现管理员、巡查员、服务商、市民四类角色控制。

2\. 日常巡检：巡查员在线登记，通过关键词规则匹配算法自动判定违规类型并生成整改单。

3\. 市民工单：市民在线提交诉求，系统根据“片区 + 类别”自动匹配责任服务商（智能分派）。

4\. 考核与结算联动：采用加权求和算法自动核算服务商考核得分，并根据得分自动计算结算扣款金额，实现业务数据闭环。



运行说明

\- 后端：`mvn spring-boot:run`

\- 前端：`cd vue-front \&\& npm install \&\& npm run dev`

