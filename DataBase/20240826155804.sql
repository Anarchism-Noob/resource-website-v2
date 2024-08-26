/*
PostgreSQL Backup
Database: rsws_db/public
Backup Time: 2024-08-26 15:58:06
*/

DROP TABLE IF EXISTS "public"."cust_users";
DROP TABLE IF EXISTS "public"."rsws_conf";
DROP TABLE IF EXISTS "public"."rsws_menu";
DROP TABLE IF EXISTS "public"."rsws_role";
DROP TABLE IF EXISTS "public"."rsws_user";
DROP TABLE IF EXISTS "public"."rsws_user_role";
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
  "send_email" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "reply_email" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "smtp_username" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "smtp_password" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "smtp_starttls" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "rsws_name" varchar(255) COLLATE "pg_catalog"."default",
  "pub_recrod" varchar(255) COLLATE "pg_catalog"."default",
  "rsws_icon" varchar(255) COLLATE "pg_catalog"."default",
  "rsws_kefu" varchar(255) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "rsws_conf" OWNER TO "anarchism";
COMMENT ON COLUMN "rsws_conf"."send_email" IS '发送验证码的邮箱地址';
COMMENT ON COLUMN "rsws_conf"."reply_email" IS '邮件回复地址';
COMMENT ON COLUMN "rsws_conf"."smtp_username" IS 'smtp服务认证凭证的账号';
COMMENT ON COLUMN "rsws_conf"."smtp_password" IS 'smtp服务认证凭证的密码';
COMMENT ON COLUMN "rsws_conf"."smtp_starttls" IS 'smtp服务器地址';
COMMENT ON COLUMN "rsws_conf"."rsws_name" IS '网站名称';
COMMENT ON COLUMN "rsws_conf"."pub_recrod" IS '公网备案';
COMMENT ON COLUMN "rsws_conf"."rsws_icon" IS '网站图标';
COMMENT ON COLUMN "rsws_conf"."rsws_kefu" IS '客服链接';
COMMENT ON TABLE "rsws_conf" IS '网站设置';
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
LOCK TABLE "public"."cust_users" IN SHARE MODE;
DELETE FROM "public"."cust_users";
COMMIT;
BEGIN;
LOCK TABLE "public"."rsws_conf" IN SHARE MODE;
DELETE FROM "public"."rsws_conf";
COMMIT;
BEGIN;
LOCK TABLE "public"."rsws_menu" IN SHARE MODE;
DELETE FROM "public"."rsws_menu";
COMMIT;
BEGIN;
LOCK TABLE "public"."rsws_role" IN SHARE MODE;
DELETE FROM "public"."rsws_role";
COMMIT;
BEGIN;
LOCK TABLE "public"."rsws_user" IN SHARE MODE;
DELETE FROM "public"."rsws_user";
COMMIT;
BEGIN;
LOCK TABLE "public"."rsws_user_role" IN SHARE MODE;
DELETE FROM "public"."rsws_user_role";
COMMIT;
ALTER TABLE "cust_users" ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");
ALTER TABLE "rsws_menu" ADD CONSTRAINT "rsws_menu_pkey" PRIMARY KEY ("id");
ALTER TABLE "rsws_role" ADD CONSTRAINT "rsws_role_pkey" PRIMARY KEY ("id");
ALTER TABLE "rsws_user" ADD CONSTRAINT "system_user_pkey" PRIMARY KEY ("id");
ALTER TABLE "rsws_user_role" ADD CONSTRAINT "sys_user_role_pkey" PRIMARY KEY ("id");
