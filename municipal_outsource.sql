/*
 Navicat Premium Dump SQL

 Source Server         : local-db
 Source Server Type    : MySQL
 Source Server Version : 50556 (5.5.56)
 Source Host           : localhost:3306
 Source Schema         : municipal_outsource

 Target Server Type    : MySQL
 Target Server Version : 50556 (5.5.56)
 File Encoding         : 65001

 Date: 24/10/2026 12:07:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admins
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '管理员账号',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录密码',
  `contact_person` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '管理员表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of admins
-- ----------------------------

-- ----------------------------
-- Table structure for assess_index
-- ----------------------------
DROP TABLE IF EXISTS `assess_index`;
CREATE TABLE `assess_index`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `index_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '指标名称',
  `index_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '指标编码',
  `weight` decimal(5, 2) NOT NULL DEFAULT 0.00 COMMENT '权重/满分分值',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '指标说明',
  `status` int(11) NULL DEFAULT 1 COMMENT '状态',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '考核指标表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of assess_index
-- ----------------------------
INSERT INTO `assess_index` VALUES (1, '巡检合格率', 'PJ-001', 40.00, '当月巡检合格次数占总巡检次数的比例', 1, '2026-08-20 14:53:33');
INSERT INTO `assess_index` VALUES (2, '整改完成率', 'PJ-002', 40.00, '发现问题后是否在规定时间内整改完成', 1, '2026-08-20 14:53:33');
INSERT INTO `assess_index` VALUES (3, '市民满意率', 'PJ-003', 20.00, '当月市民对服务质量的满意程度', 1, '2026-08-20 14:53:33');

-- ----------------------------
-- Table structure for assess_result
-- ----------------------------
DROP TABLE IF EXISTS `assess_result`;
CREATE TABLE `assess_result`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `project_id` bigint(20) NOT NULL COMMENT '项目ID',
  `assess_period` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '考核周期',
  `total_score` decimal(5, 2) NULL DEFAULT 0.00 COMMENT '总分',
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '考核评语',
  `status` int(11) NULL DEFAULT 1 COMMENT '状态',
  `assess_time` datetime NULL DEFAULT NULL COMMENT '考核时间',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_assess_project`(`project_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 184 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '考核总记录表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of assess_result
-- ----------------------------
INSERT INTO `assess_result` VALUES (172, 1, '2026-09', 25.83, '人工微调', 1, '2026-09-17 10:16:18', '2026-09-17 10:16:18');
INSERT INTO `assess_result` VALUES (173, 2, '2026-09', 71.43, '巡检7次，问题5次，合格率28.6%；整改完成率100.0%；满意率100.0%', 1, '2026-09-17 10:16:18', '2026-09-17 10:16:18');
INSERT INTO `assess_result` VALUES (174, 3, '2026-09', 75.00, '巡检8次，问题5次，合格率37.5%；整改完成率100.0%；满意率100.0%', 1, '2026-09-17 10:16:18', '2026-09-17 10:16:18');
INSERT INTO `assess_result` VALUES (175, 4, '2026-09', 33.33, '巡检9次，问题6次，合格率33.3%；整改完成率0.0%；满意率100.0%', 1, '2026-09-17 10:16:18', '2026-09-17 10:16:18');
INSERT INTO `assess_result` VALUES (176, 5, '2026-09', 27.27, '巡检11次，问题9次，合格率18.2%；整改完成率0.0%；满意率100.0%', 1, '2026-09-17 10:16:18', '2026-09-17 10:16:18');
INSERT INTO `assess_result` VALUES (177, 6, '2026-09', 71.43, '巡检7次，问题5次，合格率28.6%；整改完成率100.0%；满意率100.0%', 1, '2026-09-17 10:16:18', '2026-09-17 10:16:18');
INSERT INTO `assess_result` VALUES (178, 7, '2026-09', 73.33, '巡检3次，问题2次，合格率33.3%；整改完成率100.0%；满意率100.0%', 1, '2026-09-17 10:16:18', '2026-09-17 10:16:18');
INSERT INTO `assess_result` VALUES (179, 8, '2026-09', 80.00, '巡检4次，问题2次，合格率50.0%；整改完成率100.0%；满意率100.0%', 1, '2026-09-17 10:16:18', '2026-09-17 10:16:18');
INSERT INTO `assess_result` VALUES (180, 9, '2026-09', 70.00, '巡检4次，问题3次，合格率25.0%；整改完成率100.0%；满意率100.0%', 1, '2026-09-17 10:16:18', '2026-09-17 10:16:18');
INSERT INTO `assess_result` VALUES (181, 10, '2026-09', 80.00, '巡检2次，问题1次，合格率50.0%；整改完成率100.0%；满意率100.0%', 1, '2026-09-17 10:16:18', '2026-09-17 10:16:18');
INSERT INTO `assess_result` VALUES (182, 11, '2026-09', 100.00, '巡检0次，问题0次，合格率100.0%；整改完成率100.0%；满意率100.0%', 1, '2026-09-17 10:16:18', '2026-09-17 10:16:18');
INSERT INTO `assess_result` VALUES (183, 12, '2026-09', 100.00, '巡检0次，问题0次，合格率100.0%；整改完成率100.0%；满意率100.0%', 1, '2026-09-17 10:16:18', '2026-09-17 10:16:18');

-- ----------------------------
-- Table structure for carts
-- ----------------------------
DROP TABLE IF EXISTS `carts`;
CREATE TABLE `carts`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '购物车记录ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `product_id` bigint(20) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL DEFAULT 1 COMMENT '数量',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '加入时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_product`(`user_id`, `product_id`) USING BTREE,
  INDEX `fk_cart_product`(`product_id`) USING BTREE,
  CONSTRAINT `fk_cart_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_cart_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '购物车表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of carts
-- ----------------------------

-- ----------------------------
-- Table structure for citizen_workorder
-- ----------------------------
DROP TABLE IF EXISTS `citizen_workorder`;
CREATE TABLE `citizen_workorder`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `project_id` bigint(20) NULL DEFAULT NULL COMMENT '项目ID',
  `provider_id` bigint(20) NULL DEFAULT NULL COMMENT '分配给的服务商ID',
  `workorder_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '工单编号',
  `citizen_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市民姓名',
  `citizen_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '诉求内容',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工单分类',
  `area` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属片区',
  `submit_time` datetime NULL DEFAULT NULL COMMENT '提交时间',
  `finish_time` datetime NULL DEFAULT NULL COMMENT '办结时间',
  `status` int(11) NULL DEFAULT 0 COMMENT '工单状态',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `inspector_id` bigint(20) NULL DEFAULT NULL,
  `comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '整改说明',
  `images` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '整改照片，多张用逗号分隔',
  `satisfaction` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '满意度: 1-5星',
  `evaluation` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '评价内容',
  `evaluated_at` datetime NULL DEFAULT NULL COMMENT '评价时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_work_project`(`project_id`) USING BTREE,
  INDEX `fk_work_provider`(`provider_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 149 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '市民诉求工单表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of citizen_workorder
-- ----------------------------
INSERT INTO `citizen_workorder` VALUES (1, 0, 1, 'WO-202608201001', '张伟明', '13811110001', '小区垃圾桶已经三天没人清理了，垃圾堆成山，臭气熏天，连窗户都不敢开。', '环境卫生', NULL, '2026-08-20 08:15:00', NULL, 1, '2026-08-20 08:15:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (2, 0, 7, 'WO-202608201002', '李秀芳', '13811110002', '楼下早餐店把泔水直接倒进雨水井，油污堵塞管道，还招来大量蟑螂和老鼠。', '环境卫生', NULL, '2026-08-20 09:20:00', NULL, 1, '2026-08-20 09:20:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (3, 0, 13, 'WO-202608201003', '王建国', '13811110003', '公共厕所卫生状况极差，地面污渍明显，洗手池长期无水，冲水按钮损坏，无法正常使用。', '环境卫生', NULL, '2026-08-20 10:05:00', NULL, 1, '2026-08-20 10:05:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (4, 0, 15, 'WO-202608201004', '赵丽华', '13811110004', '小区垃圾分类形同虚设，居民混投现象严重，可回收物和有害垃圾混合在一起，没人管理。', '环境卫生', NULL, '2026-08-20 11:30:00', NULL, 1, '2026-08-20 11:30:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (5, 0, 1, 'WO-202608201005', '刘洋', '13811110005', '商业街两侧垃圾遍地，塑料袋、一次性餐盒随处可见，环卫工人清扫不及时，影响市容市貌。', '环境卫生', NULL, '2026-08-20 13:40:00', NULL, 1, '2026-08-20 13:40:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (6, 0, 7, 'WO-202608201006', '陈静怡', '13811110006', '小区垃圾房长期敞开，垃圾外溢，周边居民苦不堪言，多次反映无人处理。', '环境卫生', NULL, '2026-08-20 15:10:00', NULL, 1, '2026-08-20 15:10:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (7, 0, 2, 'WO-202608201007', '周志强', '13822220001', '公园里的樱花树大面积枯死，树枝干枯发黄，树干上还有虫蛀的痕迹，急需救治。', '绿化养护', NULL, '2026-08-20 08:30:00', NULL, 1, '2026-08-20 08:30:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (8, 0, 8, 'WO-202608201008', '吴美玲', '13822220002', '小区绿化带杂草丛生，杂草已经长到半米高，不仅影响美观，夏天还容易滋生蚊虫。', '绿化养护', NULL, '2026-08-20 09:45:00', '2026-08-21 10:14:10', 0, '2026-08-20 09:45:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (9, 0, 12, 'WO-202608201009', '郑浩然', '13822220003', '路边绿化带大面积枯萎，很多冬青和月季都死了，土壤板结开裂，明显缺水和养护。', '绿化养护', NULL, '2026-08-20 10:50:00', NULL, 1, '2026-08-20 10:50:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (10, 0, 17, 'WO-202608201010', '孙悦欣', '13822220004', '小区里几棵大树的树枝长到了四楼窗户边，刮风时树枝抽打玻璃，存在安全隐患。', '绿化养护', NULL, '2026-08-20 12:00:00', NULL, 1, '2026-08-20 12:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (11, 0, 2, 'WO-202608201011', '钱进宝', '13822220005', '广场草坪大面积枯黄斑秃，很多地方裸露出泥土，既影响美观也容易扬尘。', '绿化养护', NULL, '2026-08-20 14:20:00', NULL, 1, '2026-08-20 14:20:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (12, 0, 8, 'WO-202608201012', '冯雅婷', '13822220006', '公园花坛里的花全部枯萎了，花坛里杂草比花还多，长期无人打理，十分可惜。', '绿化养护', NULL, '2026-08-20 16:00:00', '2026-08-21 10:10:47', 0, '2026-08-20 16:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (13, 0, 3, 'WO-202608201013', '朱建军', '13833330001', '小区楼道照明灯损坏已有两周，晚上上下楼全靠手机照明，老人出行极其不便。', '设施维修', NULL, '2026-08-20 07:50:00', '2026-08-21 10:04:35', 0, '2026-08-20 07:50:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (14, 0, 9, 'WO-202608201014', '许晴晴', '13833330002', '小区儿童游乐区的滑梯和秋千螺丝松动，部分焊接处断裂，孩子玩耍非常危险。', '设施维修', NULL, '2026-08-20 09:10:00', NULL, 1, '2026-08-20 09:10:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (15, 0, 14, 'WO-202608201015', '何凯明', '13833330003', '小区电梯频繁出现故障，有时突然下坠，有时门打不开，业主每天提心吊胆。', '设施维修', NULL, '2026-08-20 10:30:00', NULL, 1, '2026-08-20 10:30:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (16, 0, 3, 'WO-202608201016', '吕燕萍', '13833330004', '小区大门门禁系统损坏，外来人员随意进出，单元门也关不上，安全堪忧。', '设施维修', NULL, '2026-08-20 11:50:00', '2026-08-21 09:08:37', 0, '2026-08-20 11:50:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (17, 0, 9, 'WO-202608201017', '施涛勇', '13833330005', '小区地库排水管破裂，污水外溢，车库地面长期积水，臭味熏天。', '设施维修', NULL, '2026-08-20 13:30:00', '2026-08-25 15:54:53', 2, '2026-08-20 13:30:00', NULL, NULL, '已修缮', '/uploads/rectify/2026-08-25/9628f073855c4f2ab0db9b91dde5b56c20260825155443.jpg', NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (18, 0, 14, 'WO-202608201018', '孔琳琳', '13833330006', '小区监控系统损坏，关键区域摄像头黑屏，业主丢失物品无法调取录像。', '设施维修', NULL, '2026-08-20 15:30:00', NULL, 1, '2026-08-20 15:30:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (19, 0, 4, 'WO-202608201019', '严冬梅', '13844440001', '小区内流浪狗成群结队，深夜狂吠不止，还曾追逐咬伤过小孩，居民出行提心吊胆。', '公共安全', NULL, '2026-08-20 08:00:00', NULL, 1, '2026-08-20 08:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (20, 0, 10, 'WO-202608201020', '华敏杰', '13844440002', '小区楼道内消防通道被杂物堵塞，灭火器过期多年，万一发生火灾后果不堪设想。', '公共安全', NULL, '2026-08-20 09:30:00', NULL, 1, '2026-08-20 09:30:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (21, 0, 16, 'WO-202608201021', '金鑫磊', '13844440003', '小区围墙出现多处裂缝，部分墙体倾斜，有倒塌风险，旁边就是人行通道。', '公共安全', NULL, '2026-08-20 10:40:00', NULL, 1, '2026-08-20 10:40:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (22, 0, 4, 'WO-202608201022', '魏红梅', '13844440004', '小区电梯间和楼道里经常有陌生人进出，怀疑是传销人员，要求加强安保巡逻。', '公共安全', NULL, '2026-08-20 12:20:00', NULL, 1, '2026-08-20 12:20:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (23, 0, 10, 'WO-202608201023', '陶勇军', '13844440005', '小区地下车库电动车充电混乱，私拉电线现象普遍，多次发生充电器起火事故。', '公共安全', NULL, '2026-08-20 14:50:00', NULL, 1, '2026-08-20 14:50:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (24, 0, 16, 'WO-202608201024', '姜华明', '13844440006', '小区路灯大面积不亮，夜间漆黑一片，居民晚上出门必须用手电筒，存在安全隐患。', '公共安全', NULL, '2026-08-20 16:30:00', NULL, 1, '2026-08-20 16:30:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (25, 0, 5, 'WO-202608201025', '戚薇琳', '13855550001', '小区六楼以上水压严重不足，早晚高峰几乎无水可用，洗澡需要等到深夜。', '供水供电', NULL, '2026-08-20 07:30:00', NULL, 1, '2026-08-20 07:30:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (26, 0, 11, 'WO-202608201026', '谢鹏飞', '13855550002', '小区频繁停电，一周内停电三次，每次数小时，冰箱里的食物都变质了。', '供水供电', NULL, '2026-08-20 09:00:00', NULL, 1, '2026-08-20 09:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (27, 0, 18, 'WO-202608201027', '邹丽萍', '13855550003', '小区水质浑浊发黄，烧开后水垢严重，还有一股异味，不敢饮用。', '供水供电', NULL, '2026-08-20 10:20:00', NULL, 1, '2026-08-20 10:20:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (28, 0, 5, 'WO-202608201028', '潘志强', '13855550004', '小区供电电压不稳，空调无法正常启动，电器频繁损坏，已有多户报修。', '供水供电', NULL, '2026-08-20 13:00:00', NULL, 1, '2026-08-20 13:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (29, 0, 11, 'WO-202608201029', '范冰雪', '13855550005', '小区水管爆裂，楼道被淹，水流进电梯井，存在严重安全隐患。', '供水供电', NULL, '2026-08-20 14:40:00', NULL, 1, '2026-08-20 14:40:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (30, 0, 18, 'WO-202608201030', '彭涛勇', '13855550006', '小区电表箱门锁损坏，线路裸露，小孩触摸有触电风险，非常危险。', '供水供电', NULL, '2026-08-20 16:10:00', NULL, 1, '2026-08-20 16:10:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (31, 0, 6, 'WO-202608201031', '曾伟华', '13866660001', '楼下广场舞每天早上6点开始，晚上10点才结束，音响声音巨大，严重影响休息。', '噪音扰民', NULL, '2026-08-20 08:10:00', NULL, 1, '2026-08-20 08:10:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (32, 0, 6, 'WO-202608201032', '萧红梅', '13866660002', '小区旁边的工地日夜施工，打桩机声音震耳欲聋，孩子无法专心学习。', '噪音扰民', NULL, '2026-08-20 09:40:00', NULL, 1, '2026-08-20 09:40:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (33, 0, 6, 'WO-202608201033', '贺军强', '13866660003', '楼下烧烤店深夜营业至凌晨三四点，顾客划拳喧哗，油烟机噪音不断。', '噪音扰民', NULL, '2026-08-20 11:10:00', NULL, 1, '2026-08-20 11:10:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (34, 0, 6, 'WO-202608201034', '谭敏静', '13866660004', '小区内汽车鸣笛声此起彼伏，尤其是早晚高峰，严重扰民，老人心脏受不了。', '噪音扰民', NULL, '2026-08-20 13:50:00', NULL, 1, '2026-08-20 13:50:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (35, 0, 6, 'WO-202608201035', '龙志刚', '13866660005', '小区隔壁装修从早到晚不停歇，电钻声和敲墙声不断，周末也施工。', '噪音扰民', NULL, '2026-08-20 15:20:00', NULL, 1, '2026-08-20 15:20:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (36, 0, 0, 'WO-202608201036', '万芳华', '13877770001', '小区内违建现象严重，一楼住户私搭乱建，占用公共绿地，多次举报无人处理。', '其他', NULL, '2026-08-20 08:50:00', NULL, 0, '2026-08-20 08:50:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (37, 0, 0, 'WO-202608201037', '雷军平', '13877770002', '小区物业服务质量差，管理人员态度恶劣，业主合理诉求置之不理。', '其他', NULL, '2026-08-20 10:10:00', NULL, 0, '2026-08-20 10:10:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (38, 0, 0, 'WO-202608201038', '邱琳琳', '13877770003', '小区内缺乏非机动车充电桩，居民只能把电瓶带回家充电，存在火灾风险。', '其他', NULL, '2026-08-20 12:40:00', NULL, 0, '2026-08-20 12:40:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (39, 0, 0, 'WO-202608201039', '文杰明', '13877770004', '小区内宠物随地大小便，主人不清理，儿童玩耍时经常踩到，环境卫生堪忧。', '其他', NULL, '2026-08-20 14:10:00', NULL, 0, '2026-08-20 14:10:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (40, 0, 0, 'WO-202608201040', '石磊磊', '13877770005', '小区公共晾晒区被私人占用，晾衣架常年堆满杂物，其他居民无法使用。', '其他', NULL, '2026-08-20 15:50:00', NULL, 0, '2026-08-20 15:50:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (41, 0, 3, 'WO-20260820165622', '李明珠', '', '办公楼一楼饮水机坏了', '设施维修', NULL, '2026-08-20 16:56:22', '2026-08-21 10:31:35', 2, '2026-08-20 16:56:22', NULL, NULL, '已经修好了', '/uploads/rectify/2026-08-21/4d9ee747327c4583b0891e6ab2d7b09920260821103133.jpeg', '5', '很好！', '2026-08-21 10:57:43');
INSERT INTO `citizen_workorder` VALUES (42, 0, 5, 'WO-20260821110036', '李明珠', '18888888888', '小区时常停电', '供水供电', NULL, '2026-08-21 11:00:36', NULL, 1, '2026-08-21 11:00:36', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (46, 0, 1, 'WO-20260825155851', '小沙', '18888888888', '幸福小区公共厕所垃圾不倒', '环境卫生', NULL, '2026-08-25 15:58:51', '2026-08-25 16:01:17', 2, '2026-08-25 15:58:51', NULL, NULL, '已增加保洁人员', '/uploads/rectify/2026-08-25/aad6d8b418a54fc8a8a36337fa53fc9420260825160116.jpg', '5', '很不错', '2026-08-25 16:01:41');
INSERT INTO `citizen_workorder` VALUES (47, 0, 1, 'WO-20260905162756', '王兵', '王兵', '鼓楼区湖南路48号小区门口的建筑垃圾堆了一个多星期了，一直没人清运，不仅影响居民出行，还散发异味，家里窗户都不敢开。之前向物业反映过，物业说是市政清运范围，请尽快处理。', '环境卫生', NULL, '2026-09-05 16:27:56', '2026-09-05 16:34:31', 2, '2026-09-05 16:27:56', NULL, NULL, '已安排人员打扫，以后在附近增派人手。', '', NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (48, 1, 1, 'WO-TEST-001', '王兵', '13900001001', '鼓楼区湖南路商业街垃圾桶满溢，垃圾散落人行道', '环境卫生', '鼓楼区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (49, 1, 1, 'WO-TEST-002', '王兵', '13900001002', '鼓楼区山西路菜场门口菜叶和塑料袋堆积，气味难闻', '环境卫生', '鼓楼区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (50, 1, 1, 'WO-TEST-003', '王兵', '13900001003', '鼓楼区中央路公交站台后方垃圾长期无人清运', '环境卫生', '鼓楼区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (51, 1, 1, 'WO-TEST-004', '王兵', '13900001004', '鼓楼区草场门大街绿化带内藏有大量白色垃圾', '环境卫生', '鼓楼区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (52, 1, 1, 'WO-TEST-005', '王兵', '13900001005', '鼓楼区三牌楼大街商铺门前垃圾外溢，影响通行', '环境卫生', '鼓楼区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (53, 1, 1, 'WO-TEST-006', '王兵', '13900001006', '鼓楼区江东北路公厕异味严重，地面污渍未清理', '环境卫生', '鼓楼区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (54, 1, 1, 'WO-TEST-007', '王兵', '13900001007', '鼓楼区虎踞北路垃圾中转站周边污水横流', '环境卫生', '鼓楼区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (55, 1, 1, 'WO-TEST-008', '王兵', '13900001008', '鼓楼区清凉门大街垃圾桶破损，垃圾外漏', '环境卫生', '鼓楼区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (56, 1, 1, 'WO-TEST-009', '王兵', '13900001009', '鼓楼区定淮门大街小区垃圾分类点混投严重', '环境卫生', '鼓楼区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (57, 1, 1, 'WO-TEST-010', '王兵', '13900001010', '鼓楼区热河南路沿街餐饮店油污直排雨水井', '环境卫生', '鼓楼区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (58, 1, 1, 'WO-TEST-011', '王兵', '13900001011', '鼓楼区幕府山街道垃圾清运不及时，堆积严重', '环境卫生', '鼓楼区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (59, 1, 1, 'WO-TEST-012', '王兵', '13900001012', '鼓楼区华侨路街道路面有大量宠物粪便未清理', '环境卫生', '鼓楼区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (60, 1, 1, 'WO-TEST-013', '王兵', '13900001013', '鼓楼区广州路沿街果皮箱满溢，无人清掏', '环境卫生', '鼓楼区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (61, 1, 1, 'WO-TEST-014', '王兵', '13900001014', '鼓楼区中山北路商业广场角落垃圾堆积', '环境卫生', '鼓楼区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (62, 1, 1, 'WO-TEST-015', '王兵', '13900001015', '鼓楼区新模范马路公厕洗手池堵塞，污水外溢', '环境卫生', '鼓楼区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (63, 2, 2, 'WO-TEST-016', '王兵', '13900002001', '玄武区玄武大道绿化带杂草高度超过50厘米', '绿化养护', '玄武区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (64, 2, 2, 'WO-TEST-017', '王兵', '13900002002', '玄武区龙蟠路公园草坪斑秃严重，多处裸土', '绿化养护', '玄武区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (65, 2, 2, 'WO-TEST-018', '王兵', '13900002003', '玄武区中央路行道树枯死，树干中空有倒伏风险', '绿化养护', '玄武区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (66, 2, 2, 'WO-TEST-019', '王兵', '13900002004', '玄武区红山路绿化带病虫害严重，叶片被啃食', '绿化养护', '玄武区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (67, 2, 2, 'WO-TEST-020', '王兵', '13900002005', '玄武区太平门大街花箱花卉全部枯萎', '绿化养护', '玄武区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (68, 2, 2, 'WO-TEST-021', '王兵', '13900002006', '玄武区孝陵卫街道绿化带缺株断垄严重', '绿化养护', '玄武区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (69, 2, 2, 'WO-TEST-022', '王兵', '13900002007', '玄武区锁金村街道灌木丛枯枝未清理', '绿化养护', '玄武区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (70, 2, 2, 'WO-TEST-023', '王兵', '13900002008', '玄武区进香河路绿化带土壤板结，植物萎蔫', '绿化养护', '玄武区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (71, 2, 2, 'WO-TEST-024', '王兵', '13900002009', '玄武区梅园街道银杏树叶片发黄，疑似病害', '绿化养护', '玄武区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (72, 2, 2, 'WO-TEST-025', '王兵', '13900002010', '玄武区新街口街道绿化带被踩踏出多条土路', '绿化养护', '玄武区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (73, 2, 2, 'WO-TEST-026', '王兵', '13900002011', '玄武区玄武湖街道行道树倾斜，树根拱起路面', '绿化养护', '玄武区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (74, 2, 2, 'WO-TEST-027', '王兵', '13900002012', '玄武区北京东路绿化带杂草覆盖灌木', '绿化养护', '玄武区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (75, 2, 2, 'WO-TEST-028', '王兵', '13900002013', '玄武区珠江路灌木丛枯枝影响景观', '绿化养护', '玄武区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (76, 2, 2, 'WO-TEST-029', '王兵', '13900002014', '玄武区龙蟠中路草坪被踩踏严重', '绿化养护', '玄武区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (77, 2, 2, 'WO-TEST-030', '王兵', '13900002015', '玄武区玄武大道绿化带内垃圾与杂草混杂', '绿化养护', '玄武区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (78, 3, 3, 'WO-TEST-031', '王兵', '13900003001', '秦淮区龙蟠中路路灯连续5盏不亮，夜间通行危险', '设施维修', '秦淮区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (79, 3, 3, 'WO-TEST-032', '王兵', '13900003002', '秦淮区中山南路井盖下沉，车辆经过发出巨响', '设施维修', '秦淮区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (80, 3, 3, 'WO-TEST-033', '王兵', '13900003003', '秦淮区太平南路公交站台座椅破损，金属外露', '设施维修', '秦淮区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (81, 3, 3, 'WO-TEST-034', '王兵', '13900003004', '秦淮区应天大街护栏缺失3节，缺口无警示', '设施维修', '秦淮区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (82, 3, 3, 'WO-TEST-035', '王兵', '13900003005', '秦淮区双塘街道地下通道照明灯损坏', '设施维修', '秦淮区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (83, 3, 3, 'WO-TEST-036', '王兵', '13900003006', '秦淮区大明路交通信号灯故障，长时间黄闪', '设施维修', '秦淮区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (84, 3, 3, 'WO-TEST-037', '王兵', '13900003007', '秦淮区升州路小区单元门闭门器损坏', '设施维修', '秦淮区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (85, 3, 3, 'WO-TEST-038', '王兵', '13900003008', '秦淮区光华路路面坑洼积水，车辆颠簸严重', '设施维修', '秦淮区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (86, 3, 3, 'WO-TEST-039', '王兵', '13900003009', '秦淮区夫子庙景区广告牌固定件锈蚀', '设施维修', '秦淮区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (87, 3, 3, 'WO-TEST-040', '王兵', '13900003010', '秦淮区中华门街道墙面乱涂乱画', '设施维修', '秦淮区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (88, 3, 3, 'WO-TEST-041', '王兵', '13900003011', '秦淮区秦虹街道铝合金加工切割噪音', '设施维修', '秦淮区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (89, 3, 3, 'WO-TEST-042', '王兵', '13900003012', '秦淮区红花街道停电抢修后未恢复', '设施维修', '秦淮区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (90, 3, 3, 'WO-TEST-043', '王兵', '13900003013', '秦淮区双塘街道供水管道漏水，墙角渗水', '设施维修', '秦淮区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (91, 3, 3, 'WO-TEST-044', '王兵', '13900003014', '秦淮区中山南路地下通道排水泵故障', '设施维修', '秦淮区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (92, 3, 3, 'WO-TEST-045', '王兵', '13900003015', '秦淮区龙蟠中路路灯灯罩破损，电线外露', '设施维修', '秦淮区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (93, 4, 4, 'WO-TEST-046', '王兵', '13900004001', '建邺区南湖路小区消防通道被私家车占用', '公共安全', '建邺区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (94, 4, 4, 'WO-TEST-047', '王兵', '13900004002', '建邺区庐山路高空广告牌螺丝松动', '公共安全', '建邺区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (95, 4, 4, 'WO-TEST-048', '王兵', '13900004003', '建邺区江东中路商场消防栓被货物遮挡', '公共安全', '建邺区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (96, 4, 4, 'WO-TEST-049', '王兵', '13900004004', '建邺区兴隆大街老旧小区楼道堆放易燃杂物', '公共安全', '建邺区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (97, 4, 4, 'WO-TEST-050', '王兵', '13900004005', '建邺区奥体大街人行道路面塌陷，形成深坑', '公共安全', '建邺区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (98, 4, 4, 'WO-TEST-051', '王兵', '13900004006', '建邺区水西门大街围墙倾斜，裂缝明显', '公共安全', '建邺区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (99, 4, 4, 'WO-TEST-052', '王兵', '13900004007', '建邺区沙洲街道施工围挡缺失，行人可随意进入', '公共安全', '建邺区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (100, 4, 4, 'WO-TEST-053', '王兵', '13900004008', '建邺区南苑街道消防栓锈死无法开启', '公共安全', '建邺区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (101, 4, 4, 'WO-TEST-054', '王兵', '13900004009', '建邺区双闸街道摊贩占用消防通道经营', '公共安全', '建邺区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (102, 4, 4, 'WO-TEST-055', '王兵', '13900004010', '建邺区莫愁湖街道高层住宅外墙脱落风险', '公共安全', '建邺区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (103, 4, 4, 'WO-TEST-056', '王兵', '13900004011', '建邺区兴隆街道窨井盖缺失，仅用木板遮盖', '公共安全', '建邺区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (104, 4, 4, 'WO-TEST-057', '王兵', '13900004012', '建邺区河西大街商场消防通道被杂物堵占', '公共安全', '建邺区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (105, 4, 4, 'WO-TEST-058', '王兵', '13900004013', '建邺区水西门大街灭火器全部过期', '公共安全', '建邺区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (106, 4, 4, 'WO-TEST-059', '王兵', '13900004014', '建邺区庐山路小区消防通道长期停放电动车', '公共安全', '建邺区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (107, 4, 4, 'WO-TEST-060', '王兵', '13900004015', '建邺区奥体大街地下车库电动车充电混乱', '公共安全', '建邺区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (108, 5, 5, 'WO-TEST-061', '王兵', '13900005001', '栖霞区马群街道供水管道爆裂，路面涌水', '供水供电', '栖霞区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (109, 5, 5, 'WO-TEST-062', '王兵', '13900005002', '栖霞区仙林街道小区突然停电，多户受影响', '供水供电', '栖霞区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (110, 5, 5, 'WO-TEST-063', '王兵', '13900005003', '栖霞区尧化门街道电压不稳，电器频繁重启', '供水供电', '栖霞区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (111, 5, 5, 'WO-TEST-064', '王兵', '13900005004', '栖霞区迈皋桥街道供水管道漏水，墙角渗水', '供水供电', '栖霞区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (112, 5, 5, 'WO-TEST-065', '王兵', '13900005005', '栖霞区燕子矶街道小区停水超过12小时', '供水供电', '栖霞区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (113, 5, 5, 'WO-TEST-066', '王兵', '13900005006', '栖霞区龙潭街道电缆井盖破损，电缆外露', '供水供电', '栖霞区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (114, 5, 5, 'WO-TEST-067', '王兵', '13900005007', '栖霞区栖霞街道小区供电箱短路冒火花', '供水供电', '栖霞区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (115, 5, 5, 'WO-TEST-068', '王兵', '13900005008', '栖霞区西岗街道供水管道老化，水质发黄', '供水供电', '栖霞区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (116, 5, 5, 'WO-TEST-069', '王兵', '13900005009', '栖霞区靖安街道小区频繁跳闸停电', '供水供电', '栖霞区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (117, 5, 5, 'WO-TEST-070', '王兵', '13900005010', '栖霞区八卦洲街道电压异常，空调无法启动', '供水供电', '栖霞区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (118, 5, 5, 'WO-TEST-071', '王兵', '13900005011', '栖霞区马群街道供水不足，二楼以上无水', '供水供电', '栖霞区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (119, 5, 5, 'WO-TEST-072', '王兵', '13900005012', '栖霞区仙林大道供电线路被树枝压住', '供水供电', '栖霞区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (120, 5, 5, 'WO-TEST-073', '王兵', '13900005013', '栖霞区尧化门街道水压不足，热水器无法点火', '供水供电', '栖霞区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (121, 5, 5, 'WO-TEST-074', '王兵', '13900005014', '栖霞区燕子矶街道停电抢修后未恢复', '供水供电', '栖霞区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (122, 5, 5, 'WO-TEST-075', '王兵', '13900005015', '栖霞区迈皋桥街道供水管道老化，频繁爆管', '供水供电', '栖霞区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (123, 6, 6, 'WO-TEST-076', '王兵', '13900006001', '雨花台区西善桥街道工地夜间打桩噪音', '噪音扰民', '雨花台区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (124, 6, 6, 'WO-TEST-077', '王兵', '13900006002', '雨花台区铁心桥街道酒吧低音炮震动扰民', '噪音扰民', '雨花台区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (125, 6, 6, 'WO-TEST-078', '王兵', '13900006003', '雨花台区赛虹桥街道广场舞音响音量过大', '噪音扰民', '雨花台区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (126, 6, 6, 'WO-TEST-079', '王兵', '13900006004', '雨花台区板桥街道道路施工破碎机噪音', '噪音扰民', '雨花台区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (127, 6, 6, 'WO-TEST-080', '王兵', '13900006005', '雨花台区梅山街道小区装修电钻声持续', '噪音扰民', '雨花台区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (128, 6, 6, 'WO-TEST-081', '王兵', '13900006006', '雨花台区雨花街道工厂风机噪音', '噪音扰民', '雨花台区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (129, 6, 6, 'WO-TEST-082', '王兵', '13900006007', '雨花台区开发区夜市摊贩叫卖声', '噪音扰民', '雨花台区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (130, 6, 6, 'WO-TEST-083', '王兵', '13900006008', '雨花台区西善桥街道工地混凝土搅拌车噪音', '噪音扰民', '雨花台区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (131, 6, 6, 'WO-TEST-084', '王兵', '13900006009', '雨花台区板桥街道KTV深夜歌声扰民', '噪音扰民', '雨花台区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (132, 6, 6, 'WO-TEST-085', '王兵', '13900006010', '雨花台区铁心桥街道道路夜间施工机械噪音', '噪音扰民', '雨花台区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (133, 6, 6, 'WO-TEST-086', '王兵', '13900006011', '雨花台区赛虹桥街道商铺高音喇叭促销', '噪音扰民', '雨花台区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (134, 6, 6, 'WO-TEST-087', '王兵', '13900006012', '雨花台区雨花街道空调外机噪音', '噪音扰民', '雨花台区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (135, 6, 6, 'WO-TEST-088', '王兵', '13900006013', '雨花台区梅山街道宠物店犬吠扰民', '噪音扰民', '雨花台区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (136, 6, 6, 'WO-TEST-089', '王兵', '13900006014', '雨花台区开发区铝合金加工切割噪音', '噪音扰民', '雨花台区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (137, 6, 6, 'WO-TEST-090', '王兵', '13900006015', '雨花台区板桥街道地铁施工夜间噪音', '噪音扰民', '雨花台区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (138, 9, 9, 'WO-TEST-091', '王兵', '13900007001', '六合区雄州街道小区路灯故障不亮', '设施维修', '六合区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (139, 10, 10, 'WO-TEST-092', '王兵', '13900007002', '溧水区永阳街道小区消防通道被占用', '公共安全', '溧水区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (140, 11, 11, 'WO-TEST-093', '王兵', '13900007003', '高淳区淳溪街道小区供水管道漏水', '供水供电', '高淳区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (141, 7, NULL, 'WO-TEST-094', '王兵', '13900007004', '江宁区东山街道消防通道被占用', '公共安全', '江宁区', '2026-09-18 10:03:57', NULL, 0, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (142, 5, NULL, 'WO-TEST-095', '王兵', '13900007005', '栖霞区马群街道广场舞音响噪音扰民', '噪音扰民', '栖霞区', '2026-09-18 10:03:57', NULL, 0, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (143, 8, NULL, 'WO-TEST-096', '王兵', '13900007006', '浦口区江浦街道垃圾桶满溢无人清理', '环境卫生', '浦口区', '2026-09-18 10:03:57', NULL, 0, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (144, 6, NULL, 'WO-TEST-097', '王兵', '13900007007', '雨花台区赛虹桥街道路灯故障不亮', '设施维修', '雨花台区', '2026-09-18 10:03:57', NULL, 0, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (145, 2, NULL, 'WO-TEST-098', '王兵', '13900007008', '玄武区孝陵卫街道小区频繁停电', '供水供电', '玄武区', '2026-09-18 10:03:57', NULL, 0, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (146, 7, 7, 'WO-TEST-099', '王兵', '13900007009', '江宁区秣陵街道垃圾中转站渗滤液外溢', '环境卫生', '江宁区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (147, 8, 8, 'WO-TEST-100', '王兵', '13900007010', '浦口区顶山街道绿化带病虫害严重', '绿化养护', '浦口区', '2026-09-18 10:03:57', NULL, 1, '2026-09-18 10:03:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `citizen_workorder` VALUES (148, 0, NULL, 'WO-20260918101338', '王兵', '', '1', '其他', '鼓楼区', '2026-09-18 10:13:38', NULL, 0, '2026-09-18 10:13:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `user_id` bigint(20) NOT NULL COMMENT '评论用户ID',
  `product_id` bigint(20) NOT NULL COMMENT '被评论产品ID',
  `score` tinyint(4) NOT NULL COMMENT '评分（1-5星）',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '评论内容',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_comment_user`(`user_id`) USING BTREE,
  INDEX `fk_comment_product`(`product_id`) USING BTREE,
  CONSTRAINT `fk_comment_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_comment_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '评论表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of comments
-- ----------------------------

-- ----------------------------
-- Table structure for municipal_project
-- ----------------------------
DROP TABLE IF EXISTS `municipal_project`;
CREATE TABLE `municipal_project`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `project_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '项目名称',
  `project_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '项目编号',
  `provider_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '服务商ID',
  `project_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目类型',
  `budget_amount` decimal(12, 2) NULL DEFAULT 0.00 COMMENT '预算金额',
  `start_date` date NULL DEFAULT NULL COMMENT '开始日期',
  `end_date` date NULL DEFAULT NULL COMMENT '结束日期',
  `status` int(11) NULL DEFAULT 1 COMMENT '状态',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_provider_id`(`provider_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '市政外包项目表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of municipal_project
-- ----------------------------
INSERT INTO `municipal_project` VALUES (1, '鼓楼区环卫保洁项目', 'HT-2026-001', '鼓楼环卫服务公司', '鼓楼区', 50000.00, '2025-01-01', '2028-06-07', 2, '2026-08-20 14:53:33', NULL);
INSERT INTO `municipal_project` VALUES (2, '玄武区绿化养护项目', 'HT-2026-002', '玄武市政养护公司', '玄武区', 35000.00, '2026-01-01', '2026-03-03', 1, '2026-08-20 14:53:33', NULL);
INSERT INTO `municipal_project` VALUES (3, '秦淮区设施维修项目', 'HT-2026-003', '秦淮设施维修公司', '秦淮区', 28000.00, '2026-06-08', '2027-06-30', 0, '2026-08-20 14:53:33', NULL);
INSERT INTO `municipal_project` VALUES (4, '建邺区公共安全项目', 'HT-2026-004', '建邺公共安全管理公司', '建邺区', 42000.00, '2026-04-01', '2026-12-31', 1, '2026-08-20 14:53:33', NULL);
INSERT INTO `municipal_project` VALUES (5, '栖霞区供水供电项目', 'HT-2026-005', '栖霞供水供电维修公司', '栖霞区', 38000.00, '2026-05-01', '2026-06-27', 1, '2026-08-20 14:53:33', NULL);
INSERT INTO `municipal_project` VALUES (6, '雨花台区噪音治理项目', 'HT-2026-006', '雨花噪音治理公司', '雨花台区', 22000.00, '2026-06-01', '2026-12-31', 1, '2026-08-20 14:53:33', NULL);
INSERT INTO `municipal_project` VALUES (7, '江宁区城乡环卫一体化项目', 'HT-2026-007', '江宁垃圾分类处理公司', '江宁区', 78000.00, '2026-01-15', '2026-12-31', 1, '2026-08-20 15:43:10', NULL);
INSERT INTO `municipal_project` VALUES (8, '浦口区园林绿化养护项目', 'HT-2026-025', '浦口绿化工程公司', '浦口区', 32000.00, '2026-01-01', '2026-12-31', 1, '2026-08-21 11:52:32', NULL);
INSERT INTO `municipal_project` VALUES (9, '六合区道路桥梁维护项目', 'HT-2026-026', '六合道路设施维修公司', '六合区', 45000.00, '2026-01-01', '2026-12-31', 1, '2026-08-21 11:52:32', NULL);
INSERT INTO `municipal_project` VALUES (10, '溧水区公共安全巡查项目', 'HT-2026-027', '溧水公共安全服务公司', '溧水区', 28000.00, '2026-01-01', '2026-12-31', 1, '2026-08-21 11:52:32', NULL);
INSERT INTO `municipal_project` VALUES (11, '高淳区供水保障项目', 'HT-2026-028', '高淳供水服务公司', '高淳区', 35000.00, '2026-01-01', '2026-12-31', 1, '2026-08-21 11:52:32', NULL);
INSERT INTO `municipal_project` VALUES (12, '江宁区卫生项目', 'HT-2026-008', '江宁保洁公司', '江宁区', 15000.00, '2026-01-01', '2026-12-31', 1, '2026-08-25 16:06:53', NULL);

-- ----------------------------
-- Table structure for order_items
-- ----------------------------
DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `product_id` bigint(20) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '购买数量',
  `price` decimal(10, 2) NOT NULL COMMENT '购买时单价（快照）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_item_order`(`order_id`) USING BTREE,
  INDEX `fk_item_product`(`product_id`) USING BTREE,
  CONSTRAINT `fk_item_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_item_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '订单明细表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of order_items
-- ----------------------------

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `user_id` bigint(20) NOT NULL COMMENT '下单用户ID',
  `total_amount` decimal(10, 2) NOT NULL COMMENT '订单总金额',
  `pay_method` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付方式（如微信、支付宝）',
  `status` tinyint(4) NULL DEFAULT 0 COMMENT '订单状态：0-待支付，1-已支付，2-已取消，3-已完成',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_order_no`(`order_no`) USING BTREE,
  INDEX `fk_order_user`(`user_id`) USING BTREE,
  CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '订单表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of orders
-- ----------------------------

-- ----------------------------
-- Table structure for patrol_record
-- ----------------------------
DROP TABLE IF EXISTS `patrol_record`;
CREATE TABLE `patrol_record`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `project_id` bigint(20) NOT NULL COMMENT '项目ID',
  `patrol_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '巡检编号',
  `patrol_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '巡检类型',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '巡检内容',
  `result` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '巡检结果',
  `patrol_person` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '巡检人',
  `patrol_time` datetime NULL DEFAULT NULL COMMENT '巡检时间',
  `img_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_project_id`(`project_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 274 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '巡检记录表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of patrol_record
-- ----------------------------
INSERT INTO `patrol_record` VALUES (1, 1, 'PC-001', '环境卫生', '鼓楼区中山路沿街垃圾桶满溢，垃圾散落地面，影响市容', '1', '张伟', '2026-08-20 14:53:33', NULL, '2026-08-20 14:53:33', NULL);
INSERT INTO `patrol_record` VALUES (2, 1, 'PC-002', '环境卫生', '检查B区公共厕所，冲水正常，地面干净', '0', '张伟', '2026-08-20 14:53:33', NULL, '2026-08-20 14:53:33', NULL);
INSERT INTO `patrol_record` VALUES (3, 1, 'PC-003', '环境卫生', '检查C区垃圾分类点，有少量垃圾混投现象', '1', '李明', '2026-08-20 14:53:33', NULL, '2026-08-20 14:53:33', NULL);
INSERT INTO `patrol_record` VALUES (4, 2, 'PC-004', '绿化养护', '检查公园绿化带，发现部分绿植叶片发黄枯萎', '1', '王芳', '2026-08-20 14:53:33', NULL, '2026-08-20 14:53:33', NULL);
INSERT INTO `patrol_record` VALUES (5, 2, 'PC-005', '绿化养护', '检查广场草坪，修剪整齐，无杂草', '0', '王芳', '2026-08-20 14:53:33', NULL, '2026-08-20 14:53:33', NULL);
INSERT INTO `patrol_record` VALUES (6, 3, 'PC-006', '设施维修', '检查小区楼道灯，灯正常亮起', '0', '赵强', '2026-08-20 14:53:33', NULL, '2026-08-20 14:53:33', NULL);
INSERT INTO `patrol_record` VALUES (7, 3, 'PC-007', '设施维修', '检查小区电梯，运行正常，无异响', '0', '赵强', '2026-08-20 14:53:33', NULL, '2026-08-20 14:53:33', NULL);
INSERT INTO `patrol_record` VALUES (8, 3, 'PC-008', '设施维修', '检查公共座椅，发现3处螺丝松动需要维修', '1', '钱丽', '2026-08-20 14:53:33', NULL, '2026-08-20 14:53:33', NULL);
INSERT INTO `patrol_record` VALUES (9, 4, 'PC-009', '公共安全', '检查小区消防通道，有车辆违规停放', '1', '孙洋', '2026-08-20 14:53:33', NULL, '2026-08-20 14:53:33', NULL);
INSERT INTO `patrol_record` VALUES (10, 4, 'PC-010', '公共安全', '检查监控设备，运行正常，画面清晰', '0', '孙洋', '2026-08-20 14:53:33', NULL, '2026-08-20 14:53:33', NULL);
INSERT INTO `patrol_record` VALUES (11, 4, 'PC-011', '公共安全', '检查小区围墙，发现2处墙体裂缝', '1', '周婷', '2026-08-20 14:53:33', NULL, '2026-08-20 14:53:33', NULL);
INSERT INTO `patrol_record` VALUES (12, 5, 'PC-012', '供水供电', '检查小区供水设备，水压正常', '0', '吴刚', '2026-08-20 14:53:33', NULL, '2026-08-20 14:53:33', NULL);
INSERT INTO `patrol_record` VALUES (13, 5, 'PC-013', '供水供电', '检查供电线路，发现有1处线路老化裸露', '1', '吴刚', '2026-08-20 14:53:33', NULL, '2026-08-20 14:53:33', NULL);
INSERT INTO `patrol_record` VALUES (14, 6, 'PC-014', '噪音扰民', '检查广场舞区域，音量控制在合理范围', '0', '郑爽', '2026-08-20 14:53:33', NULL, '2026-08-20 14:53:33', NULL);
INSERT INTO `patrol_record` VALUES (15, 6, 'PC-015', '噪音扰民', '检查工地施工区域，存在夜间施工噪音', '1', '郑爽', '2026-08-20 14:53:33', NULL, '2026-08-20 14:53:33', NULL);
INSERT INTO `patrol_record` VALUES (16, 1, 'PC-016', '环境卫生', '检查A区街道，发现垃圾桶周边有大量垃圾堆积，无人清理', '1', '张伟', '2026-08-20 16:00:19', NULL, '2026-08-20 16:00:19', NULL);
INSERT INTO `patrol_record` VALUES (17, 1, 'PC-017', '环境卫生', '鼓楼区山西路公厕地面污渍严重，洗手台堵塞无法使用', '1', '李明', '2026-08-20 16:00:19', NULL, '2026-08-20 16:00:19', NULL);
INSERT INTO `patrol_record` VALUES (18, 1, 'PC-018', '环境卫生', '检查C区垃圾分类点，发现有害垃圾混投在厨余垃圾桶中', '1', '王芳', '2026-08-20 16:00:19', NULL, '2026-08-20 16:00:19', NULL);
INSERT INTO `patrol_record` VALUES (19, 1, 'PC-019', '环境卫生', '检查D区商业街，沿街商铺门前垃圾随意丢弃，无人清扫', '1', '张伟', '2026-08-20 16:00:19', NULL, '2026-08-20 16:00:19', NULL);
INSERT INTO `patrol_record` VALUES (20, 1, 'PC-020', '环境卫生', '检查E区小区，垃圾桶破损严重，垃圾外漏，臭味弥漫', '1', '赵强', '2026-08-20 16:00:19', NULL, '2026-08-20 16:00:19', NULL);
INSERT INTO `patrol_record` VALUES (21, 1, 'PC-021', '环境卫生', '鼓楼区中山路沿街垃圾桶满溢，垃圾散落在地面，影响市容', '1', '张伟', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (22, 1, 'PC-022', '环境卫生', '鼓楼区山西路公厕地面污渍严重，洗手台堵塞', '1', '李明', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (23, 1, 'PC-023', '环境卫生', '鼓楼区湖南路垃圾分类亭分类正确，干净整洁', '0', '王芳芳', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (24, 1, 'PC-024', '环境卫生', '鼓楼区湖北路商业街油污满地，多处垃圾桶破损，污水横流', '1', '赵强', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (25, 1, 'PC-025', '环境卫生', '鼓楼区中央路绿化带内藏有大量白色垃圾，未及时清理', '1', '张伟', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (26, 2, 'PC-026', '绿化养护', '玄武湖公园樱花树叶片发黄，有明显病虫害迹象', '1', '周婷', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (27, 2, 'PC-027', '绿化养护', '玄武区北京东路绿化带杂草丛生，高度超过50厘米', '1', '吴刚', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (28, 2, 'PC-028', '绿化养护', '玄武区太平北路行道树修剪整齐，景观良好', '0', '郑爽', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (29, 2, 'PC-029', '绿化养护', '玄武区珠江路绿化带土壤板结，植被生长不良', '1', '孙洋', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (30, 2, 'PC-030', '绿化养护', '玄武区龙蟠路公园草坪枯黄斑秃，多处裸土', '1', '周婷', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (31, 3, 'PC-031', '设施维修', '秦淮区夫子庙附近路灯故障，夜间照明不足', '1', '钱丽', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (32, 3, 'PC-032', '设施维修', '秦淮区中华路公共座椅损坏，金属部件生锈断裂', '1', '冯涛', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (33, 3, 'PC-033', '设施维修', '秦淮区老门东景区指示牌清晰完好', '0', '陈静香', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (34, 3, 'PC-034', '设施维修', '秦淮区升州路井盖缺失，存在严重安全隐患', '1', '褚明', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (35, 3, 'PC-035', '设施维修', '秦淮区建康路健身器材多处松动，急需维修', '1', '钱丽', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (36, 4, 'PC-036', '公共安全', '建邺区河西万达广场消防通道被车辆占用', '1', '沈洁', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (37, 4, 'PC-037', '公共安全', '建邺区奥体中心周边监控设备运行正常', '0', '韩雪', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (38, 4, 'PC-038', '公共安全', '建邺区南湖小区围墙多处裂缝，有倒塌风险', '1', '杨晨', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (39, 4, 'PC-039', '公共安全', '建邺区应天大街高架桥下流浪人员聚集，存在隐患', '1', '朱磊', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (40, 4, 'PC-040', '公共安全', '建邺区江心洲环岛路护栏完好，安全设施齐全', '0', '沈洁', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (41, 5, 'PC-041', '供水供电', '栖霞区仙林大学城供水管道破损，路面渗水严重', '1', '尤娜', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (42, 5, 'PC-042', '供水供电', '栖霞区迈皋桥地铁站附近供电线路老化，有裸露电线', '1', '许瑞', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (43, 5, 'PC-043', '供水供电', '栖霞区尧化门小区供水水压正常，设备运行良好', '0', '何欣', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (44, 5, 'PC-044', '供水供电', '栖霞区马群街道多处路灯不亮，夜间漆黑一片', '1', '吕良民', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (45, 5, 'PC-045', '供水供电', '栖霞区燕子矶江边泵房设备老旧，存在故障隐患', '1', '尤娜', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (46, 6, 'PC-046', '噪音扰民', '雨花台区铁心桥工地夜间施工，噪音严重扰民', '1', '施杰', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (47, 6, 'PC-047', '噪音扰民', '雨花台区板桥新城广场舞音量过大，居民投诉', '1', '孔瑶', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (48, 6, 'PC-048', '噪音扰民', '雨花台区软件大道商业区噪音控制良好', '0', '曹阳', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (49, 6, 'PC-049', '噪音扰民', '雨花台区西善桥街道烧烤店深夜营业，噪音油烟扰民', '1', '严冬', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (50, 6, 'PC-050', '噪音扰民', '雨花台区岱山保障房片区车辆鸣笛频繁，噪音超标', '1', '施杰', '2026-08-21 11:17:58', NULL, '2026-08-21 11:17:58', NULL);
INSERT INTO `patrol_record` VALUES (51, 7, 'PC-051', '环境卫生', '江宁区垃圾分类点检查，分类正确率较高', '0', '刘洋', '2026-08-21 11:51:40', NULL, '2026-08-21 11:51:40', NULL);
INSERT INTO `patrol_record` VALUES (52, 7, 'PC-052', '环境卫生', '江宁区垃圾中转站异味较大，周边居民投诉', '1', '刘洋', '2026-08-21 11:51:40', NULL, '2026-08-21 11:51:40', NULL);
INSERT INTO `patrol_record` VALUES (53, 7, 'PC-053', '环境卫生', '江宁区垃圾分类宣传牌损坏，需要更换', '1', '刘洋', '2026-08-21 11:51:40', NULL, '2026-08-21 11:51:40', NULL);
INSERT INTO `patrol_record` VALUES (54, 8, 'PC-054', '绿化养护', '浦口区滨江大道绿化带植被生长良好', '0', '周婷', '2026-08-21 11:51:40', NULL, '2026-08-21 11:51:40', NULL);
INSERT INTO `patrol_record` VALUES (55, 8, 'PC-055', '绿化养护', '浦口区老山森林公园入口草坪枯黄，需要浇水', '1', '周婷', '2026-08-21 11:51:40', NULL, '2026-08-21 11:51:40', NULL);
INSERT INTO `patrol_record` VALUES (56, 9, 'PC-056', '设施维修', '六合区龙池路路灯故障，夜间照明不足', '1', '钱丽', '2026-08-21 11:51:40', NULL, '2026-08-21 11:51:40', NULL);
INSERT INTO `patrol_record` VALUES (57, 9, 'PC-057', '设施维修', '六合区雄州路井盖松动，车辆经过有异响', '1', '钱丽', '2026-08-21 11:51:40', NULL, '2026-08-21 11:51:40', NULL);
INSERT INTO `patrol_record` VALUES (58, 10, 'PC-058', '公共安全', '溧水区天生桥景区安全设施完好', '0', '冯涛', '2026-08-21 11:51:40', NULL, '2026-08-21 11:51:40', NULL);
INSERT INTO `patrol_record` VALUES (59, 10, 'PC-059', '公共安全', '溧水区永阳街道消防通道被占用', '1', '冯涛', '2026-08-21 11:51:40', NULL, '2026-08-21 11:51:40', NULL);
INSERT INTO `patrol_record` VALUES (60, 8, 'PC-060', '绿化养护', '浦口区绿化带修剪整齐，景观效果良好', '0', '周婷', '2026-08-21 11:52:39', NULL, '2026-08-21 11:52:39', NULL);
INSERT INTO `patrol_record` VALUES (61, 8, 'PC-061', '绿化养护', '浦口区部分行道树枯死，需要补种', '1', '周婷', '2026-08-21 11:52:39', NULL, '2026-08-21 11:52:39', NULL);
INSERT INTO `patrol_record` VALUES (62, 9, 'PC-062', '设施维修', '六合区道路标线清晰，路况良好', '0', '钱丽', '2026-08-21 11:52:39', NULL, '2026-08-21 11:52:39', NULL);
INSERT INTO `patrol_record` VALUES (63, 9, 'PC-063', '设施维修', '六合区桥梁护栏锈蚀严重，存在安全隐患', '1', '钱丽', '2026-08-21 11:52:39', NULL, '2026-08-21 11:52:39', NULL);
INSERT INTO `patrol_record` VALUES (66, 5, 'PC-1787299883150', '供水供电', '幸福花园水房供水有问题', '1', '李志强', '2026-08-21 16:11:23', '/uploads/patrol/2026-08-21/5f74c7fcba654857afbbb08677699db720260821161121.jpeg', '2026-08-21 16:11:23', NULL);
INSERT INTO `patrol_record` VALUES (67, 4, 'PC-1787644245286', '公共安全', '幸福小区门口无安保人员看守', '1', '王磊', '2026-08-25 15:50:45', '/uploads/patrol/2026-08-25/163d5e703420457787088dfd3aad294820260825155014.jpg', '2026-08-25 15:50:45', NULL);
INSERT INTO `patrol_record` VALUES (68, 5, 'PC-1787644800573', '供水供电', '供电房时常短路', '1', '王磊', '2026-08-25 16:00:00', '/uploads/patrol/2026-08-25/b41dfcab29094a068725891e9094847c20260825155959.jpg', '2026-08-25 16:00:00', NULL);
INSERT INTO `patrol_record` VALUES (69, 5, 'PC-1788404906060', '设施维修', '栖霞区仙林大道沿线配电箱门锁损坏，线路裸露，存在触电隐患', '1', '小西', '2026-09-03 11:08:26', '', '2026-09-03 11:08:26', NULL);
INSERT INTO `patrol_record` VALUES (70, 5, 'PC-1788404920150', '设施维修', '栖霞区尧化门小区二次供水泵房压力异常，管道有漏水迹象', '1', '小西', '2026-09-03 11:08:40', '', '2026-09-03 11:08:40', NULL);
INSERT INTO `patrol_record` VALUES (71, 1, 'PC-1788595991324', '环境卫生', '鼓楼区中山路沿街垃圾桶满溢，垃圾散落地面，有油污渗出，影响市容环境', '1', '张明', '2026-09-05 16:13:11', '', '2026-09-05 16:13:11', NULL);
INSERT INTO `patrol_record` VALUES (72, 1, 'PC-1788606878515', '环境卫生', '鼓楼区中山路沿街垃圾桶满溢，垃圾散落地面', '1', '李西', '2026-09-05 19:14:38', '', '2026-09-05 19:14:38', NULL);
INSERT INTO `patrol_record` VALUES (173, 1, 'PT-001', '环境卫生', '鼓楼区草场门大街垃圾桶满溢，周边地面散落果皮纸屑', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (174, 1, 'PT-002', '环境卫生', '玄武区玄武大道绿化带内发现大量废弃塑料袋', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (175, 1, 'PT-003', '环境卫生', '秦淮区太平南路餐饮店后巷油污积存，排水口堵塞', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (176, 1, 'PT-004', '环境卫生', '建邺区江东中路垃圾中转站附近有渗滤液外溢', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (177, 1, 'PT-005', '环境卫生', '栖霞区学则路地铁口共享单车车筐内塞满垃圾', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (178, 1, 'PT-006', '环境卫生', '雨花台区安德门大街公厕地面污渍严重，洗手池无水电', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (179, 1, 'PT-007', '环境卫生', '江宁区天元中路小区垃圾分类点混投严重，厨余桶内有可回收物', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (180, 1, 'PT-008', '环境卫生', '浦口区文德路沿街商铺门前有大量装修垃圾堆放', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (181, 1, 'PT-009', '环境卫生', '六合区延安路菜市场周边烂菜叶和塑料袋散落一地', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (182, 1, 'PT-010', '环境卫生', '溧水区珍珠南路河道边有漂浮垃圾和死鱼', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (183, 1, 'PT-011', '环境卫生', '高淳区镇兴路小区垃圾桶破损，垃圾外漏臭味弥漫', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (184, 1, 'PT-012', '环境卫生', '鼓楼区江东北路高架桥下积存大量落叶和杂物', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (185, 1, 'PT-013', '环境卫生', '玄武区红山路垃圾清运车滴漏污水，路面污渍明显', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (186, 1, 'PT-014', '公共安全', '秦淮区应天大街高架下空间有流浪人员堆放大量杂物', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (187, 1, 'PT-015', '环境卫生', '建邺区奥体大街广场角落有宠物粪便未清理', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (188, 1, 'PT-016', '绿化养护', '栖霞区仙林大道绿化带杂草高度超过60厘米，覆盖灌木', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (189, 1, 'PT-017', '绿化养护', '雨花台区软件大道行道树枯死，树干中空有倒伏风险', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (190, 1, 'PT-018', '绿化养护', '江宁区双龙大道草坪斑秃严重，多处裸土扬尘', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (191, 1, 'PT-019', '绿化养护', '浦口区浦滨路绿化带病虫害严重，叶片被啃食', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (192, 1, 'PT-020', '绿化养护', '六合区龙津桥两侧花箱花卉全部枯萎', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (193, 1, 'PT-021', '绿化养护', '溧水区秦淮大道绿化带灌木缺株，黄土裸露', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (194, 1, 'PT-022', '绿化养护', '高淳区固城湖大道行道树修剪过度，树冠失衡', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (195, 1, 'PT-023', '绿化养护', '鼓楼区虎踞北路绿化带内杂草丛生，高度超过1米', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (196, 1, 'PT-024', '绿化养护', '玄武区龙蟠路公园草坪被踩踏出多条土路', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (197, 1, 'PT-025', '绿化养护', '秦淮区大明路绿化带土壤板结开裂，植物萎蔫', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (198, 1, 'PT-026', '供水供电', '建邺区河西大街银杏树叶片发黄，疑似病害', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (199, 1, 'PT-027', '环境卫生', '栖霞区尧新大道绿化带内垃圾与杂草混杂', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (200, 1, 'PT-028', '绿化养护', '雨花台区花神大道灌木丛枯枝未清理，影响景观', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (201, 1, 'PT-029', '绿化养护', '江宁区将军大道行道树倾斜，树根拱起路面', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (202, 1, 'PT-030', '绿化养护', '浦口区沿山大道绿化带缺株断垄严重', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (203, 1, 'PT-031', '设施维修', '秦淮区龙蟠中路路灯连续5盏不亮，夜间通行危险', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (204, 1, 'PT-032', '设施维修', '鼓楼区广州路井盖下沉，车辆经过时发出巨响', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (205, 1, 'PT-033', '设施维修', '玄武区中央路公交站台座椅破损，金属边缘外露', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (206, 1, 'PT-034', '设施维修', '建邺区庐山路护栏缺失3节，缺口处无警示', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (207, 1, 'PT-035', '设施维修', '栖霞区和燕路路灯灯罩破损，电线外露', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (208, 1, 'PT-036', '设施维修', '雨花台区软件大道地下通道照明灯损坏', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (209, 1, 'PT-037', '设施维修', '江宁区胜太路交通信号灯故障，长时间黄闪', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (210, 1, 'PT-038', '设施维修', '浦口区龙华路小区单元门闭门器损坏，门无法闭合', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (211, 1, 'PT-039', '环境卫生', '六合区长江路路面坑洼积水，车辆颠簸严重', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (212, 1, 'PT-040', '设施维修', '溧水区宝塔路公园凉亭顶部破损漏雨', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (213, 1, 'PT-041', '设施维修', '高淳区淳溪街道垃圾桶底座锈蚀损坏', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (214, 1, 'PT-042', '设施维修', '鼓楼区清凉门大街排水井盖破损，钢筋外露', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (215, 1, 'PT-043', '设施维修', '玄武区太平门大街公共自行车桩无法锁车', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (216, 1, 'PT-044', '环境卫生', '秦淮区中山南路地下通道排水泵故障，积水严重', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (217, 1, 'PT-045', '设施维修', '建邺区水西门大街路灯控制箱门锁损坏', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (218, 1, 'PT-046', '公共安全', '建邺区南湖路小区消防通道被私家车占用', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (219, 1, 'PT-047', '公共安全', '鼓楼区定淮门大街高空广告牌螺丝松动', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (220, 1, 'PT-048', '公共安全', '玄武区进香河路商场消防栓被货物遮挡', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (221, 1, 'PT-049', '公共安全', '秦淮区升州路老旧小区楼道堆放易燃杂物', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (222, 1, 'PT-050', '公共安全', '栖霞区迈皋桥街道人行道路面塌陷，形成深坑', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (223, 1, 'PT-051', '公共安全', '雨花台区铁心桥大街围墙倾斜，裂缝明显', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (224, 1, 'PT-052', '公共安全', '江宁区百家湖大街施工围挡缺失，行人可随意进入', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (225, 1, 'PT-053', '公共安全', '浦口区江浦街道消防栓锈死无法开启', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (226, 1, 'PT-054', '公共安全', '六合区雄州街道摊贩占用消防通道经营', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (227, 1, 'PT-055', '公共安全', '溧水区永阳街道高层住宅外墙脱落风险', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (228, 1, 'PT-056', '公共安全', '高淳区淳溪街道窨井盖缺失，仅用木板遮盖', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (229, 1, 'PT-057', '公共安全', '鼓楼区三牌楼大街商场消防通道被杂物堵占', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (230, 1, 'PT-058', '公共安全', '玄武区锁金村街道灭火器全部过期', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (231, 1, 'PT-059', '公共安全', '秦淮区夫子庙景区广告牌固定件锈蚀严重', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (232, 1, 'PT-060', '公共安全', '建邺区兴隆大街小区消防通道长期停放电动车', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (233, 1, 'PT-061', '供水供电', '栖霞区马群街道供水管道爆裂，路面涌水', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (234, 1, 'PT-062', '供水供电', '鼓楼区中央门街道小区突然停电，多户受影响', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (235, 1, 'PT-063', '供水供电', '玄武区孝陵卫街道电压不稳，电器频繁重启', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (236, 1, 'PT-064', '供水供电', '秦淮区双塘街道供水管道漏水，墙角渗水', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (237, 1, 'PT-065', '供水供电', '建邺区沙洲街道小区停水超过12小时', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (238, 1, 'PT-066', '供水供电', '雨花台区赛虹桥街道电缆井盖破损，电缆外露', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (239, 1, 'PT-067', '供水供电', '江宁区秣陵街道小区供电箱短路冒火花', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (240, 1, 'PT-068', '供水供电', '浦口区顶山街道供水管道老化，水质发黄', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (241, 1, 'PT-069', '供水供电', '六合区大厂街道小区频繁跳闸停电', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (242, 1, 'PT-070', '供水供电', '溧水区柘塘街道电压异常，空调无法启动', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (243, 1, 'PT-071', '供水供电', '高淳区漆桥街道供水不足，二楼以上无水', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (244, 1, 'PT-072', '供水供电', '鼓楼区幕府山街道供电线路被树枝压住', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (245, 1, 'PT-073', '供水供电', '玄武区玄武湖街道水压不足，热水器无法点火', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (246, 1, 'PT-074', '供水供电', '秦淮区红花街道停电抢修后未恢复', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (247, 1, 'PT-075', '供水供电', '建邺区南苑街道供水管道老化，频繁爆管', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (248, 1, 'PT-076', '噪音扰民', '雨花台区西善桥街道工地夜间打桩噪音', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (249, 1, 'PT-077', '噪音扰民', '鼓楼区湖南路街道酒吧低音炮震动扰民', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (250, 1, 'PT-078', '噪音扰民', '玄武区锁金村街道广场舞音响音量过大', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (251, 1, 'PT-079', '噪音扰民', '秦淮区光华路街道道路施工破碎机噪音', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (252, 1, 'PT-080', '供水供电', '建邺区莫愁湖街道小区装修电钻声持续', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (253, 1, 'PT-081', '噪音扰民', '栖霞区燕子矶街道工厂风机噪音', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (254, 1, 'PT-082', '噪音扰民', '江宁区东山街道夜市摊贩叫卖声', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (255, 1, 'PT-083', '噪音扰民', '浦口区泰山街道工地混凝土搅拌车噪音', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (256, 1, 'PT-084', '噪音扰民', '六合区葛塘街道KTV深夜歌声扰民', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (257, 1, 'PT-085', '噪音扰民', '溧水区开发区道路夜间施工机械噪音', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (258, 1, 'PT-086', '噪音扰民', '高淳区淳溪街道商铺高音喇叭促销', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (259, 1, 'PT-087', '噪音扰民', '鼓楼区热河南路街道空调外机噪音', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (260, 1, 'PT-088', '噪音扰民', '玄武区梅园街道宠物店犬吠扰民', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (261, 1, 'PT-089', '噪音扰民', '秦淮区秦虹街道铝合金加工切割噪音', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (262, 1, 'PT-090', '噪音扰民', '建邺区兴隆街道地铁施工夜间噪音', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (263, 1, 'PT-091', '设施维修', '栖霞区龙潭街道井盖缺失', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (264, 1, 'PT-092', '其他', '鼓楼区华侨路街道路面不平', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (265, 1, 'PT-093', '其他', '玄武区新街口街道绿化带被踩踏', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (266, 1, 'PT-094', '其他', '秦淮区中华门街道墙面乱涂乱画', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (267, 1, 'PT-095', '环境卫生', '建邺区双闸街道道路积水', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (268, 1, 'PT-096', '其他', '雨花台区板桥街道垃圾桶破损', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (269, 1, 'PT-097', '其他', '江宁区淳化街道乱堆物', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (270, 1, 'PT-098', '其他', '六合区程桥街道违章搭建', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (271, 1, 'PT-099', '其他', '浦口区汤泉街道绿化带缺株', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (272, 1, 'PT-100', '其他', '高淳区桠溪街道乱贴小广告', '1', '小西', '2026-09-18 10:00:51', NULL, '2026-09-18 10:00:51', NULL);
INSERT INTO `patrol_record` VALUES (273, 1, 'PC-1791619524803', '其他', '1', '1', '小西', '2026-10-10 16:05:24', '', '2026-10-10 16:05:24', NULL);

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '产品ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '产品名称',
  `type` enum('ticket','product') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '产品类型：ticket-门票, product-普通商品',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类别',
  `price` decimal(10, 2) NOT NULL COMMENT '售价',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '产品描述',
  `open_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开放时间',
  `base_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '基础价（用于折扣计算）',
  `avg_score` decimal(3, 2) NULL DEFAULT 0.00 COMMENT '平均评分',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态（1-上架，0-下架）',
  `qr_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '二维码（门票）',
  `ticket_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '票型（如成人票、儿童票）',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '产品表（含门票及普通商品）' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of products
-- ----------------------------

-- ----------------------------
-- Table structure for rectify_task
-- ----------------------------
DROP TABLE IF EXISTS `rectify_task`;
CREATE TABLE `rectify_task`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `patrol_record_id` bigint(20) NULL DEFAULT NULL COMMENT '关联巡检记录ID',
  `project_id` bigint(20) NULL DEFAULT NULL COMMENT '关联项目ID',
  `provider_id` bigint(20) NULL DEFAULT NULL COMMENT '分配给哪个服务商',
  `task_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务编号',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '问题描述',
  `deadline` datetime NULL DEFAULT NULL COMMENT '整改期限',
  `status` int(11) NULL DEFAULT 0 COMMENT '0待整改 1整改中 2待复核 3已通过 4已驳回',
  `rectify_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务商整改说明',
  `rectify_images` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '整改照片',
  `review_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '巡查员复核意见',
  `created_at` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of rectify_task
-- ----------------------------
INSERT INTO `rectify_task` VALUES (2, 66, 5, 5, 'RT-1787299883186', '幸福花园水房供水有问题', '2026-08-28 16:11:23', 0, NULL, NULL, NULL, '2026-08-21 16:11:23', NULL);
INSERT INTO `rectify_task` VALUES (3, 67, 4, 4, 'RT-1787644245306', '幸福小区门口无安保人员看守', '2026-09-01 15:50:45', 0, NULL, NULL, NULL, '2026-08-25 15:50:45', NULL);
INSERT INTO `rectify_task` VALUES (4, 68, 5, 5, 'RT-1787644800587', '供电房时常短路', '2026-09-01 16:00:00', 0, NULL, NULL, NULL, '2026-08-25 16:00:00', NULL);
INSERT INTO `rectify_task` VALUES (5, 69, 5, 5, 'RT-1788404906111', '栖霞区仙林大道沿线配电箱门锁损坏，线路裸露，存在触电隐患', '2026-09-10 11:08:26', 0, NULL, NULL, NULL, '2026-09-03 11:08:26', NULL);
INSERT INTO `rectify_task` VALUES (6, 70, 5, 5, 'RT-1788404920164', '栖霞区尧化门小区二次供水泵房压力异常，管道有漏水迹象', '2026-09-10 11:08:40', 0, NULL, NULL, NULL, '2026-09-03 11:08:40', NULL);
INSERT INTO `rectify_task` VALUES (7, 71, 1, 1, 'RT-1788595991356', '鼓楼区中山路沿街垃圾桶满溢，垃圾散落地面，有油污渗出，影响市容环境', '2026-09-12 16:13:11', 0, NULL, NULL, NULL, '2026-09-05 16:13:11', NULL);
INSERT INTO `rectify_task` VALUES (8, 72, 1, 1, 'RT-1788606878528', '鼓楼区中山路沿街垃圾桶满溢，垃圾散落地面', '2026-09-12 19:14:38', 0, NULL, NULL, NULL, '2026-09-05 19:14:38', NULL);
INSERT INTO `rectify_task` VALUES (9, 273, 1, 1, 'RT-1791619524918', '1', '2026-10-17 16:05:24', 0, NULL, NULL, NULL, '2026-10-10 16:05:24', NULL);

-- ----------------------------
-- Table structure for service_provider
-- ----------------------------
DROP TABLE IF EXISTS `service_provider`;
CREATE TABLE `service_provider`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `company_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公司名称',
  `contact_person` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `status` int(11) NULL DEFAULT 1 COMMENT '状态 0禁用 1正常',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `area` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责片区',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '擅长处理的问题类型',
  `business_license` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '营业执照',
  `qualification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '资质证书',
  `qualification_cert` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '从业人员资格证明',
  `license_expire_date` date NULL DEFAULT NULL COMMENT '营业执照到期日期',
  `qualification_expire_date` date NULL DEFAULT NULL COMMENT '资质证书到期日期',
  `credit_rating` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'B' COMMENT '信用评级: A/B/C/D',
  `credit_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '统一社会信用代码',
  `business_scope` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '经营范围',
  `legal_person` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '法人信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '外包服务商表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of service_provider
-- ----------------------------
INSERT INTO `service_provider` VALUES (1, '鼓楼环卫服务公司', '张经理', '13800001111', '鼓楼区环卫路1号', 1, '2026-08-20 14:44:31', NULL, '鼓楼区', '环境卫生', NULL, NULL, NULL, '2026-09-04', '2026-09-09', 'A', '91320100MA1XXXXX01', '城市环卫保洁、垃圾清运、垃圾分类处理', '张建国');
INSERT INTO `service_provider` VALUES (2, '玄武市政养护公司', '李主管', '13800002222', '玄武区养护路2号', 1, '2026-08-20 14:44:31', '2026-08-20 16:35:27', '玄武区', '绿化养护', NULL, NULL, NULL, '2026-07-01', '2026-08-02', 'B', '91320100MA1XXXXX02', '园林绿化工程、绿化养护、苗木种植销售', '李明辉');
INSERT INTO `service_provider` VALUES (3, '秦淮设施维修公司', '王工', '13800003333', '秦淮区维修路3号', 1, '2026-08-20 14:44:31', '2026-08-20 16:40:10', '秦淮区', '设施维修', NULL, NULL, NULL, '2026-07-01', '2027-08-20', 'B', '91320100MA1XXXXX03', '市政设施维修、建筑修缮、水电安装工程', '王建平');
INSERT INTO `service_provider` VALUES (4, '建邺公共安全管理公司', '赵队长', '13800004444', '建邺区安全路4号', 1, '2026-08-20 14:44:31', NULL, '建邺区', '公共安全', NULL, NULL, NULL, '2027-08-20', '2027-08-20', 'C', '91320100MA1XXXXX04', '公共安全巡查、安保服务、消防设施维护', '赵卫东');
INSERT INTO `service_provider` VALUES (5, '栖霞供水供电维修公司', '孙工', '13800005555', '栖霞区水电路5号', 1, '2026-08-20 14:44:31', NULL, '栖霞区', '供水供电', NULL, NULL, NULL, '2027-08-20', '2027-08-20', 'B', '91320100MA1XXXXX05', '供水管道维护、电力设施检修、水泵房运营维护', '孙晓明');
INSERT INTO `service_provider` VALUES (6, '雨花噪音治理公司', '周经理', '13800006666', '雨花台区宁静路6号', 1, '2026-08-20 14:44:31', NULL, '雨花台区', '噪音扰民', NULL, NULL, NULL, '2027-08-20', '2027-08-20', 'C', '91320100MA1XXXXX06', '噪音治理、声学工程设计、隔音降噪工程施工', '周建强');
INSERT INTO `service_provider` VALUES (7, '江宁垃圾分类处理公司', '吴主管', '13800007777', '江宁区分类路7号', 1, '2026-08-20 14:44:31', NULL, '江宁区', '环境卫生', NULL, NULL, NULL, NULL, NULL, 'A', '91320100MA1XXXXX07', '垃圾分类处理、资源回收利用、环保技术咨询', '吴海涛');
INSERT INTO `service_provider` VALUES (8, '浦口绿化工程公司', '郑经理', '13800008888', '浦口区绿化路8号', 1, '2026-08-20 14:44:31', NULL, '浦口区', '绿化养护', NULL, NULL, NULL, NULL, NULL, 'B', '91320100MA1XXXXX08', '园林绿化工程施工、绿化养护、景观设计', '郑文明');
INSERT INTO `service_provider` VALUES (9, '六合道路设施维修公司', '钱工', '13800009999', '六合区道路路9号', 1, '2026-08-20 14:44:31', NULL, '六合区', '设施维修', NULL, NULL, NULL, NULL, NULL, 'B', '91320100MA1XXXXX09', '道路设施维修、桥梁养护、交通设施维护', '钱建华');
INSERT INTO `service_provider` VALUES (10, '溧水公共安全服务公司', '冯队长', '13800001010', '溧水区安全路10号', 1, '2026-08-20 14:44:31', NULL, '溧水区', '公共安全', NULL, NULL, NULL, NULL, NULL, 'B', '91320100MA1XXXXX10', '公共安全巡查、应急事件处理、社区安保服务', '冯志强');
INSERT INTO `service_provider` VALUES (11, '高淳供水服务公司', '蒋工', '13800001112', '高淳区供水路11号', 1, '2026-08-20 14:44:31', NULL, '高淳区', '供水供电', NULL, NULL, NULL, NULL, NULL, 'B', '91320100MA1XXXXX11', '供水保障服务、供水管道维修、水质监测', '蒋伟明');
INSERT INTO `service_provider` VALUES (12, '鼓楼绿化养护公司', '沈主管', '13800002223', '鼓楼区养护路12号', 1, '2026-08-20 14:44:31', NULL, '鼓楼区', '绿化养护', NULL, NULL, NULL, NULL, NULL, 'C', '91320100MA1XXXXX12', '绿化养护、园林管理、花卉种植销售', '沈国平');
INSERT INTO `service_provider` VALUES (13, '秦淮环境卫生公司', '韩经理', '13800003334', '秦淮区环境路13号', 1, '2026-08-20 14:44:31', NULL, '秦淮区', '环境卫生', NULL, NULL, NULL, NULL, NULL, 'B', '91320100MA1XXXXX13', '环境卫生保洁、垃圾清运、市容管理', '韩春林');
INSERT INTO `service_provider` VALUES (14, '建邺设施维修公司', '杨工', '13800004445', '建邺区维修路14号', 1, '2026-08-20 14:44:31', NULL, '建邺区', '设施维修', NULL, NULL, NULL, NULL, NULL, 'B', '91320100MA1XXXXX14', '设施维修、建筑修缮、物业管理', '杨建新');
INSERT INTO `service_provider` VALUES (15, '玄武垃圾分类公司', '朱主管', '13800005556', '玄武区分类路15号', 1, '2026-08-20 14:44:31', NULL, '玄武区', '环境卫生', NULL, NULL, NULL, NULL, NULL, 'C', '91320100MA1XXXXX15', '垃圾分类处理、环保技术开发、资源回收', '朱瑞华');
INSERT INTO `service_provider` VALUES (16, '栖霞公共安全公司', '许队长', '13800006667', '栖霞区安全路16号', 1, '2026-08-20 14:44:31', NULL, '栖霞区', '公共安全', NULL, NULL, NULL, NULL, NULL, 'B', '91320100MA1XXXXX16', '公共安全巡查、监控设备安装、安保服务', '许志刚');
INSERT INTO `service_provider` VALUES (17, '雨花绿化养护公司', '何经理', '13800007778', '雨花台区绿化路17号', 1, '2026-08-20 14:44:31', NULL, '雨花台区', '绿化养护', NULL, NULL, NULL, NULL, NULL, 'B', '91320100MA1XXXXX17', '绿化养护、园林工程、苗木培育', '何永清');
INSERT INTO `service_provider` VALUES (18, '江宁供水供电公司', '吕工', '13800008889', '江宁区水电路18号', 1, '2026-08-20 14:44:31', NULL, '江宁区', '供水供电', NULL, NULL, NULL, NULL, NULL, 'B', '91320100MA1XXXXX18', '供水供电服务、水电维修、管道施工', '吕海平');
INSERT INTO `service_provider` VALUES (19, '洁城环境科技有限公司', '张明', '13812345678', '南京市鼓楼区中山路88号', 1, '2026-08-20 15:28:35', '2026-08-20 15:40:48', '鼓楼区', NULL, NULL, NULL, NULL, NULL, NULL, 'A', '91320100MA1XXXXX19', '环卫保洁、垃圾清运、垃圾分类、环境治理', '刘和平');
INSERT INTO `service_provider` VALUES (20, '恒达设施维修服务公司', '王强', '13700001111', '南京市秦淮区中华路99号', 1, '2026-08-20 15:40:27', '2026-09-05 19:11:39', '秦淮区', NULL, '', '', NULL, NULL, NULL, 'D', '91320100MA1XXXXX20', '市政设施维修、管道疏通、水电安装、应急抢修', '陈建国');
INSERT INTO `service_provider` VALUES (21, '安达公共安全服务公司', '陈刚', '15877776666', '建邺区河西大街128号', 0, '2026-08-20 15:44:22', '2026-08-20 15:44:22', '建邺区', NULL, NULL, NULL, NULL, NULL, NULL, 'D', '91320100MA1XXXXX21', '公共安全巡查、消防设施维护、安全技术防范', '林志强');
INSERT INTO `service_provider` VALUES (22, '栖霞供水供电公司', '刘洋', '18055554444', '南京市栖霞区水电路18号', 0, '2026-08-20 17:29:14', '2026-08-20 17:29:14', NULL, NULL, '', '', '', NULL, NULL, 'D', '91320100MA1XXXXX22', '供水供电服务、管网维护、泵站运营', '邓卫民');
INSERT INTO `service_provider` VALUES (23, '江宁宝洁环境服务有限公司', '沙雨荞', '18888888888', '', 1, '2026-08-25 16:04:27', '2026-08-25 16:05:15', NULL, NULL, '/uploads/license/2026-08-25/aaea7dfd710a441d9a90c3f1dd1503a620260825160358.jpeg', '', '', NULL, NULL, 'B', '111111111111111111', '保洁服务、环境卫生管理、垃圾分类', '沙雨荞');

-- ----------------------------
-- Table structure for settlement_order
-- ----------------------------
DROP TABLE IF EXISTS `settlement_order`;
CREATE TABLE `settlement_order`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `assess_result_id` bigint(20) NOT NULL COMMENT '考核记录ID',
  `provider_id` bigint(20) NOT NULL COMMENT '服务商ID',
  `settlement_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '结算单号',
  `base_amount` decimal(12, 2) NULL DEFAULT 0.00 COMMENT '基础金额',
  `deduct_amount` decimal(12, 2) NULL DEFAULT 0.00 COMMENT '扣减金额',
  `paid_amount` decimal(12, 2) NULL DEFAULT 0.00 COMMENT '实付金额',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` int(11) NULL DEFAULT 0 COMMENT '结算状态',
  `settlement_time` datetime NULL DEFAULT NULL COMMENT '结算时间',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_settle_assess`(`assess_result_id`) USING BTREE,
  INDEX `fk_settle_provider`(`provider_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 118 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '费用结算单表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of settlement_order
-- ----------------------------
INSERT INTO `settlement_order` VALUES (74, 40, 1, 'SET-1787645553362', 50000.00, 5000.00, 45000.00, '根据 2026-08 月考核得分自动结算', 1, '2026-08-25 16:12:33', '2026-08-25 16:12:33', NULL);
INSERT INTO `settlement_order` VALUES (75, 41, 2, 'SET-1787645553380', 35000.00, 3500.00, 31500.00, '根据 2026-08 月考核得分自动结算', 0, '2026-08-25 16:12:33', '2026-08-25 16:12:33', NULL);
INSERT INTO `settlement_order` VALUES (76, 42, 3, 'SET-1787645553393', 28000.00, 2800.00, 25200.00, '根据 2026-08 月考核得分自动结算', 0, '2026-08-25 16:12:33', '2026-08-25 16:12:33', NULL);
INSERT INTO `settlement_order` VALUES (77, 43, 4, 'SET-1787645553405', 42000.00, 4200.00, 37800.00, '根据 2026-08 月考核得分自动结算', 0, '2026-08-25 16:12:33', '2026-08-25 16:12:33', NULL);
INSERT INTO `settlement_order` VALUES (78, 44, 5, 'SET-1787645553418', 38000.00, 3800.00, 34200.00, '根据 2026-08 月考核得分自动结算', 0, '2026-08-25 16:12:33', '2026-08-25 16:12:33', NULL);
INSERT INTO `settlement_order` VALUES (79, 45, 6, 'SET-1787645553431', 22000.00, 2200.00, 19800.00, '根据 2026-08 月考核得分自动结算', 0, '2026-08-25 16:12:33', '2026-08-25 16:12:33', NULL);
INSERT INTO `settlement_order` VALUES (80, 46, 7, 'SET-1787645553446', 78000.00, 0.00, 78000.00, '根据 2026-08 月考核得分自动结算', 0, '2026-08-25 16:12:33', '2026-08-25 16:12:33', NULL);
INSERT INTO `settlement_order` VALUES (81, 47, 8, 'SET-1787645553456', 32000.00, 0.00, 32000.00, '根据 2026-08 月考核得分自动结算', 0, '2026-08-25 16:12:33', '2026-08-25 16:12:33', NULL);
INSERT INTO `settlement_order` VALUES (82, 48, 9, 'SET-1787645553471', 45000.00, 0.00, 45000.00, '根据 2026-08 月考核得分自动结算', 0, '2026-08-25 16:12:33', '2026-08-25 16:12:33', NULL);
INSERT INTO `settlement_order` VALUES (83, 49, 10, 'SET-1787645553486', 28000.00, 0.00, 28000.00, '根据 2026-08 月考核得分自动结算', 0, '2026-08-25 16:12:33', '2026-08-25 16:12:33', NULL);
INSERT INTO `settlement_order` VALUES (84, 50, 11, 'SET-1787645553500', 35000.00, 0.00, 35000.00, '根据 2026-08 月考核得分自动结算', 0, '2026-08-25 16:12:33', '2026-08-25 16:12:33', NULL);
INSERT INTO `settlement_order` VALUES (107, 172, 1, 'SET-1789616910105', 50000.00, 10000.00, 40000.00, '根据 2026-09 月考核得分自动结算', 0, '2026-09-17 11:48:30', '2026-09-17 11:48:30', NULL);
INSERT INTO `settlement_order` VALUES (108, 173, 2, 'SET-1789616910135', 35000.00, 3500.00, 31500.00, '根据 2026-09 月考核得分自动结算', 0, '2026-09-17 11:48:30', '2026-09-17 11:48:30', NULL);
INSERT INTO `settlement_order` VALUES (109, 174, 3, 'SET-1789616910148', 28000.00, 2800.00, 25200.00, '根据 2026-09 月考核得分自动结算', 0, '2026-09-17 11:48:30', '2026-09-17 11:48:30', NULL);
INSERT INTO `settlement_order` VALUES (110, 175, 4, 'SET-1789616910162', 42000.00, 8400.00, 33600.00, '根据 2026-09 月考核得分自动结算', 0, '2026-09-17 11:48:30', '2026-09-17 11:48:30', NULL);
INSERT INTO `settlement_order` VALUES (111, 176, 5, 'SET-1789616910176', 38000.00, 7600.00, 30400.00, '根据 2026-09 月考核得分自动结算', 0, '2026-09-17 11:48:30', '2026-09-17 11:48:30', NULL);
INSERT INTO `settlement_order` VALUES (112, 177, 6, 'SET-1789616910189', 22000.00, 2200.00, 19800.00, '根据 2026-09 月考核得分自动结算', 0, '2026-09-17 11:48:30', '2026-09-17 11:48:30', NULL);
INSERT INTO `settlement_order` VALUES (113, 178, 7, 'SET-1789616910202', 78000.00, 7800.00, 70200.00, '根据 2026-09 月考核得分自动结算', 0, '2026-09-17 11:48:30', '2026-09-17 11:48:30', NULL);
INSERT INTO `settlement_order` VALUES (114, 179, 8, 'SET-1789616910213', 32000.00, 0.00, 32000.00, '根据 2026-09 月考核得分自动结算', 0, '2026-09-17 11:48:30', '2026-09-17 11:48:30', NULL);
INSERT INTO `settlement_order` VALUES (115, 180, 9, 'SET-1789616910225', 45000.00, 4500.00, 40500.00, '根据 2026-09 月考核得分自动结算', 0, '2026-09-17 11:48:30', '2026-09-17 11:48:30', NULL);
INSERT INTO `settlement_order` VALUES (116, 181, 10, 'SET-1789616910236', 28000.00, 0.00, 28000.00, '根据 2026-09 月考核得分自动结算', 0, '2026-09-17 11:48:30', '2026-09-17 11:48:30', NULL);
INSERT INTO `settlement_order` VALUES (117, 182, 11, 'SET-1789616910248', 35000.00, 0.00, 35000.00, '根据 2026-09 月考核得分自动结算', 0, '2026-09-17 11:48:30', '2026-09-17 11:48:30', NULL);

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `operation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1051 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES (1, '管理员', '用户注册：石头（citizen）', '2026-08-20 11:57:48');
INSERT INTO `sys_log` VALUES (2, '管理员', '用户注册：石头（citizen）', '2026-08-20 14:14:57');
INSERT INTO `sys_log` VALUES (3, '管理员', '用户注册：王兵（citizen）', '2026-08-20 14:20:34');
INSERT INTO `sys_log` VALUES (4, '管理员', '执行了智能考核核算，生成了 6 条考核记录', '2026-08-20 14:53:57');
INSERT INTO `sys_log` VALUES (5, '系统', '服务商入驻申请提交：洁城环境科技有限公司，联系人：张明，状态：待审核', '2026-08-20 15:28:35');
INSERT INTO `sys_log` VALUES (6, '管理员', '用户注册：小西（inspector）', '2026-08-20 15:39:09');
INSERT INTO `sys_log` VALUES (7, '系统', '服务商入驻申请提交：恒达设施维修服务公司，联系人：王强，状态：待审核', '2026-08-20 15:40:27');
INSERT INTO `sys_log` VALUES (8, '管理员', '服务商入驻审核通过：洁城环境科技有限公司，审核人：管理员', '2026-08-20 15:40:48');
INSERT INTO `sys_log` VALUES (9, '管理员', '服务商手动录入：安达公共安全服务公司，录入人：管理员', '2026-08-20 15:44:22');
INSERT INTO `sys_log` VALUES (10, '管理员', '用户注册：成灿（provider）', '2026-08-20 15:52:28');
INSERT INTO `sys_log` VALUES (11, '管理员', '执行了智能考核核算，生成了 1 条考核记录', '2026-08-20 15:54:13');
INSERT INTO `sys_log` VALUES (12, '管理员', '执行了智能考核核算，生成了 0 条考核记录', '2026-08-20 15:58:16');
INSERT INTO `sys_log` VALUES (13, '管理员', '执行了智能考核核算，生成了 0 条考核记录', '2026-08-20 16:00:37');
INSERT INTO `sys_log` VALUES (14, '管理员', '执行了智能考核核算，生成了 0 条考核记录', '2026-08-20 16:01:27');
INSERT INTO `sys_log` VALUES (15, '管理员', '执行了智能考核核算，生成了 7 条考核记录', '2026-08-20 16:02:02');
INSERT INTO `sys_log` VALUES (16, '管理员', '服务商信息编辑：玄武市政养护公司，修改人：管理员', '2026-08-20 16:34:54');
INSERT INTO `sys_log` VALUES (17, '管理员', '服务商信息编辑：玄武市政养护公司，修改人：管理员', '2026-08-20 16:35:27');
INSERT INTO `sys_log` VALUES (18, '管理员', '服务商信息编辑：玄武市政养护公司，修改人：管理员', '2026-08-20 16:39:07');
INSERT INTO `sys_log` VALUES (19, '管理员', '服务商信息编辑：玄武市政养护公司，修改人：管理员', '2026-08-20 16:40:10');
INSERT INTO `sys_log` VALUES (20, '系统', '服务商入驻申请提交：栖霞供水供电公司，账号已创建，状态：待审核', '2026-08-20 17:29:14');
INSERT INTO `sys_log` VALUES (21, '市民', '市民工单评价：WO-20260820165622，满意度：5星，评价人：市民', '2026-08-21 10:57:43');
INSERT INTO `sys_log` VALUES (22, '市民', '市民工单评价：WO-20260821110649，满意度：5星，评价人：市民', '2026-08-21 11:08:57');
INSERT INTO `sys_log` VALUES (23, '管理员', '月度结算单生成：2026-08月，生成结算单数：7', '2026-08-21 11:16:39');
INSERT INTO `sys_log` VALUES (24, '管理员', '执行了智能考核核算，生成了 0 条考核记录', '2026-08-21 11:16:48');
INSERT INTO `sys_log` VALUES (25, '管理员', '执行了智能考核核算，生成了 0 条考核记录', '2026-08-21 11:18:05');
INSERT INTO `sys_log` VALUES (26, '管理员', '月度结算单生成：2026-08月，生成结算单数：7', '2026-08-21 11:18:11');
INSERT INTO `sys_log` VALUES (27, '管理员', '执行了智能考核核算，生成了 0 条考核记录', '2026-08-21 11:18:36');
INSERT INTO `sys_log` VALUES (28, '管理员', '执行了智能考核核算，生成了 7 条考核记录', '2026-08-21 11:28:54');
INSERT INTO `sys_log` VALUES (29, '管理员', '月度结算单生成：2026-08月，生成结算单数：7', '2026-08-21 11:28:57');
INSERT INTO `sys_log` VALUES (30, '管理员', '月度结算单生成：2026-08月，生成结算单数：7', '2026-08-21 11:50:58');
INSERT INTO `sys_log` VALUES (31, '管理员', '执行了智能考核核算，生成了 7 条考核记录', '2026-08-21 11:51:53');
INSERT INTO `sys_log` VALUES (32, '管理员', '月度结算单生成：2026-08月，生成结算单数：7', '2026-08-21 11:51:58');
INSERT INTO `sys_log` VALUES (33, '管理员', '智能考核核算执行：2026-08月，生成考核记录数：11', '2026-08-21 11:52:48');
INSERT INTO `sys_log` VALUES (34, '管理员', '月度结算单生成：2026-08月，生成结算单数：11', '2026-08-21 11:52:50');
INSERT INTO `sys_log` VALUES (35, '管理员', '用户注册：小沙（citizen）', '2026-08-25 15:58:16');
INSERT INTO `sys_log` VALUES (36, '市民', '市民工单评价：WO-20260825155851，满意度：5星，评价人：市民', '2026-08-25 16:01:41');
INSERT INTO `sys_log` VALUES (37, '系统', '服务商入驻申请：江宁宝洁公司，账号已创建', '2026-08-25 16:04:27');
INSERT INTO `sys_log` VALUES (38, '管理员', '服务商入驻审核通过：江宁宝洁公司，账号已启用，审核人：管理员', '2026-08-25 16:05:15');
INSERT INTO `sys_log` VALUES (39, '管理员', '智能考核核算执行：2026-08月，生成考核记录数：12', '2026-08-25 16:12:13');
INSERT INTO `sys_log` VALUES (40, '管理员', '月度结算单生成：2026-08月，生成结算单数：11', '2026-08-25 16:12:33');
INSERT INTO `sys_log` VALUES (41, '管理员', '结算单审核通过：结算单号 SET-1787645553362，审核人：管理员', '2026-08-25 16:13:43');
INSERT INTO `sys_log` VALUES (42, '管理员', '执行了智能考核核算，生成了 12 条考核记录', '2026-09-03 11:08:55');
INSERT INTO `sys_log` VALUES (43, '管理员', '执行了智能考核核算，生成了 12 条考核记录', '2026-09-03 11:09:01');
INSERT INTO `sys_log` VALUES (44, '管理员', '执行了智能考核核算，生成了 12 条考核记录', '2026-09-03 11:55:36');
INSERT INTO `sys_log` VALUES (45, '管理员', '执行了智能考核核算，生成了 12 条考核记录', '2026-09-03 11:55:46');
INSERT INTO `sys_log` VALUES (46, '管理员', '生成了 2026-09 月的结算单，共 11 条', '2026-09-03 11:55:55');
INSERT INTO `sys_log` VALUES (47, '管理员', '执行了智能考核核算，生成了 12 条考核记录', '2026-09-03 16:42:08');
INSERT INTO `sys_log` VALUES (48, '管理员', '执行了智能考核核算，生成了 12 条考核记录', '2026-09-05 17:12:03');
INSERT INTO `sys_log` VALUES (49, '管理员', '执行了智能考核核算，生成了 12 条考核记录', '2026-09-05 17:13:38');
INSERT INTO `sys_log` VALUES (50, '管理员', '人工微调考核结果 ID:40，项目ID:1，分数从 60.00 调整为 55，备注：人工微调', '2026-09-05 17:16:18');
INSERT INTO `sys_log` VALUES (51, '管理员', '人工微调考核结果 ID:40，项目ID:1，分数从 55.00 调整为 55，备注：人工微调', '2026-09-05 17:16:25');
INSERT INTO `sys_log` VALUES (52, '管理员', '生成了 2026-09 月的结算单，共 11 条', '2026-09-05 19:04:28');
INSERT INTO `sys_log` VALUES (53, '管理员', '审核通过服务商入驻：恒达设施维修服务公司，账号已启用', '2026-09-05 19:11:39');
INSERT INTO `sys_log` VALUES (54, '管理员', '执行了智能考核核算，生成了 12 条考核记录', '2026-09-17 10:08:33');
INSERT INTO `sys_log` VALUES (55, '管理员', '执行了智能考核核算，生成了 12 条考核记录', '2026-09-17 10:11:00');
INSERT INTO `sys_log` VALUES (56, '管理员', '执行了智能考核核算，生成了 12 条考核记录', '2026-09-17 10:12:30');
INSERT INTO `sys_log` VALUES (57, '管理员', '执行了智能考核核算，生成了 12 条考核记录', '2026-09-17 10:16:18');
INSERT INTO `sys_log` VALUES (58, '管理员', '生成了 2026-09 月的结算单，共 11 条', '2026-09-17 11:48:30');
INSERT INTO `sys_log` VALUES (821, '小西', '提交了巡检记录：PT-001，系统自动识别类型为：环境卫生', '2026-09-18 09:02:27');
INSERT INTO `sys_log` VALUES (822, '小西', '提交了巡检记录：PT-002，系统自动识别类型为：环境卫生', '2026-09-18 09:02:50');
INSERT INTO `sys_log` VALUES (823, '小西', '提交了巡检记录：PT-003，系统自动识别类型为：环境卫生', '2026-09-18 09:01:02');
INSERT INTO `sys_log` VALUES (824, '小西', '提交了巡检记录：PT-004，系统自动识别类型为：环境卫生', '2026-09-18 09:01:09');
INSERT INTO `sys_log` VALUES (825, '小西', '提交了巡检记录：PT-005，系统自动识别类型为：环境卫生', '2026-09-18 09:02:31');
INSERT INTO `sys_log` VALUES (826, '小西', '提交了巡检记录：PT-006，系统自动识别类型为：环境卫生', '2026-09-18 09:02:40');
INSERT INTO `sys_log` VALUES (827, '小西', '提交了巡检记录：PT-007，系统自动识别类型为：环境卫生', '2026-09-18 09:01:10');
INSERT INTO `sys_log` VALUES (828, '小西', '提交了巡检记录：PT-008，系统自动识别类型为：环境卫生', '2026-09-18 09:02:09');
INSERT INTO `sys_log` VALUES (829, '小西', '提交了巡检记录：PT-009，系统自动识别类型为：环境卫生', '2026-09-18 09:01:26');
INSERT INTO `sys_log` VALUES (830, '小西', '提交了巡检记录：PT-010，系统自动识别类型为：环境卫生', '2026-09-18 09:02:56');
INSERT INTO `sys_log` VALUES (831, '小西', '提交了巡检记录：PT-011，系统自动识别类型为：环境卫生', '2026-09-18 09:02:10');
INSERT INTO `sys_log` VALUES (832, '小西', '提交了巡检记录：PT-012，系统自动识别类型为：环境卫生', '2026-09-18 09:01:42');
INSERT INTO `sys_log` VALUES (833, '小西', '提交了巡检记录：PT-013，系统自动识别类型为：环境卫生', '2026-09-18 09:01:10');
INSERT INTO `sys_log` VALUES (834, '小西', '提交了巡检记录：PT-014，系统自动识别类型为：公共安全', '2026-09-18 09:01:55');
INSERT INTO `sys_log` VALUES (835, '小西', '提交了巡检记录：PT-015，系统自动识别类型为：环境卫生', '2026-09-18 09:01:10');
INSERT INTO `sys_log` VALUES (836, '小西', '提交了巡检记录：PT-016，系统自动识别类型为：绿化养护', '2026-09-18 09:02:55');
INSERT INTO `sys_log` VALUES (837, '小西', '提交了巡检记录：PT-017，系统自动识别类型为：绿化养护', '2026-09-18 09:02:17');
INSERT INTO `sys_log` VALUES (838, '小西', '提交了巡检记录：PT-018，系统自动识别类型为：绿化养护', '2026-09-18 09:02:13');
INSERT INTO `sys_log` VALUES (839, '小西', '提交了巡检记录：PT-019，系统自动识别类型为：绿化养护', '2026-09-18 09:01:46');
INSERT INTO `sys_log` VALUES (840, '小西', '提交了巡检记录：PT-020，系统自动识别类型为：绿化养护', '2026-09-18 09:01:57');
INSERT INTO `sys_log` VALUES (841, '小西', '提交了巡检记录：PT-021，系统自动识别类型为：绿化养护', '2026-09-18 09:02:27');
INSERT INTO `sys_log` VALUES (842, '小西', '提交了巡检记录：PT-022，系统自动识别类型为：绿化养护', '2026-09-18 09:01:00');
INSERT INTO `sys_log` VALUES (843, '小西', '提交了巡检记录：PT-023，系统自动识别类型为：绿化养护', '2026-09-18 09:01:54');
INSERT INTO `sys_log` VALUES (844, '小西', '提交了巡检记录：PT-024，系统自动识别类型为：绿化养护', '2026-09-18 09:01:24');
INSERT INTO `sys_log` VALUES (845, '小西', '提交了巡检记录：PT-025，系统自动识别类型为：绿化养护', '2026-09-18 09:02:36');
INSERT INTO `sys_log` VALUES (846, '小西', '提交了巡检记录：PT-026，系统自动识别类型为：供水供电', '2026-09-18 09:01:08');
INSERT INTO `sys_log` VALUES (847, '小西', '提交了巡检记录：PT-027，系统自动识别类型为：环境卫生', '2026-09-18 09:01:58');
INSERT INTO `sys_log` VALUES (848, '小西', '提交了巡检记录：PT-028，系统自动识别类型为：绿化养护', '2026-09-18 09:02:37');
INSERT INTO `sys_log` VALUES (849, '小西', '提交了巡检记录：PT-029，系统自动识别类型为：绿化养护', '2026-09-18 09:02:00');
INSERT INTO `sys_log` VALUES (850, '小西', '提交了巡检记录：PT-030，系统自动识别类型为：绿化养护', '2026-09-18 09:01:36');
INSERT INTO `sys_log` VALUES (851, '小西', '提交了巡检记录：PT-031，系统自动识别类型为：设施维修', '2026-09-18 09:02:38');
INSERT INTO `sys_log` VALUES (852, '小西', '提交了巡检记录：PT-032，系统自动识别类型为：设施维修', '2026-09-18 09:01:45');
INSERT INTO `sys_log` VALUES (853, '小西', '提交了巡检记录：PT-033，系统自动识别类型为：设施维修', '2026-09-18 09:01:41');
INSERT INTO `sys_log` VALUES (854, '小西', '提交了巡检记录：PT-034，系统自动识别类型为：设施维修', '2026-09-18 09:01:22');
INSERT INTO `sys_log` VALUES (855, '小西', '提交了巡检记录：PT-035，系统自动识别类型为：设施维修', '2026-09-18 09:02:47');
INSERT INTO `sys_log` VALUES (856, '小西', '提交了巡检记录：PT-036，系统自动识别类型为：设施维修', '2026-09-18 09:01:57');
INSERT INTO `sys_log` VALUES (857, '小西', '提交了巡检记录：PT-037，系统自动识别类型为：设施维修', '2026-09-18 09:02:22');
INSERT INTO `sys_log` VALUES (858, '小西', '提交了巡检记录：PT-038，系统自动识别类型为：设施维修', '2026-09-18 09:02:19');
INSERT INTO `sys_log` VALUES (859, '小西', '提交了巡检记录：PT-039，系统自动识别类型为：环境卫生', '2026-09-18 09:02:56');
INSERT INTO `sys_log` VALUES (860, '小西', '提交了巡检记录：PT-040，系统自动识别类型为：设施维修', '2026-09-18 09:02:07');
INSERT INTO `sys_log` VALUES (861, '小西', '提交了巡检记录：PT-041，系统自动识别类型为：设施维修', '2026-09-18 09:01:42');
INSERT INTO `sys_log` VALUES (862, '小西', '提交了巡检记录：PT-042，系统自动识别类型为：设施维修', '2026-09-18 09:02:36');
INSERT INTO `sys_log` VALUES (863, '小西', '提交了巡检记录：PT-043，系统自动识别类型为：设施维修', '2026-09-18 09:01:24');
INSERT INTO `sys_log` VALUES (864, '小西', '提交了巡检记录：PT-044，系统自动识别类型为：环境卫生', '2026-09-18 09:01:12');
INSERT INTO `sys_log` VALUES (865, '小西', '提交了巡检记录：PT-045，系统自动识别类型为：设施维修', '2026-09-18 09:01:26');
INSERT INTO `sys_log` VALUES (866, '小西', '提交了巡检记录：PT-046，系统自动识别类型为：公共安全', '2026-09-18 09:02:30');
INSERT INTO `sys_log` VALUES (867, '小西', '提交了巡检记录：PT-047，系统自动识别类型为：公共安全', '2026-09-18 09:02:55');
INSERT INTO `sys_log` VALUES (868, '小西', '提交了巡检记录：PT-048，系统自动识别类型为：公共安全', '2026-09-18 09:01:12');
INSERT INTO `sys_log` VALUES (869, '小西', '提交了巡检记录：PT-049，系统自动识别类型为：公共安全', '2026-09-18 09:01:33');
INSERT INTO `sys_log` VALUES (870, '小西', '提交了巡检记录：PT-050，系统自动识别类型为：公共安全', '2026-09-18 09:02:56');
INSERT INTO `sys_log` VALUES (871, '小西', '提交了巡检记录：PT-051，系统自动识别类型为：公共安全', '2026-09-18 09:02:03');
INSERT INTO `sys_log` VALUES (872, '小西', '提交了巡检记录：PT-052，系统自动识别类型为：公共安全', '2026-09-18 09:01:20');
INSERT INTO `sys_log` VALUES (873, '小西', '提交了巡检记录：PT-053，系统自动识别类型为：公共安全', '2026-09-18 09:01:03');
INSERT INTO `sys_log` VALUES (874, '小西', '提交了巡检记录：PT-054，系统自动识别类型为：公共安全', '2026-09-18 09:02:03');
INSERT INTO `sys_log` VALUES (875, '小西', '提交了巡检记录：PT-055，系统自动识别类型为：公共安全', '2026-09-18 09:01:36');
INSERT INTO `sys_log` VALUES (876, '小西', '提交了巡检记录：PT-056，系统自动识别类型为：公共安全', '2026-09-18 09:01:12');
INSERT INTO `sys_log` VALUES (877, '小西', '提交了巡检记录：PT-057，系统自动识别类型为：公共安全', '2026-09-18 09:01:24');
INSERT INTO `sys_log` VALUES (878, '小西', '提交了巡检记录：PT-058，系统自动识别类型为：公共安全', '2026-09-18 09:01:50');
INSERT INTO `sys_log` VALUES (879, '小西', '提交了巡检记录：PT-059，系统自动识别类型为：公共安全', '2026-09-18 09:01:38');
INSERT INTO `sys_log` VALUES (880, '小西', '提交了巡检记录：PT-060，系统自动识别类型为：公共安全', '2026-09-18 09:01:31');
INSERT INTO `sys_log` VALUES (881, '小西', '提交了巡检记录：PT-061，系统自动识别类型为：供水供电', '2026-09-18 09:01:25');
INSERT INTO `sys_log` VALUES (882, '小西', '提交了巡检记录：PT-062，系统自动识别类型为：供水供电', '2026-09-18 09:02:26');
INSERT INTO `sys_log` VALUES (883, '小西', '提交了巡检记录：PT-063，系统自动识别类型为：供水供电', '2026-09-18 09:02:29');
INSERT INTO `sys_log` VALUES (884, '小西', '提交了巡检记录：PT-064，系统自动识别类型为：供水供电', '2026-09-18 09:02:33');
INSERT INTO `sys_log` VALUES (885, '小西', '提交了巡检记录：PT-065，系统自动识别类型为：供水供电', '2026-09-18 09:01:21');
INSERT INTO `sys_log` VALUES (886, '小西', '提交了巡检记录：PT-066，系统自动识别类型为：供水供电', '2026-09-18 09:02:38');
INSERT INTO `sys_log` VALUES (887, '小西', '提交了巡检记录：PT-067，系统自动识别类型为：供水供电', '2026-09-18 09:02:14');
INSERT INTO `sys_log` VALUES (888, '小西', '提交了巡检记录：PT-068，系统自动识别类型为：供水供电', '2026-09-18 09:01:44');
INSERT INTO `sys_log` VALUES (889, '小西', '提交了巡检记录：PT-069，系统自动识别类型为：供水供电', '2026-09-18 09:02:16');
INSERT INTO `sys_log` VALUES (890, '小西', '提交了巡检记录：PT-070，系统自动识别类型为：供水供电', '2026-09-18 09:02:20');
INSERT INTO `sys_log` VALUES (891, '小西', '提交了巡检记录：PT-071，系统自动识别类型为：供水供电', '2026-09-18 09:02:13');
INSERT INTO `sys_log` VALUES (892, '小西', '提交了巡检记录：PT-072，系统自动识别类型为：供水供电', '2026-09-18 09:02:14');
INSERT INTO `sys_log` VALUES (893, '小西', '提交了巡检记录：PT-073，系统自动识别类型为：供水供电', '2026-09-18 09:01:25');
INSERT INTO `sys_log` VALUES (894, '小西', '提交了巡检记录：PT-074，系统自动识别类型为：供水供电', '2026-09-18 09:02:03');
INSERT INTO `sys_log` VALUES (895, '小西', '提交了巡检记录：PT-075，系统自动识别类型为：供水供电', '2026-09-18 09:02:13');
INSERT INTO `sys_log` VALUES (896, '小西', '提交了巡检记录：PT-076，系统自动识别类型为：噪音扰民', '2026-09-18 09:01:50');
INSERT INTO `sys_log` VALUES (897, '小西', '提交了巡检记录：PT-077，系统自动识别类型为：噪音扰民', '2026-09-18 09:02:12');
INSERT INTO `sys_log` VALUES (898, '小西', '提交了巡检记录：PT-078，系统自动识别类型为：噪音扰民', '2026-09-18 09:01:10');
INSERT INTO `sys_log` VALUES (899, '小西', '提交了巡检记录：PT-079，系统自动识别类型为：噪音扰民', '2026-09-18 09:01:30');
INSERT INTO `sys_log` VALUES (900, '小西', '提交了巡检记录：PT-080，系统自动识别类型为：供水供电', '2026-09-18 09:01:20');
INSERT INTO `sys_log` VALUES (901, '小西', '提交了巡检记录：PT-081，系统自动识别类型为：噪音扰民', '2026-09-18 09:02:47');
INSERT INTO `sys_log` VALUES (902, '小西', '提交了巡检记录：PT-082，系统自动识别类型为：噪音扰民', '2026-09-18 09:01:04');
INSERT INTO `sys_log` VALUES (903, '小西', '提交了巡检记录：PT-083，系统自动识别类型为：噪音扰民', '2026-09-18 09:02:24');
INSERT INTO `sys_log` VALUES (904, '小西', '提交了巡检记录：PT-084，系统自动识别类型为：噪音扰民', '2026-09-18 09:01:58');
INSERT INTO `sys_log` VALUES (905, '小西', '提交了巡检记录：PT-085，系统自动识别类型为：噪音扰民', '2026-09-18 09:02:18');
INSERT INTO `sys_log` VALUES (906, '小西', '提交了巡检记录：PT-086，系统自动识别类型为：噪音扰民', '2026-09-18 09:02:58');
INSERT INTO `sys_log` VALUES (907, '小西', '提交了巡检记录：PT-087，系统自动识别类型为：噪音扰民', '2026-09-18 09:01:52');
INSERT INTO `sys_log` VALUES (908, '小西', '提交了巡检记录：PT-088，系统自动识别类型为：噪音扰民', '2026-09-18 09:02:52');
INSERT INTO `sys_log` VALUES (909, '小西', '提交了巡检记录：PT-089，系统自动识别类型为：噪音扰民', '2026-09-18 09:02:00');
INSERT INTO `sys_log` VALUES (910, '小西', '提交了巡检记录：PT-090，系统自动识别类型为：噪音扰民', '2026-09-18 09:02:12');
INSERT INTO `sys_log` VALUES (911, '小西', '提交了巡检记录：PT-091，系统自动识别类型为：设施维修', '2026-09-18 09:01:47');
INSERT INTO `sys_log` VALUES (912, '小西', '提交了巡检记录：PT-092，系统自动识别类型为：其他', '2026-09-18 09:02:34');
INSERT INTO `sys_log` VALUES (913, '小西', '提交了巡检记录：PT-093，系统自动识别类型为：其他', '2026-09-18 09:01:44');
INSERT INTO `sys_log` VALUES (914, '小西', '提交了巡检记录：PT-094，系统自动识别类型为：其他', '2026-09-18 09:01:57');
INSERT INTO `sys_log` VALUES (915, '小西', '提交了巡检记录：PT-095，系统自动识别类型为：环境卫生', '2026-09-18 09:02:40');
INSERT INTO `sys_log` VALUES (916, '小西', '提交了巡检记录：PT-096，系统自动识别类型为：其他', '2026-09-18 09:02:22');
INSERT INTO `sys_log` VALUES (917, '小西', '提交了巡检记录：PT-097，系统自动识别类型为：其他', '2026-09-18 09:01:58');
INSERT INTO `sys_log` VALUES (918, '小西', '提交了巡检记录：PT-098，系统自动识别类型为：其他', '2026-09-18 09:01:30');
INSERT INTO `sys_log` VALUES (919, '小西', '提交了巡检记录：PT-099，系统自动识别类型为：其他', '2026-09-18 09:02:53');
INSERT INTO `sys_log` VALUES (920, '小西', '提交了巡检记录：PT-100，系统自动识别类型为：其他', '2026-09-18 09:01:34');
INSERT INTO `sys_log` VALUES (948, '王兵', '提交了诉求工单：WO-TEST-001（鼓楼区+环境卫生），系统自动分派至：鼓楼环卫服务公司', '2026-09-18 10:32:48');
INSERT INTO `sys_log` VALUES (949, '王兵', '提交了诉求工单：WO-TEST-002（鼓楼区+环境卫生），系统自动分派至：鼓楼环卫服务公司', '2026-09-18 10:32:20');
INSERT INTO `sys_log` VALUES (950, '王兵', '提交了诉求工单：WO-TEST-003（鼓楼区+环境卫生），系统自动分派至：鼓楼环卫服务公司', '2026-09-18 10:31:14');
INSERT INTO `sys_log` VALUES (951, '王兵', '提交了诉求工单：WO-TEST-004（鼓楼区+环境卫生），系统自动分派至：鼓楼环卫服务公司', '2026-09-18 10:31:23');
INSERT INTO `sys_log` VALUES (952, '王兵', '提交了诉求工单：WO-TEST-005（鼓楼区+环境卫生），系统自动分派至：鼓楼环卫服务公司', '2026-09-18 10:33:17');
INSERT INTO `sys_log` VALUES (953, '王兵', '提交了诉求工单：WO-TEST-006（鼓楼区+环境卫生），系统自动分派至：鼓楼环卫服务公司', '2026-09-18 10:33:01');
INSERT INTO `sys_log` VALUES (954, '王兵', '提交了诉求工单：WO-TEST-007（鼓楼区+环境卫生），系统自动分派至：鼓楼环卫服务公司', '2026-09-18 10:33:54');
INSERT INTO `sys_log` VALUES (955, '王兵', '提交了诉求工单：WO-TEST-008（鼓楼区+环境卫生），系统自动分派至：鼓楼环卫服务公司', '2026-09-18 10:31:24');
INSERT INTO `sys_log` VALUES (956, '王兵', '提交了诉求工单：WO-TEST-009（鼓楼区+环境卫生），系统自动分派至：鼓楼环卫服务公司', '2026-09-18 10:31:23');
INSERT INTO `sys_log` VALUES (957, '王兵', '提交了诉求工单：WO-TEST-010（鼓楼区+环境卫生），系统自动分派至：鼓楼环卫服务公司', '2026-09-18 10:33:47');
INSERT INTO `sys_log` VALUES (958, '王兵', '提交了诉求工单：WO-TEST-011（鼓楼区+环境卫生），系统自动分派至：鼓楼环卫服务公司', '2026-09-18 10:31:39');
INSERT INTO `sys_log` VALUES (959, '王兵', '提交了诉求工单：WO-TEST-012（鼓楼区+环境卫生），系统自动分派至：鼓楼环卫服务公司', '2026-09-18 10:31:34');
INSERT INTO `sys_log` VALUES (960, '王兵', '提交了诉求工单：WO-TEST-013（鼓楼区+环境卫生），系统自动分派至：鼓楼环卫服务公司', '2026-09-18 10:33:57');
INSERT INTO `sys_log` VALUES (961, '王兵', '提交了诉求工单：WO-TEST-014（鼓楼区+环境卫生），系统自动分派至：鼓楼环卫服务公司', '2026-09-18 10:31:14');
INSERT INTO `sys_log` VALUES (962, '王兵', '提交了诉求工单：WO-TEST-015（鼓楼区+环境卫生），系统自动分派至：鼓楼环卫服务公司', '2026-09-18 10:31:48');
INSERT INTO `sys_log` VALUES (963, '王兵', '提交了诉求工单：WO-TEST-016（玄武区+绿化养护），系统自动分派至：玄武市政养护公司', '2026-09-18 10:33:19');
INSERT INTO `sys_log` VALUES (964, '王兵', '提交了诉求工单：WO-TEST-017（玄武区+绿化养护），系统自动分派至：玄武市政养护公司', '2026-09-18 10:32:53');
INSERT INTO `sys_log` VALUES (965, '王兵', '提交了诉求工单：WO-TEST-018（玄武区+绿化养护），系统自动分派至：玄武市政养护公司', '2026-09-18 10:32:19');
INSERT INTO `sys_log` VALUES (966, '王兵', '提交了诉求工单：WO-TEST-019（玄武区+绿化养护），系统自动分派至：玄武市政养护公司', '2026-09-18 10:32:00');
INSERT INTO `sys_log` VALUES (967, '王兵', '提交了诉求工单：WO-TEST-020（玄武区+绿化养护），系统自动分派至：玄武市政养护公司', '2026-09-18 10:33:16');
INSERT INTO `sys_log` VALUES (968, '王兵', '提交了诉求工单：WO-TEST-021（玄武区+绿化养护），系统自动分派至：玄武市政养护公司', '2026-09-18 10:33:14');
INSERT INTO `sys_log` VALUES (969, '王兵', '提交了诉求工单：WO-TEST-022（玄武区+绿化养护），系统自动分派至：玄武市政养护公司', '2026-09-18 10:33:12');
INSERT INTO `sys_log` VALUES (970, '王兵', '提交了诉求工单：WO-TEST-023（玄武区+绿化养护），系统自动分派至：玄武市政养护公司', '2026-09-18 10:33:53');
INSERT INTO `sys_log` VALUES (971, '王兵', '提交了诉求工单：WO-TEST-024（玄武区+绿化养护），系统自动分派至：玄武市政养护公司', '2026-09-18 10:32:07');
INSERT INTO `sys_log` VALUES (972, '王兵', '提交了诉求工单：WO-TEST-025（玄武区+绿化养护），系统自动分派至：玄武市政养护公司', '2026-09-18 10:32:26');
INSERT INTO `sys_log` VALUES (973, '王兵', '提交了诉求工单：WO-TEST-026（玄武区+绿化养护），系统自动分派至：玄武市政养护公司', '2026-09-18 10:32:27');
INSERT INTO `sys_log` VALUES (974, '王兵', '提交了诉求工单：WO-TEST-027（玄武区+绿化养护），系统自动分派至：玄武市政养护公司', '2026-09-18 10:32:39');
INSERT INTO `sys_log` VALUES (975, '王兵', '提交了诉求工单：WO-TEST-028（玄武区+绿化养护），系统自动分派至：玄武市政养护公司', '2026-09-18 10:32:34');
INSERT INTO `sys_log` VALUES (976, '王兵', '提交了诉求工单：WO-TEST-029（玄武区+绿化养护），系统自动分派至：玄武市政养护公司', '2026-09-18 10:32:08');
INSERT INTO `sys_log` VALUES (977, '王兵', '提交了诉求工单：WO-TEST-030（玄武区+绿化养护），系统自动分派至：玄武市政养护公司', '2026-09-18 10:32:23');
INSERT INTO `sys_log` VALUES (978, '王兵', '提交了诉求工单：WO-TEST-031（秦淮区+设施维修），系统自动分派至：秦淮设施维修公司', '2026-09-18 10:31:15');
INSERT INTO `sys_log` VALUES (979, '王兵', '提交了诉求工单：WO-TEST-032（秦淮区+设施维修），系统自动分派至：秦淮设施维修公司', '2026-09-18 10:32:30');
INSERT INTO `sys_log` VALUES (980, '王兵', '提交了诉求工单：WO-TEST-033（秦淮区+设施维修），系统自动分派至：秦淮设施维修公司', '2026-09-18 10:31:20');
INSERT INTO `sys_log` VALUES (981, '王兵', '提交了诉求工单：WO-TEST-034（秦淮区+设施维修），系统自动分派至：秦淮设施维修公司', '2026-09-18 10:31:50');
INSERT INTO `sys_log` VALUES (982, '王兵', '提交了诉求工单：WO-TEST-035（秦淮区+设施维修），系统自动分派至：秦淮设施维修公司', '2026-09-18 10:33:03');
INSERT INTO `sys_log` VALUES (983, '王兵', '提交了诉求工单：WO-TEST-036（秦淮区+设施维修），系统自动分派至：秦淮设施维修公司', '2026-09-18 10:31:35');
INSERT INTO `sys_log` VALUES (984, '王兵', '提交了诉求工单：WO-TEST-037（秦淮区+设施维修），系统自动分派至：秦淮设施维修公司', '2026-09-18 10:32:49');
INSERT INTO `sys_log` VALUES (985, '王兵', '提交了诉求工单：WO-TEST-038（秦淮区+设施维修），系统自动分派至：秦淮设施维修公司', '2026-09-18 10:32:24');
INSERT INTO `sys_log` VALUES (986, '王兵', '提交了诉求工单：WO-TEST-039（秦淮区+设施维修），系统自动分派至：秦淮设施维修公司', '2026-09-18 10:32:32');
INSERT INTO `sys_log` VALUES (987, '王兵', '提交了诉求工单：WO-TEST-040（秦淮区+设施维修），系统自动分派至：秦淮设施维修公司', '2026-09-18 10:32:35');
INSERT INTO `sys_log` VALUES (988, '王兵', '提交了诉求工单：WO-TEST-041（秦淮区+设施维修），系统自动分派至：秦淮设施维修公司', '2026-09-18 10:31:21');
INSERT INTO `sys_log` VALUES (989, '王兵', '提交了诉求工单：WO-TEST-042（秦淮区+设施维修），系统自动分派至：秦淮设施维修公司', '2026-09-18 10:33:30');
INSERT INTO `sys_log` VALUES (990, '王兵', '提交了诉求工单：WO-TEST-043（秦淮区+设施维修），系统自动分派至：秦淮设施维修公司', '2026-09-18 10:32:27');
INSERT INTO `sys_log` VALUES (991, '王兵', '提交了诉求工单：WO-TEST-044（秦淮区+设施维修），系统自动分派至：秦淮设施维修公司', '2026-09-18 10:31:18');
INSERT INTO `sys_log` VALUES (992, '王兵', '提交了诉求工单：WO-TEST-045（秦淮区+设施维修），系统自动分派至：秦淮设施维修公司', '2026-09-18 10:31:42');
INSERT INTO `sys_log` VALUES (993, '王兵', '提交了诉求工单：WO-TEST-046（建邺区+公共安全），系统自动分派至：建邺公共安全管理公司', '2026-09-18 10:31:55');
INSERT INTO `sys_log` VALUES (994, '王兵', '提交了诉求工单：WO-TEST-047（建邺区+公共安全），系统自动分派至：建邺公共安全管理公司', '2026-09-18 10:31:19');
INSERT INTO `sys_log` VALUES (995, '王兵', '提交了诉求工单：WO-TEST-048（建邺区+公共安全），系统自动分派至：建邺公共安全管理公司', '2026-09-18 10:32:50');
INSERT INTO `sys_log` VALUES (996, '王兵', '提交了诉求工单：WO-TEST-049（建邺区+公共安全），系统自动分派至：建邺公共安全管理公司', '2026-09-18 10:32:25');
INSERT INTO `sys_log` VALUES (997, '王兵', '提交了诉求工单：WO-TEST-050（建邺区+公共安全），系统自动分派至：建邺公共安全管理公司', '2026-09-18 10:31:18');
INSERT INTO `sys_log` VALUES (998, '王兵', '提交了诉求工单：WO-TEST-051（建邺区+公共安全），系统自动分派至：建邺公共安全管理公司', '2026-09-18 10:32:58');
INSERT INTO `sys_log` VALUES (999, '王兵', '提交了诉求工单：WO-TEST-052（建邺区+公共安全），系统自动分派至：建邺公共安全管理公司', '2026-09-18 10:31:02');
INSERT INTO `sys_log` VALUES (1000, '王兵', '提交了诉求工单：WO-TEST-053（建邺区+公共安全），系统自动分派至：建邺公共安全管理公司', '2026-09-18 10:32:52');
INSERT INTO `sys_log` VALUES (1001, '王兵', '提交了诉求工单：WO-TEST-054（建邺区+公共安全），系统自动分派至：建邺公共安全管理公司', '2026-09-18 10:32:24');
INSERT INTO `sys_log` VALUES (1002, '王兵', '提交了诉求工单：WO-TEST-055（建邺区+公共安全），系统自动分派至：建邺公共安全管理公司', '2026-09-18 10:31:56');
INSERT INTO `sys_log` VALUES (1003, '王兵', '提交了诉求工单：WO-TEST-056（建邺区+公共安全），系统自动分派至：建邺公共安全管理公司', '2026-09-18 10:31:32');
INSERT INTO `sys_log` VALUES (1004, '王兵', '提交了诉求工单：WO-TEST-057（建邺区+公共安全），系统自动分派至：建邺公共安全管理公司', '2026-09-18 10:32:50');
INSERT INTO `sys_log` VALUES (1005, '王兵', '提交了诉求工单：WO-TEST-058（建邺区+公共安全），系统自动分派至：建邺公共安全管理公司', '2026-09-18 10:33:07');
INSERT INTO `sys_log` VALUES (1006, '王兵', '提交了诉求工单：WO-TEST-059（建邺区+公共安全），系统自动分派至：建邺公共安全管理公司', '2026-09-18 10:32:52');
INSERT INTO `sys_log` VALUES (1007, '王兵', '提交了诉求工单：WO-TEST-060（建邺区+公共安全），系统自动分派至：建邺公共安全管理公司', '2026-09-18 10:31:43');
INSERT INTO `sys_log` VALUES (1008, '王兵', '提交了诉求工单：WO-TEST-061（栖霞区+供水供电），系统自动分派至：栖霞供水供电维修公司', '2026-09-18 10:32:03');
INSERT INTO `sys_log` VALUES (1009, '王兵', '提交了诉求工单：WO-TEST-062（栖霞区+供水供电），系统自动分派至：栖霞供水供电维修公司', '2026-09-18 10:33:23');
INSERT INTO `sys_log` VALUES (1010, '王兵', '提交了诉求工单：WO-TEST-063（栖霞区+供水供电），系统自动分派至：栖霞供水供电维修公司', '2026-09-18 10:31:02');
INSERT INTO `sys_log` VALUES (1011, '王兵', '提交了诉求工单：WO-TEST-064（栖霞区+供水供电），系统自动分派至：栖霞供水供电维修公司', '2026-09-18 10:32:16');
INSERT INTO `sys_log` VALUES (1012, '王兵', '提交了诉求工单：WO-TEST-065（栖霞区+供水供电），系统自动分派至：栖霞供水供电维修公司', '2026-09-18 10:33:58');
INSERT INTO `sys_log` VALUES (1013, '王兵', '提交了诉求工单：WO-TEST-066（栖霞区+供水供电），系统自动分派至：栖霞供水供电维修公司', '2026-09-18 10:31:25');
INSERT INTO `sys_log` VALUES (1014, '王兵', '提交了诉求工单：WO-TEST-067（栖霞区+供水供电），系统自动分派至：栖霞供水供电维修公司', '2026-09-18 10:33:12');
INSERT INTO `sys_log` VALUES (1015, '王兵', '提交了诉求工单：WO-TEST-068（栖霞区+供水供电），系统自动分派至：栖霞供水供电维修公司', '2026-09-18 10:32:08');
INSERT INTO `sys_log` VALUES (1016, '王兵', '提交了诉求工单：WO-TEST-069（栖霞区+供水供电），系统自动分派至：栖霞供水供电维修公司', '2026-09-18 10:33:57');
INSERT INTO `sys_log` VALUES (1017, '王兵', '提交了诉求工单：WO-TEST-070（栖霞区+供水供电），系统自动分派至：栖霞供水供电维修公司', '2026-09-18 10:33:00');
INSERT INTO `sys_log` VALUES (1018, '王兵', '提交了诉求工单：WO-TEST-071（栖霞区+供水供电），系统自动分派至：栖霞供水供电维修公司', '2026-09-18 10:33:26');
INSERT INTO `sys_log` VALUES (1019, '王兵', '提交了诉求工单：WO-TEST-072（栖霞区+供水供电），系统自动分派至：栖霞供水供电维修公司', '2026-09-18 10:31:29');
INSERT INTO `sys_log` VALUES (1020, '王兵', '提交了诉求工单：WO-TEST-073（栖霞区+供水供电），系统自动分派至：栖霞供水供电维修公司', '2026-09-18 10:33:26');
INSERT INTO `sys_log` VALUES (1021, '王兵', '提交了诉求工单：WO-TEST-074（栖霞区+供水供电），系统自动分派至：栖霞供水供电维修公司', '2026-09-18 10:31:54');
INSERT INTO `sys_log` VALUES (1022, '王兵', '提交了诉求工单：WO-TEST-075（栖霞区+供水供电），系统自动分派至：栖霞供水供电维修公司', '2026-09-18 10:33:26');
INSERT INTO `sys_log` VALUES (1023, '王兵', '提交了诉求工单：WO-TEST-076（雨花台区+噪音扰民），系统自动分派至：雨花噪音治理公司', '2026-09-18 10:33:20');
INSERT INTO `sys_log` VALUES (1024, '王兵', '提交了诉求工单：WO-TEST-077（雨花台区+噪音扰民），系统自动分派至：雨花噪音治理公司', '2026-09-18 10:32:31');
INSERT INTO `sys_log` VALUES (1025, '王兵', '提交了诉求工单：WO-TEST-078（雨花台区+噪音扰民），系统自动分派至：雨花噪音治理公司', '2026-09-18 10:31:56');
INSERT INTO `sys_log` VALUES (1026, '王兵', '提交了诉求工单：WO-TEST-079（雨花台区+噪音扰民），系统自动分派至：雨花噪音治理公司', '2026-09-18 10:32:26');
INSERT INTO `sys_log` VALUES (1027, '王兵', '提交了诉求工单：WO-TEST-080（雨花台区+噪音扰民），系统自动分派至：雨花噪音治理公司', '2026-09-18 10:33:54');
INSERT INTO `sys_log` VALUES (1028, '王兵', '提交了诉求工单：WO-TEST-081（雨花台区+噪音扰民），系统自动分派至：雨花噪音治理公司', '2026-09-18 10:31:38');
INSERT INTO `sys_log` VALUES (1029, '王兵', '提交了诉求工单：WO-TEST-082（雨花台区+噪音扰民），系统自动分派至：雨花噪音治理公司', '2026-09-18 10:33:54');
INSERT INTO `sys_log` VALUES (1030, '王兵', '提交了诉求工单：WO-TEST-083（雨花台区+噪音扰民），系统自动分派至：雨花噪音治理公司', '2026-09-18 10:33:48');
INSERT INTO `sys_log` VALUES (1031, '王兵', '提交了诉求工单：WO-TEST-084（雨花台区+噪音扰民），系统自动分派至：雨花噪音治理公司', '2026-09-18 10:33:13');
INSERT INTO `sys_log` VALUES (1032, '王兵', '提交了诉求工单：WO-TEST-085（雨花台区+噪音扰民），系统自动分派至：雨花噪音治理公司', '2026-09-18 10:31:53');
INSERT INTO `sys_log` VALUES (1033, '王兵', '提交了诉求工单：WO-TEST-086（雨花台区+噪音扰民），系统自动分派至：雨花噪音治理公司', '2026-09-18 10:32:14');
INSERT INTO `sys_log` VALUES (1034, '王兵', '提交了诉求工单：WO-TEST-087（雨花台区+噪音扰民），系统自动分派至：雨花噪音治理公司', '2026-09-18 10:32:33');
INSERT INTO `sys_log` VALUES (1035, '王兵', '提交了诉求工单：WO-TEST-088（雨花台区+噪音扰民），系统自动分派至：雨花噪音治理公司', '2026-09-18 10:32:38');
INSERT INTO `sys_log` VALUES (1036, '王兵', '提交了诉求工单：WO-TEST-089（雨花台区+噪音扰民），系统自动分派至：雨花噪音治理公司', '2026-09-18 10:33:11');
INSERT INTO `sys_log` VALUES (1037, '王兵', '提交了诉求工单：WO-TEST-090（雨花台区+噪音扰民），系统自动分派至：雨花噪音治理公司', '2026-09-18 10:32:51');
INSERT INTO `sys_log` VALUES (1038, '王兵', '提交了诉求工单：WO-TEST-091（六合区+设施维修），系统自动分派至：六合道路设施维修公司', '2026-09-18 10:33:48');
INSERT INTO `sys_log` VALUES (1039, '王兵', '提交了诉求工单：WO-TEST-092（溧水区+公共安全），系统自动分派至：溧水公共安全服务公司', '2026-09-18 10:32:46');
INSERT INTO `sys_log` VALUES (1040, '王兵', '提交了诉求工单：WO-TEST-093（高淳区+供水供电），系统自动分派至：高淳供水服务公司', '2026-09-18 10:32:36');
INSERT INTO `sys_log` VALUES (1041, '王兵', '提交了诉求工单：WO-TEST-094（江宁区+公共安全），系统匹配失败，等待人工分派', '2026-09-18 10:31:37');
INSERT INTO `sys_log` VALUES (1042, '王兵', '提交了诉求工单：WO-TEST-095（栖霞区+噪音扰民），系统匹配失败，等待人工分派', '2026-09-18 10:31:29');
INSERT INTO `sys_log` VALUES (1043, '王兵', '提交了诉求工单：WO-TEST-096（浦口区+环境卫生），系统匹配失败，等待人工分派', '2026-09-18 10:33:48');
INSERT INTO `sys_log` VALUES (1044, '王兵', '提交了诉求工单：WO-TEST-097（雨花台区+设施维修），系统匹配失败，等待人工分派', '2026-09-18 10:31:13');
INSERT INTO `sys_log` VALUES (1045, '王兵', '提交了诉求工单：WO-TEST-098（玄武区+供水供电），系统匹配失败，等待人工分派', '2026-09-18 10:33:54');
INSERT INTO `sys_log` VALUES (1046, '王兵', '提交了诉求工单：WO-TEST-099（江宁区+环境卫生），系统自动分派至：江宁垃圾分类处理公司', '2026-09-18 10:32:31');
INSERT INTO `sys_log` VALUES (1047, '王兵', '提交了诉求工单：WO-TEST-100（浦口区+绿化养护），系统自动分派至：浦口绿化工程公司', '2026-09-18 10:31:39');
INSERT INTO `sys_log` VALUES (1048, '管理员', '添加了用户: wonbin', '2026-10-08 11:34:50');
INSERT INTO `sys_log` VALUES (1049, '管理员', '人工微调考核结果 ID:172，项目ID:1，分数从 25.33 调整为 25.83，备注：人工微调', '2026-10-09 10:13:04');
INSERT INTO `sys_log` VALUES (1050, '小西', '提交了巡检记录：PC-1791619524803，系统自动识别类型为：其他', '2026-10-10 16:05:24');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `role_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色标识',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色描述',
  `status` int(11) NULL DEFAULT 1 COMMENT '状态 0禁用 1正常',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', '拥有全部系统权限', 1, '2026-08-12 09:55:17');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录账号',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录密码',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` int(11) NULL DEFAULT 1 COMMENT '状态 0禁用 1正常',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统用户表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '超级管理员', NULL, NULL, 1, '2026-08-20 14:13:45', NULL, 'admin');
INSERT INTO `sys_user` VALUES (2, '石头', '$2a$10$NKNCyg.RrgKdTmctidmcMeBUBM276WqrVZy6ZPDdgb1GngzAn8xEm', '宋银硕', '', NULL, 1, '2026-08-20 14:14:57', NULL, 'citizen');
INSERT INTO `sys_user` VALUES (3, '王兵', '$2a$10$fu4ANmks2u/KI.sBbs/CYebwMcxdosI7b6yBEeOHhhswupw4NJl5a', '王兵', '18806295578', NULL, 1, '2026-08-20 14:20:34', NULL, 'citizen');
INSERT INTO `sys_user` VALUES (4, '小西', '$2a$10$pKOP9VXiSPQC7rh3SP/bguqqR2QX1dfsAyVoqBIPBNIDuR0kGp.ii', '李西', '', NULL, 1, '2026-08-20 15:39:09', NULL, 'inspector');
INSERT INTO `sys_user` VALUES (5, '小灿', '$2a$10$6kyQjiM2FEOyFwQSGPJ/9um2CTMz2XQHObS1Da1uIzxzgX4doTTUe', '成灿', '', NULL, 1, '2026-08-20 15:52:28', NULL, 'provider');
INSERT INTO `sys_user` VALUES (7, '栖霞供水供电公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '刘洋', NULL, NULL, 1, '2026-08-20 17:34:21', NULL, 'provider');
INSERT INTO `sys_user` VALUES (8, '雨花噪音治理公司', '$2a$10$HQen1HB5OW6XJFNQRYe0J.A.40//CpqyuyHH1immESZCCZ2lbMKhu', '赵静', NULL, NULL, 0, '2026-08-20 17:34:21', NULL, 'provider');
INSERT INTO `sys_user` VALUES (9, '浦口绿化工程公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '郑伟', NULL, NULL, 1, '2026-08-20 17:34:21', NULL, 'provider');
INSERT INTO `sys_user` VALUES (10, '六合设施维修公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '钱程', NULL, NULL, 1, '2026-08-20 17:34:21', NULL, 'provider');
INSERT INTO `sys_user` VALUES (11, '溧水公共安全公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '冯凯', NULL, NULL, 1, '2026-08-20 17:34:21', NULL, 'provider');
INSERT INTO `sys_user` VALUES (12, '高淳供水服务公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '蒋明', NULL, NULL, 1, '2026-08-20 17:34:21', NULL, 'provider');
INSERT INTO `sys_user` VALUES (13, '鼓楼环卫服务公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '张经理', NULL, NULL, 1, '2026-08-20 17:45:12', NULL, 'provider');
INSERT INTO `sys_user` VALUES (14, '玄武市政养护公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '李主管', NULL, NULL, 1, '2026-08-20 17:45:12', NULL, 'provider');
INSERT INTO `sys_user` VALUES (15, '秦淮设施维修公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '王工', NULL, NULL, 1, '2026-08-20 17:45:12', NULL, 'provider');
INSERT INTO `sys_user` VALUES (16, '建邺公共安全管理公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '赵队长', NULL, NULL, 1, '2026-08-20 17:45:12', NULL, 'provider');
INSERT INTO `sys_user` VALUES (17, '栖霞供水供电维修公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '孙工', NULL, NULL, 1, '2026-08-20 17:45:12', NULL, 'provider');
INSERT INTO `sys_user` VALUES (18, '江宁垃圾分类处理公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '吴主管', NULL, NULL, 1, '2026-08-20 17:45:12', NULL, 'provider');
INSERT INTO `sys_user` VALUES (19, '六合道路设施维修公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '钱工', NULL, NULL, 1, '2026-08-20 17:45:12', NULL, 'provider');
INSERT INTO `sys_user` VALUES (20, '溧水公共安全服务公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '冯队长', NULL, NULL, 1, '2026-08-20 17:45:12', NULL, 'provider');
INSERT INTO `sys_user` VALUES (21, '高淳供水服务公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '蒋工', NULL, NULL, 1, '2026-08-20 17:45:12', NULL, 'provider');
INSERT INTO `sys_user` VALUES (22, '鼓楼绿化养护公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '沈主管', NULL, NULL, 1, '2026-08-20 17:45:12', NULL, 'provider');
INSERT INTO `sys_user` VALUES (23, '秦淮环境卫生公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '韩经理', NULL, NULL, 1, '2026-08-20 17:45:12', NULL, 'provider');
INSERT INTO `sys_user` VALUES (24, '建邺设施维修公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '杨工', NULL, NULL, 1, '2026-08-20 17:45:12', NULL, 'provider');
INSERT INTO `sys_user` VALUES (25, '玄武垃圾分类公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '朱主管', NULL, NULL, 1, '2026-08-20 17:45:12', NULL, 'provider');
INSERT INTO `sys_user` VALUES (26, '栖霞公共安全公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '许队长', NULL, NULL, 1, '2026-08-20 17:45:12', NULL, 'provider');
INSERT INTO `sys_user` VALUES (27, '雨花绿化养护公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '何经理', NULL, NULL, 1, '2026-08-20 17:45:12', NULL, 'provider');
INSERT INTO `sys_user` VALUES (28, '江宁供水供电公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '吕工', NULL, NULL, 1, '2026-08-20 17:45:12', NULL, 'provider');
INSERT INTO `sys_user` VALUES (29, '洁城环境科技有限公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '张明', NULL, NULL, 1, '2026-08-20 17:45:12', NULL, 'provider');
INSERT INTO `sys_user` VALUES (30, '恒达设施维修服务公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '王强', NULL, NULL, 1, '2026-08-20 17:45:12', NULL, 'provider');
INSERT INTO `sys_user` VALUES (31, '安达公共安全服务公司', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', '陈刚', NULL, NULL, 1, '2026-08-20 17:45:12', NULL, 'provider');
INSERT INTO `sys_user` VALUES (32, '小沙', '$2a$10$BQBowN/j8YCPGLLH/y92EelPdW5hgQzR6dbllPig4U4D7rBHOaxzu', '沙雨荞', '1888888888', NULL, 1, '2026-08-25 15:58:16', NULL, 'citizen');
INSERT INTO `sys_user` VALUES (33, '江宁宝洁公司', '$2a$10$mje.rmYbqji8rNpdvOnXD.O74kZPCu8PnFlUqeguiH4YqUH80CTNa', '沙雨荞', '18888888888', NULL, 1, '2026-08-25 16:04:27', NULL, 'provider');
INSERT INTO `sys_user` VALUES (34, 'wonbin', '$2a$10$G9fo25y7ItMbBI3IRsnTqeFdL74j3F.wGZUkrAeArXg8vIqtobyD.', '朴元彬', '12647389367', NULL, 1, '2026-10-08 11:34:50', NULL, 'citizen');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_id`(`user_id`) USING BTREE,
  INDEX `fk_role_id`(`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户角色关联表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1, 1, '2026-08-12 09:55:17');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录密码',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of users
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
