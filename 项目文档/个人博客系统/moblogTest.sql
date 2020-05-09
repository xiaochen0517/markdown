# sql test


# 获取主页文章列表
select a.id,u.username,a.title,a.publisht,a.browse,a.like,s.name sort,a.label from (article a inner join `user` u on u.id = a.uid)
inner join sort s on s.id = a.sortid order by a.publisht desc limit 0, 10;

select * from article;

select * from `like`;

desc article;

select c.id,u.username,c.content,c.time from comment c
inner join user u on c.uid = u.id
where c.aid = 1 order by c.time desc limit 0, 10;

select a.id,u.nickname,a.title,a.publisht,a.browse,ifnull(al.`like`, 0) `like`,s.name sort,a.label from article a 
left join account u on u.uid = a.uid
left join (select count(`like`.id) `like`, article.id id from article, `like` where `like`.aid = article.id) al on a.id = al.id
left join sort s on s.id = a.sortid 
order by a.publisht desc limit 0, 10;



--     `uid` int not null,
--     `title` varchar(90) not null,# 标题
--     `publisht` datetime not null,# 发布时间
--     `reviset` datetime not null,# 修改时间
--     `sortid` int not null,
--     `label` varchar(100) not null,# 标签
--     `content` text not null # 内容

insert into article (uid, title, publisht, reviset, sortid, label, content) 
values
();


ALTER TABLE `sort`
-- ADD `uid` int not null after `id`;
add constraint `fk_sortuid` foreign key(`uid`) references user(`id`) after `uid`;

desc sort;

truncate table comment;

desc homephoto;

alter table homephoto modify column link varchar(1000) not null;

alter table articlephoto modify column link varchar(1000) not null;

alter table account modify column email varchar(100) not null;




