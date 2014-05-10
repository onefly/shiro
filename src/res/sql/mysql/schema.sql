/*
Navicat MySQL Data Transfer

Source Server         : local_mysql
Source Server Version : 50515
Source Host           : localhost:3306
Source Database       : security

Target Server Type    : MYSQL
Target Server Version : 50515
File Encoding         : 65001

Date: 2012-11-02 14:40:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `security_module`
-- ----------------------------
DROP TABLE IF EXISTS `security_module`;
CREATE TABLE `security_module` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(32) NOT NULL,
  `priority` int(11) DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `sn` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6510844BF7EFB7EB` (`parent_id`),
  CONSTRAINT `FK6510844BF7EFB7EB` FOREIGN KEY (`parent_id`) REFERENCES `security_module` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of security_module
-- ----------------------------
INSERT INTO `security_module` VALUES ('1', '所有模块的根节点，不能删除', '根模块', '1', '#', null, '');
INSERT INTO `security_module` VALUES ('2', '安全管理:包含权限管理、模块管理', '安全管理', '1', '#', '1', 'Security');
INSERT INTO `security_module` VALUES ('3', null, '用户管理', '1', '/management/security/user/list', '2', 'User');
INSERT INTO `security_module` VALUES ('4', '', '角色管理', '99', '/management/security/role/list', '2', 'Role');
INSERT INTO `security_module` VALUES ('5', '', '模块管理', '99', '/management/security/module/tree', '2', 'Module');
INSERT INTO `security_module` VALUES ('10', '查询平台的一些基本信息配置。', '系统配置', '99', '#', '1', 'Config');
INSERT INTO `security_module` VALUES ('14', '', '收款账户管理', '99', '/management/config/receiveAccount/list', '10', 'ReceiveAccount');
INSERT INTO `security_module` VALUES ('18', '', '组织管理', '99', '/management/security/organization/tree', '2', 'Organization');
INSERT INTO `security_module` VALUES ('24', '', '缓存管理', '99', '/management/security/cacheManage/index', '2', 'CacheManage');
INSERT INTO `security_module` VALUES ('27', '', '收款单位管理', '99', '/management/config/company/list', '10', 'Company');
INSERT INTO `security_module` VALUES ('28', '', '付款人管理', '99', '/management/config/payUser/list', '10', 'PayUser');

-- ----------------------------
-- Table structure for `security_organization`
-- ----------------------------
DROP TABLE IF EXISTS `security_organization`;
CREATE TABLE `security_organization` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1DBDA7D21BC37F72` (`parent_id`),
  CONSTRAINT `FK1DBDA7D21BC37F72` FOREIGN KEY (`parent_id`) REFERENCES `security_organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of security_organization
-- ----------------------------
INSERT INTO `security_organization` VALUES ('1', '不能删除。', '根组织', null);
INSERT INTO `security_organization` VALUES ('2', '', '泸州电业', '1');
INSERT INTO `security_organization` VALUES ('3', '', '龙马潭供电', '2');
INSERT INTO `security_organization` VALUES ('4', '', '江阳供电', '2');
INSERT INTO `security_organization` VALUES ('5', '', '泸县供电', '2');
INSERT INTO `security_organization` VALUES ('6', '', '纳溪供电', '2');
INSERT INTO `security_organization` VALUES ('7', '', '和益电力', '2');
INSERT INTO `security_organization` VALUES ('8', '', '玉宇电力', '2');
INSERT INTO `security_organization` VALUES ('9', '', '叙永供电', '2');
INSERT INTO `security_organization` VALUES ('10', '', '古蔺供电', '2');

-- ----------------------------
-- Table structure for `security_role`
-- ----------------------------
DROP TABLE IF EXISTS `security_role`;
CREATE TABLE `security_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of security_role
-- ----------------------------
INSERT INTO `security_role` VALUES ('3', '管理员');
INSERT INTO `security_role` VALUES ('5', '营销人员');
INSERT INTO `security_role` VALUES ('4', '财务人员');
INSERT INTO `security_role` VALUES ('1', '超级管理员');

-- ----------------------------
-- Table structure for `security_role_permission`
-- ----------------------------
DROP TABLE IF EXISTS `security_role_permission`;
CREATE TABLE `security_role_permission` (
  `role_id` bigint(20) NOT NULL,
  `permission` varchar(255) DEFAULT NULL,
  KEY `FK679E22396A72D669` (`role_id`),
  CONSTRAINT `FK679E22396A72D669` FOREIGN KEY (`role_id`) REFERENCES `security_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of security_role_permission
-- ----------------------------
INSERT INTO `security_role_permission` VALUES ('1', 'Security:view');
INSERT INTO `security_role_permission` VALUES ('1', 'User:view');
INSERT INTO `security_role_permission` VALUES ('1', 'User:save');
INSERT INTO `security_role_permission` VALUES ('1', 'User:edit');
INSERT INTO `security_role_permission` VALUES ('1', 'User:delete');
INSERT INTO `security_role_permission` VALUES ('1', 'Role:view');
INSERT INTO `security_role_permission` VALUES ('1', 'Role:save');
INSERT INTO `security_role_permission` VALUES ('1', 'Role:edit');
INSERT INTO `security_role_permission` VALUES ('1', 'Role:delete');
INSERT INTO `security_role_permission` VALUES ('1', 'Module:view');
INSERT INTO `security_role_permission` VALUES ('1', 'Module:save');
INSERT INTO `security_role_permission` VALUES ('1', 'Module:edit');
INSERT INTO `security_role_permission` VALUES ('1', 'Module:delete');
INSERT INTO `security_role_permission` VALUES ('1', 'Organization:view');
INSERT INTO `security_role_permission` VALUES ('1', 'Organization:save');
INSERT INTO `security_role_permission` VALUES ('1', 'Organization:edit');
INSERT INTO `security_role_permission` VALUES ('1', 'Organization:delete');
INSERT INTO `security_role_permission` VALUES ('1', 'CacheManage:view');
INSERT INTO `security_role_permission` VALUES ('1', 'CacheManage:edit');
INSERT INTO `security_role_permission` VALUES ('1', 'Config:view');
INSERT INTO `security_role_permission` VALUES ('1', 'ReceiveAccount:view');
INSERT INTO `security_role_permission` VALUES ('1', 'ReceiveAccount:save');
INSERT INTO `security_role_permission` VALUES ('1', 'ReceiveAccount:edit');
INSERT INTO `security_role_permission` VALUES ('1', 'ReceiveAccount:delete');
INSERT INTO `security_role_permission` VALUES ('1', 'Company:view');
INSERT INTO `security_role_permission` VALUES ('1', 'Company:save');
INSERT INTO `security_role_permission` VALUES ('1', 'Company:edit');
INSERT INTO `security_role_permission` VALUES ('1', 'Company:delete');
INSERT INTO `security_role_permission` VALUES ('1', 'PayUser:view');
INSERT INTO `security_role_permission` VALUES ('1', 'PayUser:save');
INSERT INTO `security_role_permission` VALUES ('1', 'PayUser:edit');
INSERT INTO `security_role_permission` VALUES ('1', 'PayUser:delete');
INSERT INTO `security_role_permission` VALUES ('4', 'Config:view');
INSERT INTO `security_role_permission` VALUES ('4', 'ReceiveAccount:view');
INSERT INTO `security_role_permission` VALUES ('4', 'ReceiveAccount:save');
INSERT INTO `security_role_permission` VALUES ('4', 'ReceiveAccount:edit');
INSERT INTO `security_role_permission` VALUES ('4', 'ReceiveAccount:delete');
INSERT INTO `security_role_permission` VALUES ('4', 'Company:view');
INSERT INTO `security_role_permission` VALUES ('4', 'Company:save');
INSERT INTO `security_role_permission` VALUES ('4', 'Company:edit');
INSERT INTO `security_role_permission` VALUES ('4', 'Company:delete');
INSERT INTO `security_role_permission` VALUES ('4', 'PayUser:view');
INSERT INTO `security_role_permission` VALUES ('4', 'PayUser:save');
INSERT INTO `security_role_permission` VALUES ('4', 'PayUser:edit');
INSERT INTO `security_role_permission` VALUES ('4', 'PayUser:delete');
INSERT INTO `security_role_permission` VALUES ('5', 'Config:view');
INSERT INTO `security_role_permission` VALUES ('5', 'PayUser:view');
INSERT INTO `security_role_permission` VALUES ('5', 'PayUser:save');
INSERT INTO `security_role_permission` VALUES ('5', 'PayUser:edit');
INSERT INTO `security_role_permission` VALUES ('3', 'Security:view');
INSERT INTO `security_role_permission` VALUES ('3', 'User:view');
INSERT INTO `security_role_permission` VALUES ('3', 'User:save');
INSERT INTO `security_role_permission` VALUES ('3', 'User:edit');
INSERT INTO `security_role_permission` VALUES ('3', 'User:delete');
INSERT INTO `security_role_permission` VALUES ('3', 'Config:view');
INSERT INTO `security_role_permission` VALUES ('3', 'ReceiveAccount:view');
INSERT INTO `security_role_permission` VALUES ('3', 'ReceiveAccount:save');
INSERT INTO `security_role_permission` VALUES ('3', 'ReceiveAccount:edit');
INSERT INTO `security_role_permission` VALUES ('3', 'ReceiveAccount:delete');

-- ----------------------------
-- Table structure for `security_user`
-- ----------------------------
DROP TABLE IF EXISTS `security_user`;
CREATE TABLE `security_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime DEFAULT NULL,
  `password` varchar(64) NOT NULL,
  `salt` varchar(32) NOT NULL,
  `status` varchar(20) NOT NULL,
  `username` varchar(32) NOT NULL,
  `email` varchar(128) NOT NULL,
  `realname` varchar(32) NOT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `FKD607B56A643D76F8` (`org_id`),
  CONSTRAINT `FKD607B56A643D76F8` FOREIGN KEY (`org_id`) REFERENCES `security_organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of security_user
-- ----------------------------
INSERT INTO `security_user` VALUES ('1', '2012-08-03 14:58:38', 'cbe5c339a2beb940bddd43f30486473fac2e0658', '9bdab4aa2895266b', 'enabled', 'admin', 'yaoqiang@yahoo.cn', '姚强', '13518109999', '2');
INSERT INTO `security_user` VALUES ('3', '2012-08-07 00:00:00', '802874fa2303c5ef3d5ce56fbeba6a16f2ff7aef', 'acda641cfd0f313d', 'enabled', 'zs', '21vv12@sas.com', '张三', '', '3');
INSERT INTO `security_user` VALUES ('4', '2012-08-07 16:12:17', '0448b9fa8b0b4ad255e71ad3305e1677114ccf08', '6c3eb539e4f04701', 'enabled', 'ls', 'sdf@ss.com', '李四', '', '9');
INSERT INTO `security_user` VALUES ('5', '2012-08-13 11:17:31', '638c3e2f7984d9bc6f539df5dfc6a1e7b5088743', 'fabffbdfe3f64c0b', 'enabled', 'ww', 'jjyy@sina.com', '王五', '13658025333', '4');
INSERT INTO `security_user` VALUES ('6', '2012-08-28 10:14:20', 'c2d8884974f8e4d586815c8d05b3e94bdcd40eee', '683552b3232cadaa', 'enabled', 'gl', '', '龟六', '646456565', '4');
INSERT INTO `security_user` VALUES ('7', '2012-09-04 09:55:08', 'a264e5e9245fcd7f4fe05229f3dbafdd94ebbd01', 'dbbde9f65f569a63', 'enabled', 'yangjie', '', '杨杰', '', '4');
INSERT INTO `security_user` VALUES ('8', '2012-09-11 17:07:46', '0d44d808a023549ff328a358c2ff4e11b82a38c9', 'e094b48ae2aec9ed', 'enabled', 'gly', '', '管理员', '', '2');
INSERT INTO `security_user` VALUES ('9', '2012-09-11 17:08:37', '3caa91db8be780ff39f9878f6ddef05e765b6ff0', '141f8ee62d55a0a3', 'disabled', 'cw', '', '财务', '', '2');
INSERT INTO `security_user` VALUES ('10', '2012-09-11 17:08:47', 'a8de31d4ebdb8343ee3b2cfbbc961dd5ccd0683b', 'b573ee6422fd07ee', 'enabled', 'yx', '', '营销', '', '10');
INSERT INTO `security_user` VALUES ('11', '2012-10-31 17:26:19', '73a4c68452959eac0247fb3782e16c7e56506a9e', '37e6843c7510d339', 'enabled', 'ggfc', '', 'test', '13518109978', '10');

-- ----------------------------
-- Table structure for `security_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `security_user_role`;
CREATE TABLE `security_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `priority` int(11) NOT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6DD3562B6A72D669` (`role_id`),
  KEY `FK6DD3562BF9D9A49` (`user_id`),
  CONSTRAINT `FK6DD3562B6A72D669` FOREIGN KEY (`role_id`) REFERENCES `security_role` (`id`),
  CONSTRAINT `FK6DD3562BF9D9A49` FOREIGN KEY (`user_id`) REFERENCES `security_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of security_user_role
-- ----------------------------
INSERT INTO `security_user_role` VALUES ('1', '1', '1', '1');
INSERT INTO `security_user_role` VALUES ('3', '99', '3', '3');
INSERT INTO `security_user_role` VALUES ('4', '99', '4', '4');
INSERT INTO `security_user_role` VALUES ('6', '99', '5', '5');
INSERT INTO `security_user_role` VALUES ('7', '99', '5', '7');
INSERT INTO `security_user_role` VALUES ('8', '99', '3', '8');
INSERT INTO `security_user_role` VALUES ('9', '99', '4', '9');
INSERT INTO `security_user_role` VALUES ('10', '99', '5', '10');
