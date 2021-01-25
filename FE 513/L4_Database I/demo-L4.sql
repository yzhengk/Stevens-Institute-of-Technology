/********
L4- Database Session I
Author: Xingjia Zhang
Content: 
 1. create table, alter drop table, insert data into table
 2. select query
 3. filtering data
 4. grouping data

**********/

/********* create/drop database *****/
create database test;

drop database if exists test;# check existence of the database before dropping
-- if see error:unable to drop database because of some auto connections to DB, run the following query first, then drop database. 
REVOKE CONNECT ON DATABASE dbtest FROM public;
SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = 'dbtest';

/************* create table *****************/

create table branch2(branch_name varchar(30), branch_city varchar(30), assets integer)
create table branch(branch_name varchar(30) not null, branch_city varchar(15),assets integer); -- add constraints: not null


drop table if exists branch 
alter table branch2 add branch_zipcode char(6)
alter table branch2 drop branch_zipcode

create table branch(branch_name char(30) not null,branch_city char(15),assets integer);
insert into branch(branch_name,branch_city,assets) values ('Bank of America', 'Los Angeles',3000);
insert into branch(branch_name,branch_city,assets) values ('JPMorgan Chase', 'New York',1400);
insert into branch(branch_name,branch_city,assets) values ('Wells Fargo', 'Orlando',2100);

insert into branch(branch_name,branch_city,assets)values ('Bank of America', 'Los Angeles',3000),('JPMorgan Chase', 'New York',1400), ('Wells Fargo', 'Orlando',2100);

/******* load data **********/
drop table if exists address;
CREATE TABLE address (
    address_id integer NOT NULL,
    address character varying(50) NOT NULL,
    address2 character varying(50),
    district character varying(20) NOT NULL,
    city_id smallint NOT NULL,
    postal_code character varying(10),
    phone character varying(20) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);

-- \COPY address (address_id, address, address2, district, city_id, postal_code, phone, last_update) FROM '$$PATH$$/2171.dat'; // type this line in console

/****** select query *****/
select * from address--select all from address
select address,city_id, phone from address--select specific columns
select address, city_id from address order by city_id -- order results by city_id
select * from address where city_id>400 -- filter rows 
select address, city_id from address where city_id>400 and EXTRACT(month FROM last_update)=2  --  use "and" operator to add more filters in where expression
select distinct address from address where city_id>400 and EXTRACT(month FROM last_update)=2 -- use "distinct" to remove duplicate rows
select city_id from address order by city_id desc limit 10 -- limit number of rows in output
select phone,city_id,last_update from address where city_id in (300,400,500,600) 
select phone, city_id from address where city_id  between 300 and 400
select * from address where phone like '38%'
select * from address where phone  like '_8%'

/************ grouping data ***********/
select count(*) as cnt from address -- rename selcted column with "as"
select count(*) as cnt, city_id from address group by city_id order by cnt desc  
select count(*) as cnt, city_id from address group by city_id having city_id>300 order by cnt desc -- select records with city_id larger than 300 -method1
select count(*) as cnt, city_id from address where city_id>300 group by city_id order by cnt desc -- select records with city_id larger than 300 -method2
select count(*), city_id from address group by city_id having count(*)>1 -- select records with same city_id

