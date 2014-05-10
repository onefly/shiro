-------------------------------------------
-- Export file for user HKFRAME          --
-- Created by hxhk on 2014/1/7, 10:58:26 --
-------------------------------------------

spool oracle_crate_seq_security.log

prompt
prompt Creating sequence SEQ_SECURITY_MODULE
prompt =====================================
prompt
create sequence SEQ_SECURITY_MODULE
minvalue 1
maxvalue 999999999999999999999999999
start with 100
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SECURITY_ORGANIZATION
prompt ===========================================
prompt
create sequence SEQ_SECURITY_ORGANIZATION
minvalue 1
maxvalue 999999999999999999999999999
start with 100
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SECURITY_ROLE
prompt ===================================
prompt
create sequence SEQ_SECURITY_ROLE
minvalue 1
maxvalue 999999999999999999999999999
start with 100
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SECURITY_ROLE_PERMISSION
prompt ==============================================
prompt
create sequence SEQ_SECURITY_ROLE_PERMISSION
minvalue 1
maxvalue 999999999999999999999999999
start with 100
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SECURITY_USER
prompt ===================================
prompt
create sequence SEQ_SECURITY_USER
minvalue 1
maxvalue 999999999999999999999999999
start with 120
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SECURITY_USER_ROLE
prompt ========================================
prompt
create sequence SEQ_SECURITY_USER_ROLE
minvalue 1
maxvalue 999999999999999999999999999
start with 120
increment by 1
cache 20;


spool off
