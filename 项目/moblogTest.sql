# sql test


# 获取主页文章列表
select a.id,u.username,a.title,a.publisht,a.browse,a.like,s.name sort,a.label from (article a inner join `user` u on u.id = a.uid)
inner join sort s on s.id = a.sortid order by a.publisht desc limit 0, 10;

select * from article;

desc article;