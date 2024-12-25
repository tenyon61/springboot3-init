/*
 Navicat Premium Dump SQL

 Source Server         : 27.25.138.16
 Source Server Type    : MySQL
 Source Server Version : 80039 (8.0.39)
 Source Host           : 27.25.138.16:3306
 Source Schema         : demo

 Target Server Type    : MySQL
 Target Server Version : 80039 (8.0.39)
 File Encoding         : 65001

 Date: 25/12/2024 12:32:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for f_post
-- ----------------------------
DROP TABLE IF EXISTS `f_post`;
CREATE TABLE `f_post`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '内容',
  `tags` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标签列表（json 数组）',
  `thumbNum` int NOT NULL DEFAULT 0 COMMENT '点赞数',
  `favourNum` int NOT NULL DEFAULT 0 COMMENT '收藏数',
  `userId` bigint NOT NULL COMMENT '创建用户 id',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `isDelete` tinyint NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_userId`(`userId` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '帖子' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of f_post
-- ----------------------------

-- ----------------------------
-- Table structure for f_post_favour
-- ----------------------------
DROP TABLE IF EXISTS `f_post_favour`;
CREATE TABLE `f_post_favour`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `postId` bigint NOT NULL COMMENT '帖子 id',
  `userId` bigint NOT NULL COMMENT '创建用户 id',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_postId`(`postId` ASC) USING BTREE,
  INDEX `idx_userId`(`userId` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '帖子收藏' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of f_post_favour
-- ----------------------------

-- ----------------------------
-- Table structure for f_post_thumb
-- ----------------------------
DROP TABLE IF EXISTS `f_post_thumb`;
CREATE TABLE `f_post_thumb`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `postId` bigint NOT NULL COMMENT '帖子 id',
  `userId` bigint NOT NULL COMMENT '创建用户 id',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_postId`(`postId` ASC) USING BTREE,
  INDEX `idx_userId`(`userId` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '帖子点赞' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of f_post_thumb
-- ----------------------------

-- ----------------------------
-- Table structure for f_user
-- ----------------------------
DROP TABLE IF EXISTS `f_user`;
CREATE TABLE `f_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `userAccount` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '账号',
  `userPassword` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `unionId` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '微信开放平台id',
  `mpOpenId` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '公众号openId',
  `userName` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `userAvatar` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户头像',
  `userProfile` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户简介',
  `userRole` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user' COMMENT '用户角色：user/admin/ban',
  `vipNumber` bigint NULL DEFAULT NULL COMMENT '会员编号',
  `vipCode` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '会员兑换码',
  `vipExpireTime` datetime NULL DEFAULT NULL COMMENT '会员过期时间',
  `shareCode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分享码',
  `inviteUser` bigint NULL DEFAULT NULL COMMENT '邀请用户id',
  `editTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '编辑时间',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `isDelete` tinyint NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_unionId`(`unionId` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of f_user
-- ----------------------------
INSERT INTO `f_user` VALUES (1, 'user1', '492a65bef0ab2fac75758f004f3eaf35', 'unionId1', 'mpOpenId1', 'user1', 'https://api.oss.tenyon.cn/tenyon/assets/default.png', '喜欢编程的小白', 'user', NULL, NULL, NULL, NULL, NULL, '2024-11-28 14:50:35', '2024-11-28 14:50:35', '2024-11-28 14:50:35', 0);
INSERT INTO `f_user` VALUES (2, 'user2', '492a65bef0ab2fac75758f004f3eaf35', 'unionId2', 'mpOpenId2', 'user2', 'https://api.oss.tenyon.cn/tenyon/assets/default.png', '全栈开发工程师', 'user', NULL, NULL, NULL, NULL, NULL, '2024-11-28 14:50:35', '2024-11-28 14:50:35', '2024-11-28 14:50:35', 0);
INSERT INTO `f_user` VALUES (3, 'user3', '492a65bef0ab2fac75758f004f3eaf35', 'unionId3', 'mpOpenId3', 'user3', 'https://api.oss.tenyon.cn/tenyon/assets/default.png', '前端爱好者', 'user', NULL, NULL, NULL, NULL, NULL, '2024-11-28 14:50:35', '2024-11-28 14:50:35', '2024-11-28 14:50:35', 0);
INSERT INTO `f_user` VALUES (4, 'user4', '492a65bef0ab2fac75758f004f3eaf35', 'unionId4', 'mpOpenId4', 'user4', 'https://api.oss.tenyon.cn/tenyon/assets/default.png', '后端开发工程师', 'user', NULL, NULL, NULL, NULL, NULL, '2024-11-28 14:50:35', '2024-11-28 14:50:35', '2024-11-28 14:50:35', 0);
INSERT INTO `f_user` VALUES (5, 'admin', '492a65bef0ab2fac75758f004f3eaf35', NULL, NULL, 'admin123', 'https://api.oss.tenyon.cn/tenyon/assets/default.png', '系统管理员', 'admin', NULL, NULL, NULL, NULL, NULL, '2024-11-28 14:50:35', '2024-11-28 14:50:35', '2024-11-28 14:50:35', 0);

SET FOREIGN_KEY_CHECKS = 1;
