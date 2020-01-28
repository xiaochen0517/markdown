# 个人博客系统数据库设计
create database moblog;

use moblog;

# 管理员表
create table admin(
	`id` int not null primary key auto_increment,
    `username` varchar(20) not null, # 用户名
    `password` varchar(32) not null, # 密码
    `level` int not null default 1 # 管理员等级
);

# 用户登录信息表
create table user(
	`id` int not null primary key auto_increment, # id
    `username` varchar(20) not null unique, # 用户名
    `password` varchar(32) not null, # 密码
    `status` boolean not null default false # 账户状态
);

# 用户账户信息表
create table account(
	`id` int not null primary key auto_increment, # id
    `uid` int not null,
    constraint `fk_accuid` foreign key(`uid`) references user(`id`), # user表外键
    `nickname` varchar(10) not null unique, # 昵称
	`address` varchar(30),# 地址
	`email` varchar(11) unique, # 邮箱
	`tel` varchar(11) unique,# 电话
    `introduce` text # 介绍
);

# 文章分类表
create table sort(
	`id` int not null primary key auto_increment,
    `name` varchar(10) not null, # 名称
    `defsort` boolean not null# 是否为默认分类
);

# 文章表
create table article(
	`id` int not null primary key auto_increment,
    `uid` int not null,
    constraint `fk_artuid` foreign key(`uid`) references user(`id`), # 发布用户id外键
    `title` varchar(90) not null,# 标题
    `publisht` datetime not null,# 发布时间
    `reviset` datetime not null,# 修改时间
    `browse` int default 0,# 浏览数
    `like` int not null default 0,# 点赞数
    `sortid` int not null,
    constraint `fk_sa` foreign key(`sortid`) references sort(`id`), # 分类表外键
    `label` varchar(100) not null,# 标签
    `content` text not null # 内容
);

# 评论表
create table comment(
	`id` int not null primary key auto_increment,
    `aid` int not null,
    constraint `fk_comaid` foreign key(`aid`) references article(`id`),# 评论文章外键
    `uid` int not null,
    constraint `fk_comuid` foreign key(`uid`) references user(`id`),# 评论用户id
    `time` datetime not null,# 评论时间
    `content` varchar(200) not null,# 评论内容
    `status` boolean not null default false # 评论状态
);



