/*
PostgreSQL Backup
Database: rsws_db/public
Backup Time: 2024-08-27 02:21:07
*/

DROP SEQUENCE IF EXISTS "public"."system_login_log_seq";
DROP TABLE IF EXISTS "public"."cust_login_log";
DROP TABLE IF EXISTS "public"."cust_operate_log";
DROP TABLE IF EXISTS "public"."cust_payout";
DROP TABLE IF EXISTS "public"."cust_users";
DROP TABLE IF EXISTS "public"."rsws_conf";
DROP TABLE IF EXISTS "public"."rsws_cregis_conf";
DROP TABLE IF EXISTS "public"."rsws_login_log";
DROP TABLE IF EXISTS "public"."rsws_menu";
DROP TABLE IF EXISTS "public"."rsws_payinput";
DROP TABLE IF EXISTS "public"."rsws_resource";
DROP TABLE IF EXISTS "public"."rsws_role";
DROP TABLE IF EXISTS "public"."rsws_smtp_conf";
DROP TABLE IF EXISTS "public"."rsws_user";
DROP TABLE IF EXISTS "public"."rsws_user_role";
CREATE SEQUENCE "system_login_log_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
CREATE TABLE "cust_login_log" (
  "id" int8 NOT NULL,
  "login_user_id" int8 NOT NULL,
  "login_username" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "login_data" timestamp(6) NOT NULL,
  "login_result" int2 NOT NULL,
  "login_ip" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "user_agent" varchar(512) COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "cust_login_log" OWNER TO "anarchism";
COMMENT ON COLUMN "cust_login_log"."id" IS '访问ID';
COMMENT ON COLUMN "cust_login_log"."login_user_id" IS '登陆账号';
COMMENT ON COLUMN "cust_login_log"."login_username" IS '登陆账号';
COMMENT ON COLUMN "cust_login_log"."login_data" IS '登陆时间';
COMMENT ON COLUMN "cust_login_log"."login_result" IS '登录结果(成功/失败)';
COMMENT ON COLUMN "cust_login_log"."login_ip" IS '登陆IP';
COMMENT ON COLUMN "cust_login_log"."user_agent" IS 'UA';
COMMENT ON TABLE "cust_login_log" IS '用户登陆日志';
CREATE TABLE "cust_operate_log" (
  "id" int8 NOT NULL,
  "log_level" varchar(10) COLLATE "pg_catalog"."default" NOT NULL,
  "trace_id" varchar(64) COLLATE "pg_catalog"."default",
  "user_id" int8 NOT NULL,
  "operate" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "action" varchar(2000) COLLATE "pg_catalog"."default" NOT NULL,
  "extra" varchar(2000) COLLATE "pg_catalog"."default" NOT NULL,
  "result" varchar(16) COLLATE "pg_catalog"."default" NOT NULL,
  "req_method" varchar(16) COLLATE "pg_catalog"."default",
  "req_url" varchar(255) COLLATE "pg_catalog"."default",
  "user_ip" varchar(50) COLLATE "pg_catalog"."default",
  "user_agent" varchar(512) COLLATE "pg_catalog"."default",
  "res_code" varchar(16) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6) NOT NULL
)
;
ALTER TABLE "cust_operate_log" OWNER TO "anarchism";
COMMENT ON COLUMN "cust_operate_log"."id" IS '日志序号';
COMMENT ON COLUMN "cust_operate_log"."log_level" IS '日志级别';
COMMENT ON COLUMN "cust_operate_log"."trace_id" IS '链路追踪编号';
COMMENT ON COLUMN "cust_operate_log"."user_id" IS '用户id';
COMMENT ON COLUMN "cust_operate_log"."operate" IS '用户操作';
COMMENT ON COLUMN "cust_operate_log"."action" IS '操作内容';
COMMENT ON COLUMN "cust_operate_log"."extra" IS '拓展字段';
COMMENT ON COLUMN "cust_operate_log"."result" IS '操作结果（成功/失败）';
COMMENT ON COLUMN "cust_operate_log"."req_method" IS '请求方法';
COMMENT ON COLUMN "cust_operate_log"."req_url" IS '请求地址';
COMMENT ON COLUMN "cust_operate_log"."user_ip" IS '发起请求的IP';
COMMENT ON COLUMN "cust_operate_log"."user_agent" IS 'UA';
COMMENT ON COLUMN "cust_operate_log"."res_code" IS '操作返回代码';
COMMENT ON COLUMN "cust_operate_log"."create_time" IS '记录生成时间';
COMMENT ON TABLE "cust_operate_log" IS '用户操作日志表';
CREATE TABLE "cust_payout" (
  "id" int8 NOT NULL,
  "user_id" int8 NOT NULL,
  "pid" int8 NOT NULL,
  "cid" int8 NOT NULL,
  "alias" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "chain_id" varchar(6) COLLATE "pg_catalog"."default" NOT NULL,
  "token_id" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "address" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "amount" numeric(12,6) NOT NULL,
  "status" int8 NOT NULL,
  "txid" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "block_height" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "block_time" timestamp(6) NOT NULL,
  "nonce" varchar(6) COLLATE "pg_catalog"."default" NOT NULL,
  "times" timestamp(6) NOT NULL,
  "sign" varchar(64) COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "cust_payout" OWNER TO "anarchism";
COMMENT ON COLUMN "cust_payout"."user_id" IS '用户id';
COMMENT ON COLUMN "cust_payout"."pid" IS '订单编号';
COMMENT ON COLUMN "cust_payout"."cid" IS '系统流水号';
COMMENT ON COLUMN "cust_payout"."alias" IS '币种名称';
COMMENT ON COLUMN "cust_payout"."chain_id" IS '链编号';
COMMENT ON COLUMN "cust_payout"."token_id" IS '币种编号';
COMMENT ON COLUMN "cust_payout"."address" IS '钱包地址';
COMMENT ON COLUMN "cust_payout"."amount" IS '交易金额';
COMMENT ON COLUMN "cust_payout"."status" IS '交易状态';
COMMENT ON COLUMN "cust_payout"."txid" IS '交易哈希';
COMMENT ON COLUMN "cust_payout"."block_height" IS '交易高度';
COMMENT ON COLUMN "cust_payout"."block_time" IS '区块时间';
COMMENT ON COLUMN "cust_payout"."nonce" IS '6位随机字符串';
COMMENT ON COLUMN "cust_payout"."times" IS '时间戳';
COMMENT ON COLUMN "cust_payout"."sign" IS '交易签名';
COMMENT ON TABLE "cust_payout" IS '用户交易订单';
CREATE TABLE "cust_users" (
  "id" int8 NOT NULL,
  "username" varchar(30) COLLATE "pg_catalog"."default" NOT NULL,
  "password" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "nickname" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "email" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "avatar" varchar(512) COLLATE "pg_catalog"."default",
  "status" int2 NOT NULL,
  "login_ip" varchar(50) COLLATE "pg_catalog"."default",
  "login_data" timestamp(6),
  "creator" varchar(64) COLLATE "pg_catalog"."default",
  "creator_time" timestamp(6) NOT NULL,
  "update" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6) NOT NULL
)
;
ALTER TABLE "cust_users" OWNER TO "anarchism";
COMMENT ON COLUMN "cust_users"."id" IS '用户id';
COMMENT ON COLUMN "cust_users"."username" IS '用户账号';
COMMENT ON COLUMN "cust_users"."password" IS '密码';
COMMENT ON COLUMN "cust_users"."nickname" IS '用户昵称';
COMMENT ON COLUMN "cust_users"."email" IS '邮箱';
COMMENT ON COLUMN "cust_users"."avatar" IS '头像地址';
COMMENT ON COLUMN "cust_users"."status" IS '账号状态';
COMMENT ON COLUMN "cust_users"."login_ip" IS '最后登录ip';
COMMENT ON COLUMN "cust_users"."login_data" IS '最后登录时间';
COMMENT ON COLUMN "cust_users"."creator" IS '创建人';
COMMENT ON COLUMN "cust_users"."creator_time" IS '创建时间';
COMMENT ON COLUMN "cust_users"."update" IS '操作人';
COMMENT ON COLUMN "cust_users"."update_time" IS '修改时间';
COMMENT ON TABLE "cust_users" IS '用户表';
CREATE TABLE "rsws_conf" (
  "id" int8 NOT NULL,
  "rsws_name" varchar(50) COLLATE "pg_catalog"."default",
  "pub_recrod" varchar(50) COLLATE "pg_catalog"."default",
  "rsws_icon" varchar(512) COLLATE "pg_catalog"."default",
  "rsws_kefu" varchar(512) COLLATE "pg_catalog"."default",
  "cust_login_bg" varchar(512) COLLATE "pg_catalog"."default",
  "rsws_login_bg" varchar(512) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "rsws_conf" OWNER TO "anarchism";
COMMENT ON COLUMN "rsws_conf"."id" IS '自增id';
COMMENT ON COLUMN "rsws_conf"."rsws_name" IS '网站名称';
COMMENT ON COLUMN "rsws_conf"."pub_recrod" IS '公网备案';
COMMENT ON COLUMN "rsws_conf"."rsws_icon" IS '网站图标';
COMMENT ON COLUMN "rsws_conf"."rsws_kefu" IS '客服链接';
COMMENT ON COLUMN "rsws_conf"."cust_login_bg" IS '用户登陆页面背景图片';
COMMENT ON COLUMN "rsws_conf"."rsws_login_bg" IS '管理员登陆页面背景图片';
COMMENT ON TABLE "rsws_conf" IS '网站设置';
CREATE TABLE "rsws_cregis_conf" (
  "id" int8 NOT NULL
)
;
ALTER TABLE "rsws_cregis_conf" OWNER TO "anarchism";
COMMENT ON TABLE "rsws_cregis_conf" IS 'Cregis配置表，使用anychain_tron实现';
CREATE TABLE "rsws_login_log" (
  "id" int8 NOT NULL,
  "loin_id" int8 NOT NULL,
  "login_type" int2 NOT NULL,
  "login_username" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "login_result" int2 NOT NULL,
  "login_ip" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "user_agent" varchar(512) COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "rsws_login_log" OWNER TO "anarchism";
COMMENT ON COLUMN "rsws_login_log"."id" IS '访问ID';
COMMENT ON COLUMN "rsws_login_log"."loin_id" IS '用户ID';
COMMENT ON COLUMN "rsws_login_log"."login_type" IS '用户类型';
COMMENT ON COLUMN "rsws_login_log"."login_username" IS '登陆账号';
COMMENT ON COLUMN "rsws_login_log"."login_result" IS '登陆结果';
COMMENT ON COLUMN "rsws_login_log"."login_ip" IS '登陆IP';
COMMENT ON COLUMN "rsws_login_log"."user_agent" IS 'UA';
COMMENT ON TABLE "rsws_login_log" IS '管理员登陆日志';
CREATE TABLE "rsws_menu" (
  "id" int8 NOT NULL,
  "menu_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "permission" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "type" int8 NOT NULL,
  "parrent_id" int8 NOT NULL,
  "path" varchar(200) COLLATE "pg_catalog"."default",
  "icon" varchar(100) COLLATE "pg_catalog"."default",
  "status" int8 NOT NULL,
  "visible" bool NOT NULL,
  "always_show" bool NOT NULL,
  "creator" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "creater_time" timestamp(6) NOT NULL,
  "updater" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "update_time" timestamp(6) NOT NULL
)
;
ALTER TABLE "rsws_menu" OWNER TO "anarchism";
COMMENT ON COLUMN "rsws_menu"."id" IS '菜单ID';
COMMENT ON COLUMN "rsws_menu"."menu_name" IS '菜单项名称';
COMMENT ON COLUMN "rsws_menu"."permission" IS '权限标识';
COMMENT ON COLUMN "rsws_menu"."type" IS '菜单类型';
COMMENT ON COLUMN "rsws_menu"."parrent_id" IS '父菜单id';
COMMENT ON COLUMN "rsws_menu"."path" IS '路由地址';
COMMENT ON COLUMN "rsws_menu"."icon" IS '菜单图标';
COMMENT ON COLUMN "rsws_menu"."status" IS '菜单状态';
COMMENT ON COLUMN "rsws_menu"."visible" IS '是否可见';
COMMENT ON COLUMN "rsws_menu"."always_show" IS '是否总是显示';
COMMENT ON COLUMN "rsws_menu"."creator" IS '创建人';
COMMENT ON COLUMN "rsws_menu"."creater_time" IS '创建时间';
COMMENT ON COLUMN "rsws_menu"."updater" IS '操作人';
COMMENT ON COLUMN "rsws_menu"."update_time" IS '更新时间';
COMMENT ON TABLE "rsws_menu" IS '菜单表权限表';
CREATE TABLE "rsws_payinput" (
  "id" int8 NOT NULL,
  "user_id" int8 NOT NULL,
  "block_type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "alias" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "chain_id" int8 NOT NULL,
  "token_id" int8 NOT NULL,
  "address" varchar(512) COLLATE "pg_catalog"."default" NOT NULL,
  "creator" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL,
  "updater" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "update_time" timestamp(6) NOT NULL
)
;
ALTER TABLE "rsws_payinput" OWNER TO "anarchism";
COMMENT ON COLUMN "rsws_payinput"."user_id" IS '用户id';
COMMENT ON COLUMN "rsws_payinput"."block_type" IS '区块类型';
COMMENT ON COLUMN "rsws_payinput"."alias" IS '币种名称';
COMMENT ON COLUMN "rsws_payinput"."chain_id" IS '链编号';
COMMENT ON COLUMN "rsws_payinput"."token_id" IS '币种编号';
COMMENT ON COLUMN "rsws_payinput"."address" IS '钱包地址';
COMMENT ON COLUMN "rsws_payinput"."creator" IS '创建人';
COMMENT ON COLUMN "rsws_payinput"."create_time" IS '创建时间';
COMMENT ON COLUMN "rsws_payinput"."updater" IS '操作人';
COMMENT ON COLUMN "rsws_payinput"."update_time" IS '编辑时间';
COMMENT ON TABLE "rsws_payinput" IS '收款钱包';
CREATE TABLE "rsws_resource" (
  "id" int8 NOT NULL,
  "rsname" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "rstype" int8 NOT NULL,
  "rspath" varchar(512) COLLATE "pg_catalog"."default" NOT NULL,
  "rsprice" numeric(10,2) NOT NULL,
  "rsavatar" varchar(512) COLLATE "pg_catalog"."default" NOT NULL,
  "creator" int8 NOT NULL,
  "create_time" timestamp(6) NOT NULL,
  "rsversion" varchar(255) COLLATE "pg_catalog"."default",
  "updater" varchar(50) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6)
)
;
ALTER TABLE "rsws_resource" OWNER TO "anarchism";
COMMENT ON COLUMN "rsws_resource"."id" IS '资源id';
COMMENT ON COLUMN "rsws_resource"."rsname" IS '资源名称';
COMMENT ON COLUMN "rsws_resource"."rstype" IS '资源类型';
COMMENT ON COLUMN "rsws_resource"."rspath" IS '资源链接';
COMMENT ON COLUMN "rsws_resource"."rsprice" IS '资源单价';
COMMENT ON COLUMN "rsws_resource"."rsavatar" IS '资源大图';
COMMENT ON COLUMN "rsws_resource"."creator" IS '归属账号id';
COMMENT ON COLUMN "rsws_resource"."create_time" IS '上传时间';
COMMENT ON COLUMN "rsws_resource"."rsversion" IS '资源版本';
COMMENT ON COLUMN "rsws_resource"."updater" IS '修改';
COMMENT ON COLUMN "rsws_resource"."update_time" IS '修改时间';
COMMENT ON TABLE "rsws_resource" IS '售卖资源信息表';
CREATE TABLE "rsws_role" (
  "id" int8 NOT NULL,
  "name" varchar(30) COLLATE "pg_catalog"."default" NOT NULL,
  "role_code" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "data_scope" int2 NOT NULL,
  "status" int2 NOT NULL,
  "type" int2 NOT NULL,
  "creator" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6) NOT NULL,
  "updater" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6) NOT NULL
)
;
ALTER TABLE "rsws_role" OWNER TO "anarchism";
COMMENT ON COLUMN "rsws_role"."id" IS '角色ID';
COMMENT ON COLUMN "rsws_role"."name" IS '角色名称';
COMMENT ON COLUMN "rsws_role"."role_code" IS '角色权限字符串';
COMMENT ON COLUMN "rsws_role"."data_scope" IS '数据范围（1：全部数据权限 2：自定数据权限 3：本分组数据权限 4：本分组及以下数据权限）';
COMMENT ON COLUMN "rsws_role"."status" IS '角色状态（0正常  1停用）';
COMMENT ON COLUMN "rsws_role"."type" IS '角色类型';
COMMENT ON COLUMN "rsws_role"."creator" IS '创建人';
COMMENT ON COLUMN "rsws_role"."create_time" IS '创建时间';
COMMENT ON COLUMN "rsws_role"."updater" IS '操作人';
COMMENT ON COLUMN "rsws_role"."update_time" IS '修改时间';
COMMENT ON TABLE "rsws_role" IS '角色';
CREATE TABLE "rsws_smtp_conf" (
  "id" int8 NOT NULL,
  "smtp_email" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "reply_email" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "smtp_sub" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "content_type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "smtp_body" varchar(512) COLLATE "pg_catalog"."default" NOT NULL,
  "smtp_username" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "smtp_password" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "smtp_starttls" varchar(50) COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "rsws_smtp_conf" OWNER TO "anarchism";
COMMENT ON COLUMN "rsws_smtp_conf"."smtp_email" IS '发送邮件的邮箱地址';
COMMENT ON COLUMN "rsws_smtp_conf"."reply_email" IS '邮件回复地址';
COMMENT ON COLUMN "rsws_smtp_conf"."smtp_sub" IS '邮件主题';
COMMENT ON COLUMN "rsws_smtp_conf"."content_type" IS '邮件类型';
COMMENT ON COLUMN "rsws_smtp_conf"."smtp_body" IS '邮件内容';
COMMENT ON COLUMN "rsws_smtp_conf"."smtp_username" IS 'smtp服务认证账号';
COMMENT ON COLUMN "rsws_smtp_conf"."smtp_password" IS 'smtp服务认证密码';
COMMENT ON COLUMN "rsws_smtp_conf"."smtp_starttls" IS 'smtp服务器地址';
COMMENT ON TABLE "rsws_smtp_conf" IS 'smtp邮件服务配置';
CREATE TABLE "rsws_user" (
  "id" int8 NOT NULL,
  "username" varchar(30) COLLATE "pg_catalog"."default" NOT NULL,
  "password" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "nickname" varchar(30) COLLATE "pg_catalog"."default" NOT NULL,
  "email" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "avatar" varchar(512) COLLATE "pg_catalog"."default",
  "status" int2 NOT NULL,
  "login_ip" varchar(50) COLLATE "pg_catalog"."default",
  "login_data" timestamp(6),
  "creator" varchar(64) COLLATE "pg_catalog"."default",
  "create_data" timestamp(6) NOT NULL,
  "updater" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6) NOT NULL
)
;
ALTER TABLE "rsws_user" OWNER TO "anarchism";
COMMENT ON COLUMN "rsws_user"."id" IS '用户ID';
COMMENT ON COLUMN "rsws_user"."username" IS '用户账号';
COMMENT ON COLUMN "rsws_user"."password" IS '密码';
COMMENT ON COLUMN "rsws_user"."nickname" IS '用户昵称';
COMMENT ON COLUMN "rsws_user"."email" IS '用户邮箱';
COMMENT ON COLUMN "rsws_user"."avatar" IS '头像地址';
COMMENT ON COLUMN "rsws_user"."status" IS '账号状态';
COMMENT ON COLUMN "rsws_user"."login_ip" IS '最后登陆IP';
COMMENT ON COLUMN "rsws_user"."login_data" IS '最后登陆时间';
COMMENT ON COLUMN "rsws_user"."creator" IS '创建人';
COMMENT ON COLUMN "rsws_user"."create_data" IS '创建时间';
COMMENT ON COLUMN "rsws_user"."updater" IS '操作员';
COMMENT ON COLUMN "rsws_user"."update_time" IS '更新时间';
COMMENT ON TABLE "rsws_user" IS '管理员表';
CREATE TABLE "rsws_user_role" (
  "id" int8 NOT NULL,
  "user_id" int8 NOT NULL,
  "role_id" int8 NOT NULL,
  "crator" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "crate_time" timestamp(6) NOT NULL
)
;
ALTER TABLE "rsws_user_role" OWNER TO "anarchism";
COMMENT ON COLUMN "rsws_user_role"."id" IS '编号';
COMMENT ON COLUMN "rsws_user_role"."user_id" IS '用户id';
COMMENT ON COLUMN "rsws_user_role"."role_id" IS '角色id';
COMMENT ON COLUMN "rsws_user_role"."crator" IS '创建人';
COMMENT ON COLUMN "rsws_user_role"."crate_time" IS '创建时间';
COMMENT ON TABLE "rsws_user_role" IS '用户与角色对照表';
BEGIN;
LOCK TABLE "public"."cust_login_log" IN SHARE MODE;
DELETE FROM "public"."cust_login_log";
COMMIT;
BEGIN;
LOCK TABLE "public"."cust_operate_log" IN SHARE MODE;
DELETE FROM "public"."cust_operate_log";
COMMIT;
BEGIN;
LOCK TABLE "public"."cust_payout" IN SHARE MODE;
DELETE FROM "public"."cust_payout";
COMMIT;
BEGIN;
LOCK TABLE "public"."cust_users" IN SHARE MODE;
DELETE FROM "public"."cust_users";
COMMIT;
BEGIN;
LOCK TABLE "public"."rsws_conf" IN SHARE MODE;
DELETE FROM "public"."rsws_conf";
COMMIT;
BEGIN;
LOCK TABLE "public"."rsws_cregis_conf" IN SHARE MODE;
DELETE FROM "public"."rsws_cregis_conf";
COMMIT;
BEGIN;
LOCK TABLE "public"."rsws_login_log" IN SHARE MODE;
DELETE FROM "public"."rsws_login_log";
COMMIT;
BEGIN;
LOCK TABLE "public"."rsws_menu" IN SHARE MODE;
DELETE FROM "public"."rsws_menu";
COMMIT;
BEGIN;
LOCK TABLE "public"."rsws_payinput" IN SHARE MODE;
DELETE FROM "public"."rsws_payinput";
COMMIT;
BEGIN;
LOCK TABLE "public"."rsws_resource" IN SHARE MODE;
DELETE FROM "public"."rsws_resource";
COMMIT;
BEGIN;
LOCK TABLE "public"."rsws_role" IN SHARE MODE;
DELETE FROM "public"."rsws_role";
COMMIT;
BEGIN;
LOCK TABLE "public"."rsws_smtp_conf" IN SHARE MODE;
DELETE FROM "public"."rsws_smtp_conf";
COMMIT;
BEGIN;
LOCK TABLE "public"."rsws_user" IN SHARE MODE;
DELETE FROM "public"."rsws_user";
COMMIT;
BEGIN;
LOCK TABLE "public"."rsws_user_role" IN SHARE MODE;
DELETE FROM "public"."rsws_user_role";
COMMIT;
ALTER TABLE "cust_login_log" ADD CONSTRAINT "cust_login_log_pkey" PRIMARY KEY ("id");
ALTER TABLE "cust_operate_log" ADD CONSTRAINT "cust_operate_log_pkey" PRIMARY KEY ("id");
ALTER TABLE "cust_payout" ADD CONSTRAINT "cust_payout_pkey" PRIMARY KEY ("id");
ALTER TABLE "cust_users" ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");
ALTER TABLE "rsws_conf" ADD CONSTRAINT "rsws_conf_pkey" PRIMARY KEY ("id");
ALTER TABLE "rsws_cregis_conf" ADD CONSTRAINT "rsws_cregis_conf_pkey" PRIMARY KEY ("id");
ALTER TABLE "rsws_login_log" ADD CONSTRAINT "rsws_login_log_pkey" PRIMARY KEY ("id");
ALTER TABLE "rsws_menu" ADD CONSTRAINT "rsws_menu_pkey" PRIMARY KEY ("id");
ALTER TABLE "rsws_payinput" ADD CONSTRAINT "rsws_payinput_pkey" PRIMARY KEY ("id");
ALTER TABLE "rsws_resource" ADD CONSTRAINT "rsws_resource_pkey" PRIMARY KEY ("id");
ALTER TABLE "rsws_role" ADD CONSTRAINT "rsws_role_pkey" PRIMARY KEY ("id");
ALTER TABLE "rsws_smtp_conf" ADD CONSTRAINT "rsws_smtp_conf_pkey" PRIMARY KEY ("id");
ALTER TABLE "rsws_user" ADD CONSTRAINT "system_user_pkey" PRIMARY KEY ("id");
ALTER TABLE "rsws_user_role" ADD CONSTRAINT "sys_user_role_pkey" PRIMARY KEY ("id");
SELECT setval('"system_login_log_seq"', 1, false);
ALTER SEQUENCE "system_login_log_seq" OWNER TO "anarchism";
