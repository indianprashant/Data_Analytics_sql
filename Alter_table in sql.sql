create database sold;
use sold;

create table sales_Sold(
order_id varchar(15) not null,	
order_date varchar(15) not null,
ship_date varchar(15) not null,
ship_mode varchar(15) not null,
customer_name varchar(22) not null,
segment	varchar(20),
state varchar(15) not null,
country	varchar(20) not null,
market varchar(10) not null,
region	varchar(13) not null,
product_id	varchar(15) not null,
category varchar(15) not null,
sub_category varchar(15) not null,	
product_name varchar(20) not null,
sales decimal(35,0) not null,
quantity decimal(36,2) not null,
discount decimal(35,5) not null,
profit	decimal(38,8) not null,
shipping_cost decimal(38,2) not null,
order_priority	varchar(8) not null,
`year` decimal(38,0) not null
);

select * from sales_Sold;

set sql_mode ='';
load data infile
'C:/sales_data_final.csv'
into table sales_Sold
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows ;

select * from sales_Sold;

select str_to_date(order_date,'%m/%d/%y') from sales_Sold;
select str_to_date(order_date,'%m-%d-%y') from  sales_Sold;

alter table sales_Sold
add column order_date_new date after order_date;

update sales_Sold 
set order_date_new = str_to_date(order_date,'%m-%d-%Y');

alter table sales_Sold
add column ship_date_new date after ship_date ;

update sales_Sold
set ship_date_new = str_to_date(ship_date,'%m-%d-%Y');

select * from sales_Sold where ship_date_new = '2011-01-06';
select * from sales_Sold  where ship_date_new > '2011-01-06';
select count(*) from sales_Sold  where ship_date_new > '2011-01-06';
select * from sales_Sold where ship_date_new < '2011-01-06';
select count(*) from sales_Sold where ship_date_new < '2011-01-06';
select * from sales_Sold where ship_date_new between '2011-01-06' and '2011-08-30';
select distinct order_date,order_date_new from sales_Sold ;

select now();
select curdate();
select curtime();

select * from sales_Sold where ship_date_new > date_sub('2011-01-06',interval 1 week);

select date_sub(now(),interval 1 week);
select date_sub(now(),interval 30 day);
select date_sub(now(), interval 30 year);
select year(now());
select dayname(now());
select dayname('2024-08-12');

alter table sales_Sold
add column flag date after order_id;

update sales_Sold
set flag = now();

select * from sales_Sold;

alter table sales_Sold
add column year datetime;

alter table sales_Sold
add column year_new int;

alter table sales_Sold
add column month_new int;

alter table sales_Sold
add column Day_new int;

alter table sales_Sold modify column year_new int;
alter table sales_Sold modify column month_new int;
alter table sales_Sold modify column Day_new int;

update sales_Sold  set year_new = year(order_date_new);
update sales_Sold  set month_new = month(order_date_new);
update sales_Sold  set Day_new = day(order_date_new);

select * from sales_Sold;

select year_new,avg(sales) from sales_Sold group by year_new;
select year_new, sum(sales) from sales_Sold group by year_new;
select year_new, avg(sales),sum(sales),max(sales) from sales_Sold group by year_new;
select year_new , max(sales) from sales_Sold group by year_new ;
select year_new , min(sales) from sales_Sold group by year_new ;

 select year_new , sum(quantity) from sales_Sold group by year_new ;
 select (discount+ shipping_cost) as ctc from sales_Sold;
 select(sales*discount+shipping_cost)as ctc from sales_Sold;
 
 select order_id , discount , if(discount < 0 , 'yes' , 'no') as discount_flag from sales_Sold;
 
 alter table sales_Sold
modify column discount_flag varchar(20) after discount;
 
 update sales_Sold
 set discount_flag = if(discount < 0 , 'yes' , 'no');
 
 select * from sales_Sold;
 
 select discount_flag , count(*) from sales_Sold group by discount_flag;
 select count(*) from sales_Sold where discount < 2 ;
 
select profit , if(profit < 1, 'no' , 'yes') from sales_Sold;

alter table sales_Sold
modify column profit_new int after profit;
 
 update sales_Sold
 set profit_new = if(profit < 1 , 'no' , 'yes');
 
select 
 