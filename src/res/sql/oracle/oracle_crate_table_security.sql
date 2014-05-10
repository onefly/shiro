prompt PL/SQL Developer import file
prompt Created on 2014年1月9日 by hxhk
set feedback off
set define off
prompt Dropping SECURITY_MODULE...
drop table SECURITY_MODULE cascade constraints;
prompt Dropping SECURITY_ORGANIZATION...
drop table SECURITY_ORGANIZATION cascade constraints;
prompt Dropping SECURITY_ROLE...
drop table SECURITY_ROLE cascade constraints;
prompt Dropping SECURITY_ROLE_PERMISSION...
drop table SECURITY_ROLE_PERMISSION cascade constraints;
prompt Dropping SECURITY_USER...
drop table SECURITY_USER cascade constraints;
prompt Dropping SECURITY_USER_ROLE...
drop table SECURITY_USER_ROLE cascade constraints;
prompt Creating SECURITY_MODULE...
create table SECURITY_MODULE
(
  MODULE_ID   NUMBER not null,
  MODULE_DESC VARCHAR2(255),
  MODULE_NAME VARCHAR2(32) not null,
  PRIORITY    INTEGER,
  MODULE_URL  VARCHAR2(255) not null,
  PARENT_ID   NUMBER,
  SN          VARCHAR2(32) not null
)
;
alter table SECURITY_MODULE
  add primary key (MODULE_ID);

prompt Creating SECURITY_ORGANIZATION...
create table SECURITY_ORGANIZATION
(
  ORG_ID    NUMBER not null,
  ORG_DESC  VARCHAR2(255),
  ORG_NAME  VARCHAR2(64) not null,
  PARENT_ID NUMBER
)
;
alter table SECURITY_ORGANIZATION
  add primary key (ORG_ID);

prompt Creating SECURITY_ROLE...
create table SECURITY_ROLE
(
  ROLE_ID   NUMBER not null,
  ROLE_NAME VARCHAR2(32) not null
)
;
alter table SECURITY_ROLE
  add primary key (ROLE_ID);

prompt Creating SECURITY_ROLE_PERMISSION...
create table SECURITY_ROLE_PERMISSION
(
  ROLE_ID    NUMBER not null,
  PERMISSION VARCHAR2(255)
)
;

prompt Creating SECURITY_USER...
create table SECURITY_USER
(
  USER_ID     NUMBER not null,
  CREATE_TIME DATE,
  USER_PASS   VARCHAR2(64) not null,
  USER_SALT   VARCHAR2(32) not null,
  STATUS      VARCHAR2(20) not null,
  USERNAME    VARCHAR2(32) not null,
  EMAIL       VARCHAR2(128),
  REALNAME    VARCHAR2(32) not null,
  PHONE       VARCHAR2(32),
  ORG_ID      NUMBER
)
;
alter table SECURITY_USER
  add primary key (USER_ID);
alter table SECURITY_USER
  add constraint FK_ORG_ID foreign key (ORG_ID)
  references SECURITY_ORGANIZATION (ORG_ID);

prompt Creating SECURITY_USER_ROLE...
create table SECURITY_USER_ROLE
(
  USER_ROLE_ID NUMBER not null,
  PRIORITY     INTEGER not null,
  ROLE_ID      NUMBER,
  USER_ID      NUMBER
)
;
alter table SECURITY_USER_ROLE
  add primary key (USER_ROLE_ID);

prompt Loading SECURITY_MODULE...
insert into SECURITY_MODULE (MODULE_ID, MODULE_DESC, MODULE_NAME, PRIORITY, MODULE_URL, PARENT_ID, SN)
values (1, '所有模块的根节点，不能删除', '根模块', 1, '#', null, '0');
insert into SECURITY_MODULE (MODULE_ID, MODULE_DESC, MODULE_NAME, PRIORITY, MODULE_URL, PARENT_ID, SN)
values (2, '安全管理:包含权限管理、模块管理', '系统设置', 1, '#', 1, 'Security');
insert into SECURITY_MODULE (MODULE_ID, MODULE_DESC, MODULE_NAME, PRIORITY, MODULE_URL, PARENT_ID, SN)
values (3, null, '用户管理', 1, '/management/security/user/list', 2, 'User');
insert into SECURITY_MODULE (MODULE_ID, MODULE_DESC, MODULE_NAME, PRIORITY, MODULE_URL, PARENT_ID, SN)
values (4, null, '角色管理', 2, '/management/security/role/list', 2, 'Role');
insert into SECURITY_MODULE (MODULE_ID, MODULE_DESC, MODULE_NAME, PRIORITY, MODULE_URL, PARENT_ID, SN)
values (5, null, '模块管理', 4, '/management/security/module/tree', 2, 'Module');
insert into SECURITY_MODULE (MODULE_ID, MODULE_DESC, MODULE_NAME, PRIORITY, MODULE_URL, PARENT_ID, SN)
values (10, '查询平台的一些基本信息配置。', '收款管理', 9, '#', 1, 'Config');
insert into SECURITY_MODULE (MODULE_ID, MODULE_DESC, MODULE_NAME, PRIORITY, MODULE_URL, PARENT_ID, SN)
values (14, null, '收款账户', 99, '/management/config/receiveAccount/list', 10, 'ReceiveAccount');
insert into SECURITY_MODULE (MODULE_ID, MODULE_DESC, MODULE_NAME, PRIORITY, MODULE_URL, PARENT_ID, SN)
values (18, null, '组织管理', 3, '/management/security/organization/tree', 2, 'Organization');
insert into SECURITY_MODULE (MODULE_ID, MODULE_DESC, MODULE_NAME, PRIORITY, MODULE_URL, PARENT_ID, SN)
values (24, null, '缓存管理', 99, '/management/security/cacheManage/index', 2, 'CacheManage');
insert into SECURITY_MODULE (MODULE_ID, MODULE_DESC, MODULE_NAME, PRIORITY, MODULE_URL, PARENT_ID, SN)
values (27, null, '收款单位', 99, '/management/config/company/list', 10, 'Company');
insert into SECURITY_MODULE (MODULE_ID, MODULE_DESC, MODULE_NAME, PRIORITY, MODULE_URL, PARENT_ID, SN)
values (200, null, '订单管理', 50, '#', 1, 'order');
insert into SECURITY_MODULE (MODULE_ID, MODULE_DESC, MODULE_NAME, PRIORITY, MODULE_URL, PARENT_ID, SN)
values (202, null, '订单处理', 99, '￥', 200, 'ddd6767');
insert into SECURITY_MODULE (MODULE_ID, MODULE_DESC, MODULE_NAME, PRIORITY, MODULE_URL, PARENT_ID, SN)
values (240, null, '员工管理', 99, 'staffmanage', 1, 'staffmanage');
insert into SECURITY_MODULE (MODULE_ID, MODULE_DESC, MODULE_NAME, PRIORITY, MODULE_URL, PARENT_ID, SN)
values (282, '543534', '订单投诉', 99, '43534', 200, '43543454');
insert into SECURITY_MODULE (MODULE_ID, MODULE_DESC, MODULE_NAME, PRIORITY, MODULE_URL, PARENT_ID, SN)
values (242, null, '练习模块', 99, '/code/staff/list', 240, 'staff');
insert into SECURITY_MODULE (MODULE_ID, MODULE_DESC, MODULE_NAME, PRIORITY, MODULE_URL, PARENT_ID, SN)
values (262, '444', '款项管理', 99, '43', 10, '43534543');
insert into SECURITY_MODULE (MODULE_ID, MODULE_DESC, MODULE_NAME, PRIORITY, MODULE_URL, PARENT_ID, SN)
values (263, null, '开发练习', 99, '43455##', 240, 'kaifa');
commit;
prompt 17 records loaded
prompt Loading SECURITY_ORGANIZATION...
insert into SECURITY_ORGANIZATION (ORG_ID, ORG_DESC, ORG_NAME, PARENT_ID)
values (100, '华夏翰科科技有限公司', '华夏翰科', 2);
insert into SECURITY_ORGANIZATION (ORG_ID, ORG_DESC, ORG_NAME, PARENT_ID)
values (101, '研发部', '研发部', 100);
insert into SECURITY_ORGANIZATION (ORG_ID, ORG_DESC, ORG_NAME, PARENT_ID)
values (102, '财务部', '财务部', 100);
insert into SECURITY_ORGANIZATION (ORG_ID, ORG_DESC, ORG_NAME, PARENT_ID)
values (1, '不能删除。', '根组织', null);
insert into SECURITY_ORGANIZATION (ORG_ID, ORG_DESC, ORG_NAME, PARENT_ID)
values (2, null, '泸州电业', 1);
insert into SECURITY_ORGANIZATION (ORG_ID, ORG_DESC, ORG_NAME, PARENT_ID)
values (3, null, '龙马潭供电', 2);
insert into SECURITY_ORGANIZATION (ORG_ID, ORG_DESC, ORG_NAME, PARENT_ID)
values (5, null, '泸县供电', 2);
insert into SECURITY_ORGANIZATION (ORG_ID, ORG_DESC, ORG_NAME, PARENT_ID)
values (6, null, '纳溪供电', 2);
insert into SECURITY_ORGANIZATION (ORG_ID, ORG_DESC, ORG_NAME, PARENT_ID)
values (7, null, '和益电力', 2);
insert into SECURITY_ORGANIZATION (ORG_ID, ORG_DESC, ORG_NAME, PARENT_ID)
values (8, '玉宇电力玉宇电力玉宇电力', '玉宇电力', 2);
commit;
prompt 10 records loaded
prompt Loading SECURITY_ROLE...
insert into SECURITY_ROLE (ROLE_ID, ROLE_NAME)
values (3, '管理员');
insert into SECURITY_ROLE (ROLE_ID, ROLE_NAME)
values (5, '营销人员');
insert into SECURITY_ROLE (ROLE_ID, ROLE_NAME)
values (4, '财务人员');
insert into SECURITY_ROLE (ROLE_ID, ROLE_NAME)
values (1, '超级管理员');
insert into SECURITY_ROLE (ROLE_ID, ROLE_NAME)
values (100, '研发人员');
commit;
prompt 5 records loaded
prompt Loading SECURITY_ROLE_PERMISSION...
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Security:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Security:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Security:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Security:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'User:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'User:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'User:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'User:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Organization:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Organization:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Organization:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Organization:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'CacheManage:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'CacheManage:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'CacheManage:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'CacheManage:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Module:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Module:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Module:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Module:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Role:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Security:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Security:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Security:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Security:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'User:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'User:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Role:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Role:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Role:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'staffmanage:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'staffmanage:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'staffmanage:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'staffmanage:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'staff:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'staff:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'staff:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'staff:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'kaifa:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'kaifa:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'kaifa:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'kaifa:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Config:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Config:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Config:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Config:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'person:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'person:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'person:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'person:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Company:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Company:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Company:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'Company:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, '43534543:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, '43534543:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, '43534543:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, '43534543:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'ReceiveAccount:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'ReceiveAccount:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'ReceiveAccount:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'ReceiveAccount:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'order:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'order:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'order:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'order:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'tongji:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'tongji:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'tongji:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'User:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'User:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Role:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Role:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Role:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Role:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Organization:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Organization:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Organization:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Organization:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Module:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Module:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Module:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'CacheManage:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'CacheManage:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'CacheManage:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'CacheManage:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'staffmanage:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'staffmanage:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'staffmanage:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'staffmanage:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'staff:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'staff:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'staff:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'staff:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'kaifa:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'kaifa:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'kaifa:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'kaifa:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Config:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Config:save');
commit;
prompt 100 records committed...
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Config:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Config:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Company:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Company:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Company:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'Company:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'ReceiveAccount:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'ReceiveAccount:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'ReceiveAccount:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'ReceiveAccount:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'order:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'order:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'order:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'order:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'ddd:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'ddd:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'ddd:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'ddd:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'tongji:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'tongji:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'tongji:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'tongji:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'week:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'week:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'week:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'week:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'xioal:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'xioal:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'tongji:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'mondt:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'mondt:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'mondt:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'mondt:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'week:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'week:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'week:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'week:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'xioal:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'xioal:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'xioal:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'xioal:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, '34534:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, '34534:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, '34534:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'xioal:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'xioal:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, '34534:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, '34534:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, '34534:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, '34534:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'mondt:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, '34534:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'ddd:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'ddd:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'ddd:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (1, 'ddd:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'mondt:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'mondt:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (3, 'mondt:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (100, 'Security:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (100, 'Security:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (100, 'Security:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (100, 'Security:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (100, 'User:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (100, 'User:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (100, 'User:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (100, 'User:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (100, 'Organization:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (100, 'Organization:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'User:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'User:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'User:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'User:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'order:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'order:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'tongji:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'tongji:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'mondt:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'mondt:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'week:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'week:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'Config:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'ReceiveAccount:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'ReceiveAccount:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'ReceiveAccount:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'ReceiveAccount:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'PayUser:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'PayUser:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'PayUser:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'PayUser:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'Company:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'Company:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'Company:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (4, 'Company:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (5, 'User:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (5, 'User:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (5, 'User:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (5, 'Organization:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (5, 'Organization:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (5, 'Organization:edit');
commit;
prompt 200 records committed...
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (5, 'Organization:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (5, 'staffmanage:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (5, 'staffmanage:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (5, 'staffmanage:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (5, 'staffmanage:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (5, 'staff:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (5, 'staff:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (5, 'staff:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (5, 'staff:delete');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (5, 'Config:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (5, 'ReceiveAccount:view');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (5, 'ReceiveAccount:save');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (5, 'ReceiveAccount:edit');
insert into SECURITY_ROLE_PERMISSION (ROLE_ID, PERMISSION)
values (5, 'ReceiveAccount:delete');
commit;
prompt 214 records loaded
prompt Loading SECURITY_USER...
insert into SECURITY_USER (USER_ID, CREATE_TIME, USER_PASS, USER_SALT, STATUS, USERNAME, EMAIL, REALNAME, PHONE, ORG_ID)
values (100, to_date('06-01-2014 17:45:45', 'dd-mm-yyyy hh24:mi:ss'), '886d3791989faa182a0e7a5254cd75275ca4fd2d', '604e258f71848b83', 'enabled', 'hxhk', '6565656@qq.com', '翰科', '232235656', 8);
insert into SECURITY_USER (USER_ID, CREATE_TIME, USER_PASS, USER_SALT, STATUS, USERNAME, EMAIL, REALNAME, PHONE, ORG_ID)
values (1, to_date('03-01-2014 18:18:28', 'dd-mm-yyyy hh24:mi:ss'), 'cbe5c339a2beb940bddd43f30486473fac2e0658', '9bdab4aa2895266b', 'enabled', 'admin', 'yaoqiang@yahoo.cn', '姚强', '13518109999', 2);
insert into SECURITY_USER (USER_ID, CREATE_TIME, USER_PASS, USER_SALT, STATUS, USERNAME, EMAIL, REALNAME, PHONE, ORG_ID)
values (3, to_date('03-01-2014 18:18:28', 'dd-mm-yyyy hh24:mi:ss'), '802874fa2303c5ef3d5ce56fbeba6a16f2ff7aef', 'acda641cfd0f313d', 'enabled', 'zs', '21vv12@sas.com', '张三', null, 3);
insert into SECURITY_USER (USER_ID, CREATE_TIME, USER_PASS, USER_SALT, STATUS, USERNAME, EMAIL, REALNAME, PHONE, ORG_ID)
values (8, to_date('03-01-2014 18:18:28', 'dd-mm-yyyy hh24:mi:ss'), '0d44d808a023549ff328a358c2ff4e11b82a38c9', 'e094b48ae2aec9ed', 'enabled', 'gly', null, '管理员', '454654645', 2);
insert into SECURITY_USER (USER_ID, CREATE_TIME, USER_PASS, USER_SALT, STATUS, USERNAME, EMAIL, REALNAME, PHONE, ORG_ID)
values (9, to_date('03-01-2014 18:18:28', 'dd-mm-yyyy hh24:mi:ss'), '3caa91db8be780ff39f9878f6ddef05e765b6ff0', '141f8ee62d55a0a3', 'disabled', 'cw', null, '财务', '4444444', 2);
commit;
prompt 5 records loaded
prompt Loading SECURITY_USER_ROLE...
insert into SECURITY_USER_ROLE (USER_ROLE_ID, PRIORITY, ROLE_ID, USER_ID)
values (1, 1, 1, 1);
insert into SECURITY_USER_ROLE (USER_ROLE_ID, PRIORITY, ROLE_ID, USER_ID)
values (3, 99, 3, 3);
insert into SECURITY_USER_ROLE (USER_ROLE_ID, PRIORITY, ROLE_ID, USER_ID)
values (4, 99, 4, 4);
insert into SECURITY_USER_ROLE (USER_ROLE_ID, PRIORITY, ROLE_ID, USER_ID)
values (6, 99, 5, 5);
insert into SECURITY_USER_ROLE (USER_ROLE_ID, PRIORITY, ROLE_ID, USER_ID)
values (8, 99, 3, 8);
insert into SECURITY_USER_ROLE (USER_ROLE_ID, PRIORITY, ROLE_ID, USER_ID)
values (9, 99, 4, 9);
insert into SECURITY_USER_ROLE (USER_ROLE_ID, PRIORITY, ROLE_ID, USER_ID)
values (100, 99, 3, 100);
commit;
prompt 7 records loaded
set feedback on
set define on
prompt Done.
