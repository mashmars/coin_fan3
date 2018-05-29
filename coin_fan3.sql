/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : coin_fan3

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-05-29 17:51:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `pwd` char(32) DEFAULT NULL,
  `last_log_ip` varchar(15) DEFAULT NULL,
  `last_log_time` char(10) DEFAULT NULL,
  `descript` varchar(50) DEFAULT NULL COMMENT '管理员描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '127.0.0.1', '1527576131', '超级管理员');

-- ----------------------------
-- Table structure for admin_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `admin_auth_group`;
CREATE TABLE `admin_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of admin_auth_group
-- ----------------------------
INSERT INTO `admin_auth_group` VALUES ('1', '超级管理员', '1', '1,2,3,4,5,6,7,8,9,10,11,56,57,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,58,68,69,70,71,72,73,53,54,55,59,60,61,62,63,64,65,66,67');
INSERT INTO `admin_auth_group` VALUES ('2', '普通管理员', '1', '53,54,55');
INSERT INTO `admin_auth_group` VALUES ('3', '财务', '1', '1,2,3,4,5,6,7,8,9,10,11,56,12,13,14,15,16');

-- ----------------------------
-- Table structure for admin_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `admin_auth_group_access`;
CREATE TABLE `admin_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of admin_auth_group_access
-- ----------------------------
INSERT INTO `admin_auth_group_access` VALUES ('1', '1');
INSERT INTO `admin_auth_group_access` VALUES ('3', '2');
INSERT INTO `admin_auth_group_access` VALUES ('4', '2');
INSERT INTO `admin_auth_group_access` VALUES ('5', '3');
INSERT INTO `admin_auth_group_access` VALUES ('6', '3');

-- ----------------------------
-- Table structure for admin_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `admin_auth_rule`;
CREATE TABLE `admin_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(6) DEFAULT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `title` varchar(50) NOT NULL DEFAULT '',
  `controller` varchar(100) DEFAULT NULL COMMENT '控制器',
  `action` varchar(100) DEFAULT NULL COMMENT '方法',
  `cengji` char(1) DEFAULT '1' COMMENT '菜单层级',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `condition` char(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin_auth_rule
-- ----------------------------
INSERT INTO `admin_auth_rule` VALUES ('1', '0', 'Finance/', '财务管理', 'Finance', '', '1', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('2', '1', 'Finance/Myzr', '转入', 'Finance', 'Myzr', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('3', '1', 'Finance/Myzc', '转出', 'Finance', 'Myzc', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('4', '3', 'Finance/Ajax_myzc_shenhe', '审核通过', 'Finance', 'Ajax_myzc_shenhe', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('5', '3', 'Finance/Ajax_myzc_refuse', '拒绝通过', 'Finance', 'Ajax_myzc_refuse', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('6', '0', 'User/', '会员管理', 'User', '', '1', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('7', '6', 'User/Member_list', '会员列表', 'User', 'Member_list', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('8', '7', 'User/Member_add', '会员添加页面', 'User', 'Member_add', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('9', '7', 'User/Ajax_member_add', '添加提交', 'User', 'Ajax_member_add', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('10', '7', 'User/Member_edit', '会员编辑页面', 'User', 'Member_edit', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('11', '7', 'User/Ajax_member_edit', '编辑提交', 'User', 'Ajax_member_edit', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('12', '6', 'User/Member_chongzhi', '充值管理', 'User', 'Member_chongzhi', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('13', '12', 'User/Member_chongzhi_add', '增加充值页面', 'User', 'Member_chongzhi_add', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('14', '12', 'User/Ajax_member_chongzhi', '充值提交', 'User', 'Ajax_member_chongzhi', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('15', '6', 'User/Team', '组织架构', 'User', 'Team', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('16', '6', 'User/Member_coin', '资产管理', 'User', 'Member_coin', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('17', '0', 'Auth/', '管理员管理', 'Auth', '', '1', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('18', '17', 'Auth/Admin_list', '管理员管理', 'Auth', 'Admin_list', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('19', '18', 'Auth/Admin_add', '添加管理员页面', 'Auth', 'Admin_add', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('20', '18', 'Auth/Ajax_admin_add', '添加提交', 'Auth', 'Ajax_admin_add', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('21', '18', 'Auth/Admin_edit', '编辑页面', 'Auth', 'Admin_edit', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('22', '18', 'Auth/Ajax_admin_edit', '编辑提交', 'Auth', 'Ajax_admin_edit', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('23', '18', 'Auth/Admin_del', '删除', 'Auth', 'Admin_del', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('24', '17', 'Auth/Admin_role', '角色管理', 'Auth', 'Admin_role', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('25', '24', 'Auth/Admin_role_view', '查看权限', 'Auth', 'Admin_role_view', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('26', '24', 'Auth/Admin_role_add', '添加页面', 'Auth', 'Admin_role_add', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('27', '24', 'Auth/Ajax_role_add', '添加提交', 'Auth', 'Ajax_role_add', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('28', '24', 'Auth/Admin_role_edit', '编辑页面', 'Auth', 'Admin_role_edit', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('29', '24', 'Auth/Ajax_role_edit', '编辑提交', 'Auth', 'Ajax_role_edit', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('30', '24', 'Auth/Admin_role_grant', '授权页面', 'Auth', 'Admin_role_grant', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('31', '24', 'Auth/Ajax_role_grant', '授权提交', 'Auth', 'Ajax_role_grant', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('32', '24', 'Auth/Ajax_role_del', '删除', 'Auth', 'Ajax_role_del', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('33', '17', 'Auth/Admin_menu', '菜单管理', 'Auth', 'Admin_menu', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('34', '33', 'Auth/Admin_menu_add', '添加 页面', 'Auth', 'Admin_menu_add', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('35', '33', 'Auth/Ajax_menu_add', '添加提交', 'Auth', 'Ajax_menu_add', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('36', '33', 'Auth/Admin_menu_edit', '编辑页面', 'Auth', 'Admin_menu_edit', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('37', '33', 'Auth/Ajax_menu_edit', '编辑提交', 'Auth', 'Ajax_menu_edit', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('38', '33', 'Auth/Ajax_menu_del', '删除', 'Auth', 'Ajax_menu_del', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('39', '0', 'System/', '系统管理', 'System', '', '1', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('40', '39', 'System/System_base', '系统设置', 'System', 'System_base', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('41', '39', 'System/Sys_jtfh', '静态分红', 'System', 'Sys_jtfh', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('42', '41', 'System/Sys_jtfh_add', '添加页面', 'System', 'Sys_jtfh_add', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('43', '41', 'System/Ajax_sys_jtfh_add', '添加提交', 'System', 'Ajax_sys_jtfh_add', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('44', '41', 'System/Sys_jtfh_edit', '编辑页面', 'System', 'Sys_jtfh_edit', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('45', '41', 'System/Ajax_sys_jtfh_edit', '编辑提交', 'System', 'Ajax_sys_jtfh_edit', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('46', '41', 'System/Ajax_sys_jtfh_del', '删除', 'System', 'Ajax_sys_jtfh_del', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('47', '39', 'System/Sys_dtfh', '小区动态分红', 'System', 'Sys_dtfh', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('48', '47', 'System/Sys_dtfh_add', '添加页面', 'System', 'Sys_dtfh_add', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('49', '47', 'System/Ajax_sys_dtfh_add', '添加提交', 'System', 'Ajax_sys_dtfh_add', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('50', '47', 'System/Sys_dtfh_edit', '编辑页面', 'System', 'Sys_dtfh_edit', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('51', '47', 'System/Ajax_sys_dtfh_edit', '编辑提交', 'System', 'Ajax_sys_dtfh_edit', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('52', '47', 'System/Ajax_sys_dtfh_del', '删除', 'System', 'Ajax_sys_dtfh_del', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('53', '0', 'Login/Change_password', '修改密码', 'Login', 'Change_password', '1', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('54', '53', 'Login/Ajax_change_pwd', '提交', 'Login', 'Ajax_change_pwd', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('55', '0', 'Login/Logout', '退出', 'Login', 'Logout', '1', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('56', '7', 'User/Tree', '会员一览', 'User', 'Tree', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('57', '7', 'User/Ajax_yidi_login', '异地登录', 'User', 'Ajax_yidi_login', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('58', '39', 'System/Gonggao', '公告管理', 'System', 'Gonggao', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('59', '0', 'Charge/', '扣费管理', 'Charge', '', '1', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('60', '59', 'Charge/Charge_list', '扣费管理', 'Charge', 'Charge_list', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('61', '59', 'Charge/Charge_add', '增加页面', 'Charge', 'Charge_add', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('62', '59', 'Charge/Ajax_charge_add', '增加提交', 'Charge', 'Ajax_charge_add', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('63', '59', 'Charge/Charge_edit', '编辑页面', 'Charge', 'Charge_edit', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('64', '59', 'Charge/Ajax_charge_edit', '编辑提交', 'Charge', 'Ajax_charge_edit', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('65', '59', 'Charge/Ajax_charge_del', '删除', 'Charge', 'Ajax_charge_del', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('66', '59', 'Charge/Ajax_charge_zhixing', '执行扣费', 'Charge', 'Ajax_charge_zhixing', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('67', '59', 'Charge/Charge_log', '扣费日志', 'Charge', 'Charge_log', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('68', '39', 'System/Sys_dtfh_middle', '中区动态分红', 'System', 'Sys_dtfh_middle', '2', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('69', '68', 'System/Sys_dtfh_middle_add', '添加页面', 'System', 'Sys_dtfh_middle_add', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('70', '68', 'System/Ajax_sys_dtfh_middle_add', '添加提交', 'System', 'Ajax_sys_dtfh_middle_add', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('71', '68', 'System/Sys_dtfh_middle_edit', '编辑页面', 'System', 'Sys_dtfh_middle_edit', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('72', '68', 'System/Ajax_sys_dtfh_middle_edit', '编辑提交', 'System', 'Ajax_sys_dtfh_middle_edit', '3', '1', '1', '');
INSERT INTO `admin_auth_rule` VALUES ('73', '68', 'System/Ajax_sys_dtfh_middle_del', '删除', 'System', 'Ajax_sys_dtfh_del', '3', '1', '1', '');

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `image` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of banner
-- ----------------------------

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `descript` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `copyright` varchar(100) DEFAULT NULL,
  `tel` varchar(18) DEFAULT NULL,
  `fax` varchar(18) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `logo` varchar(30) DEFAULT NULL,
  `banner` varchar(30) DEFAULT NULL,
  `price` decimal(16,4) NOT NULL DEFAULT '1.0000',
  `zc_fee` varchar(5) NOT NULL DEFAULT '0' COMMENT '转出手续费',
  `zz_fee` varchar(5) NOT NULL DEFAULT '0' COMMENT '转账手续费',
  `tb_bl` decimal(6,5) NOT NULL DEFAULT '1.00000' COMMENT '提币全局控制 优先个人设置的提币比例',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES ('1', '', '', '', '', '', '', '', '', '', '3.6600', '0.05', '0.00', '1.00000');

-- ----------------------------
-- Table structure for gonggao
-- ----------------------------
DROP TABLE IF EXISTS `gonggao`;
CREATE TABLE `gonggao` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `createdate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of gonggao
-- ----------------------------
INSERT INTO `gonggao` VALUES ('1', null, null, null);

-- ----------------------------
-- Table structure for mycz
-- ----------------------------
DROP TABLE IF EXISTS `mycz`;
CREATE TABLE `mycz` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `num` decimal(16,4) DEFAULT NULL,
  `createdate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mycz
-- ----------------------------

-- ----------------------------
-- Table structure for mytransfer
-- ----------------------------
DROP TABLE IF EXISTS `mytransfer`;
CREATE TABLE `mytransfer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `peerid` int(11) DEFAULT NULL COMMENT '对方userid',
  `mum` decimal(16,4) NOT NULL,
  `fee` decimal(10,4) NOT NULL,
  `num` decimal(16,4) DEFAULT NULL,
  `createdate` int(11) DEFAULT NULL,
  `realname` varchar(30) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mytransfer
-- ----------------------------

-- ----------------------------
-- Table structure for myzc
-- ----------------------------
DROP TABLE IF EXISTS `myzc`;
CREATE TABLE `myzc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(6) NOT NULL,
  `address` varchar(100) DEFAULT NULL COMMENT '转出地址',
  `txid` varchar(200) DEFAULT NULL,
  `mum` decimal(16,4) DEFAULT NULL,
  `fee` decimal(10,4) NOT NULL COMMENT '手续费',
  `num` decimal(16,4) NOT NULL COMMENT '真实数量',
  `createdate` int(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '0' COMMENT '0未到账 1到账 2是拒绝',
  `remark` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `address` (`address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myzc
-- ----------------------------

-- ----------------------------
-- Table structure for myzr
-- ----------------------------
DROP TABLE IF EXISTS `myzr`;
CREATE TABLE `myzr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(6) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `txid` varchar(200) DEFAULT NULL,
  `num` decimal(16,4) DEFAULT NULL,
  `createdate` int(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `zuhe1` (`txid`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myzr
-- ----------------------------

-- ----------------------------
-- Table structure for sys_charge
-- ----------------------------
DROP TABLE IF EXISTS `sys_charge`;
CREATE TABLE `sys_charge` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `bl` decimal(5,5) DEFAULT NULL,
  `status` tinyint(2) DEFAULT '1' COMMENT '1是未执行 0是已执行',
  `createdate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_charge
-- ----------------------------

-- ----------------------------
-- Table structure for sys_charge_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_charge_log`;
CREATE TABLE `sys_charge_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `charge_id` int(5) DEFAULT NULL,
  `bl` decimal(5,5) DEFAULT NULL,
  `num` decimal(12,5) DEFAULT NULL,
  `createdate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `num` (`num`),
  KEY `hx` (`userid`,`num`,`createdate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_charge_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dtfh
-- ----------------------------
DROP TABLE IF EXISTS `sys_dtfh`;
CREATE TABLE `sys_dtfh` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `minnum` int(8) DEFAULT NULL,
  `maxnum` int(8) DEFAULT NULL,
  `bl` decimal(6,4) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='动态分红设置';

-- ----------------------------
-- Records of sys_dtfh
-- ----------------------------
INSERT INTO `sys_dtfh` VALUES ('1', '100', '500', '0.0012', '1');
INSERT INTO `sys_dtfh` VALUES ('2', '501', '1000', '0.0017', '1');
INSERT INTO `sys_dtfh` VALUES ('3', '1001', '3000', '0.0022', '1');
INSERT INTO `sys_dtfh` VALUES ('4', '3001', '5000', '0.0027', '1');
INSERT INTO `sys_dtfh` VALUES ('5', '5001', '10000000', '0.0031', '1');

-- ----------------------------
-- Table structure for sys_dtfh_middle
-- ----------------------------
DROP TABLE IF EXISTS `sys_dtfh_middle`;
CREATE TABLE `sys_dtfh_middle` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `minnum` int(8) DEFAULT NULL,
  `maxnum` int(8) DEFAULT NULL,
  `bl` decimal(6,4) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='中区动态分红设置';

-- ----------------------------
-- Records of sys_dtfh_middle
-- ----------------------------
INSERT INTO `sys_dtfh_middle` VALUES ('1', '100', '500', '0.0010', '1');
INSERT INTO `sys_dtfh_middle` VALUES ('2', '501', '1000', '0.0012', '1');
INSERT INTO `sys_dtfh_middle` VALUES ('3', '1001', '3000', '0.0015', '1');
INSERT INTO `sys_dtfh_middle` VALUES ('4', '3001', '5000', '0.0018', '1');
INSERT INTO `sys_dtfh_middle` VALUES ('5', '5001', '10000000', '0.0021', '1');

-- ----------------------------
-- Table structure for sys_fh_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_fh_log`;
CREATE TABLE `sys_fh_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(6) NOT NULL,
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1是静态 2是小区动态 3是中区动态',
  `current` decimal(16,4) DEFAULT NULL COMMENT '当前币',
  `fh_id` tinyint(2) DEFAULT NULL COMMENT '当前满足的分红id',
  `bl` varchar(7) DEFAULT NULL,
  `num` decimal(12,4) unsigned DEFAULT NULL COMMENT '本次分红的币数',
  `createdate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `uc` (`userid`,`createdate`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_fh_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_fh_verify
-- ----------------------------
DROP TABLE IF EXISTS `sys_fh_verify`;
CREATE TABLE `sys_fh_verify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `count` int(11) DEFAULT NULL COMMENT '当天该分红的总人数',
  `deal_jt` int(11) DEFAULT '0' COMMENT '已生成的静态分红数',
  `deal_dt` int(11) DEFAULT '0' COMMENT '已生成的动态分红数',
  `createdate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='每天分红核对';

-- ----------------------------
-- Records of sys_fh_verify
-- ----------------------------

-- ----------------------------
-- Table structure for sys_jtfh
-- ----------------------------
DROP TABLE IF EXISTS `sys_jtfh`;
CREATE TABLE `sys_jtfh` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `minnum` int(8) DEFAULT NULL,
  `maxnum` int(8) DEFAULT NULL,
  `bl` decimal(6,4) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='静态分红设置';

-- ----------------------------
-- Records of sys_jtfh
-- ----------------------------
INSERT INTO `sys_jtfh` VALUES ('1', '100', '500', '0.0010', '1');
INSERT INTO `sys_jtfh` VALUES ('2', '501', '1000', '0.0012', '1');
INSERT INTO `sys_jtfh` VALUES ('3', '1001', '3000', '0.0015', '1');
INSERT INTO `sys_jtfh` VALUES ('4', '3001', '5000', '0.0018', '1');
INSERT INTO `sys_jtfh` VALUES ('5', '5001', '10000000', '0.0021', '1');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `pid` int(6) DEFAULT '0',
  `username` varchar(30) NOT NULL,
  `phone` varchar(15) NOT NULL COMMENT '电话',
  `password` char(32) DEFAULT NULL,
  `paypassword` char(32) DEFAULT NULL,
  `realname` varchar(30) DEFAULT NULL COMMENT '姓名',
  `idcard` varchar(18) DEFAULT NULL COMMENT '身份证号',
  `createdate` int(11) DEFAULT NULL,
  `status` tinyint(2) DEFAULT '1',
  `country` varchar(50) DEFAULT NULL,
  `province` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `finance_status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '提币and转账状态 1 可 0不可 ',
  `tb_bl` decimal(6,5) NOT NULL DEFAULT '0.00000' COMMENT '0是不限制，走全局控制 tb_bl 大于0优先走个人设置',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE,
  UNIQUE KEY `phone` (`phone`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '0', 'yolostar', '123', 'e10adc3949ba59abbe56e057f20f883e', 'e10adc3949ba59abbe56e057f20f883e', '系统账户', null, null, '1', null, null, null, '1', '0.00000');
INSERT INTO `user` VALUES ('2', '1', '15890143123', '15890143123', 'e10adc3949ba59abbe56e057f20f883e', '96e79218965eb72c92a549dd5a330112', '123', null, '1527587367', '1', null, null, null, '1', '0.00000');

-- ----------------------------
-- Table structure for user_coin
-- ----------------------------
DROP TABLE IF EXISTS `user_coin`;
CREATE TABLE `user_coin` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `userid` int(6) DEFAULT NULL,
  `lth` decimal(15,4) unsigned DEFAULT '0.0000',
  `lthd` decimal(15,4) unsigned DEFAULT '0.0000',
  `lthb` varchar(100) DEFAULT '',
  `lthz` decimal(15,4) unsigned DEFAULT '0.0000',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userid` (`userid`) USING BTREE,
  KEY `lthb` (`lthb`),
  KEY `lth` (`lth`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_coin
-- ----------------------------
INSERT INTO `user_coin` VALUES ('1', '1', '0.0000', '0.0000', '', '0.0000');
INSERT INTO `user_coin` VALUES ('2', '2', '0.0000', '0.0000', 'XSrczjDcfT74OS2EGKHQpWGUZBWve5IM', '0.0000');

-- ----------------------------
-- Table structure for user_qianbao
-- ----------------------------
DROP TABLE IF EXISTS `user_qianbao`;
CREATE TABLE `user_qianbao` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `userid` int(6) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `createdate` int(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_qianbao
-- ----------------------------

-- ----------------------------
-- Table structure for user_zone
-- ----------------------------
DROP TABLE IF EXISTS `user_zone`;
CREATE TABLE `user_zone` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `userid` int(6) NOT NULL COMMENT '会员id',
  `ownid` int(6) DEFAULT '0' COMMENT '推荐人id',
  `pid` int(6) DEFAULT '0' COMMENT '节点人上级id ',
  `zone` tinyint(2) DEFAULT '0' COMMENT '1区  2区 0是顶级会员',
  `level` int(10) DEFAULT '1' COMMENT '第几层',
  `pids` text COMMENT '上级节点人id集合',
  PRIMARY KEY (`id`),
  UNIQUE KEY `rex` (`pid`,`zone`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='会员分布\r\n';

-- ----------------------------
-- Records of user_zone
-- ----------------------------
INSERT INTO `user_zone` VALUES ('1', '1', '0', '0', '0', '1', '1,');
INSERT INTO `user_zone` VALUES ('2', '2', '1', '1', '1', '2', '1,2,');
