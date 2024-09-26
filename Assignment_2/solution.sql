-------------Query 1---------------------
select "GenreID", count("GenreID") as ct into temp q1 from hasagenre
group by "GenreID"
order by "GenreID";
select * from q1;
drop table q1;
create table query1("name" text ,"moviescount" int);
insert into query1("name","moviescount")
select "Name",ct from genres
join q1
on genres."GenreID"=q1."GenreID";
select * from query1;
-------------Query 2---------------------
drop table if exists query2t cascade;
drop table if exists query2 cascade;

CREATE TABLE IF NOT EXISTS query2 ("name" text, "rating" numeric);
insert into query2 ("name","rating")
SELECT "Name", AVG(r.ratings) from genres g
INNER JOIN hasagenre h ON g."GenreID"=h."GenreID" 
INNER JOIN ratings r ON h."MovieID" = r."MovieID"
GROUP BY g."Name";
select*  from query2;

--------------Query 3--------------------
drop table if exists  query3 cascade;

select "MovieID",count("MovieID") as ct into temp query3t  from ratings 
--order by "MovieID"
group by "MovieID";

select * from query3t;
drop table query3;
create table query3("title" text,"countofratings" int);
insert into query3("title","countofratings")
select m."Title",q."ct" from movies m,query3t q
where "ct">=10;


select * from query3;
-----------------Query 4------------------
drop table q4;
select * into  temp q4 from hasagenre h
where h."GenreID"=5;
select * from q4;

create table query4("movieID" int,"Title" text);
insert into query4("movieID","Title")
select q."MovieID",m."Title" from q4 q
join movies m
on m."MovieID"=q."MovieID";

select *from query4;
-------Query 5----------------------------
CREATE TABLE IF NOT EXISTS query5 ("title" text, "rating" numeric);
insert into query5 ("title","rating")
SELECT "Title", AVG(r.ratings) from movies m
--INNER JOIN hasagenre h ON g."GenreID"=h."GenreID" 
INNER JOIN ratings r ON m."MovieID" = r."MovieID"
GROUP BY m."Title";
select*  from query5;
-------Query 6------------------------------
--
select h."MovieID" into q6 from hasagenre h
where h."GenreID"=5;
select * from q6;
create table if not exists query6 ("Title" text,"rating" numeric);
insert into query6("Title","rating")
select "Title",avg(r."ratings") from movies m
join q6 q on q."MovieID"=m."MovieID"
JOIN ratings r ON m."MovieID" = r."MovieID"
group by m."Title";

select * from query6;
-------------Query 7-------------------------------
drop table q7;
select h."MovieID" into q7 from hasagenre h
where h."GenreID"=5 or h."GenreID"=14;
select * from q7;
create table if not exists query7 ("Title" text,"rating" numeric);
insert into query7("Title","rating")
select "Title",avg(r."ratings") from movies m
join q7 q on q."MovieID"=m."MovieID"
JOIN ratings r ON m."MovieID" = r."MovieID"
group by m."Title";

select * from query7;
----------Query 8---------------------------------------
drop table q8;
select h."MovieID" into q8 from hasagenre h
where h."GenreID"=14;
select * from q8;
create table if not exists query8 ("Title" text,"rating" numeric);
insert into query8("Title","rating")
select "Title",avg(r."ratings") from movies m
join q8 q on q."MovieID"=m."MovieID"
JOIN ratings r ON m."MovieID" = r."MovieID"
group by m."Title";

select * from query8;
-------------Query 9-------------------------------------------
drop table query9;
create table query9("Username" text,"rating" numeric);
insert into query9("Username","rating")
select users."Name",ratings."ratings" from ratings
join users on users."UserID"=ratings."UserID"
where users."UserID"=4;

select * from query9;
---------------------------------------------------------------
