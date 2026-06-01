create database retailpulse_db;

use retailpulse_db;

create table orders(
row_id int,
order_id varchar(50),
order_date date,
ship_date date,
ship_mode varchar(50),
customer_id varchar(50),
customer_name varchar(50),
segment varchar(50),
country varchar(50),
city varchar(50),
state varchar(50),
postal_code varchar(50),
region varchar(50),
product_id varchar(50),
category varchar(50),
sub_category varchar(50),
product_name text,
sales decimal(10,2),

order_year int,
order_month int,
order_month_name varchar(50),
order_quarter int,
shipping_date date,
profit_margin decimal(10,2),
profit_status varchar(10),
sales_category varchar(50),
discount_level varchar(50)
);
alter table orders
add column discount decimal(10,2),
add column profit decimal(10,2);
alter table orders 
add column quantity int;
alter table orders 
add column order_quarter int;

describe orders;

select * from orders
limit 10;

select count(*) as total_orders from orders;

#total sales 
select round(sum(sales),2) as total_sales from orders;

#total profit 
select round(sum(profit),2) as total_profit from orders;

#total orders 
select count(distinct order_id) as total_orders from orders ;

#total customers 
select count(distinct customer_id ) as total_customers from orders;

#sales by region 
select region,round(sum(sales),2) as total_sales from orders
group by region
order by total_sales desc;

#profit by category 
select category ,round(sum(profit),2) as profit from orders
group by category 
order by profit desc;

#sales by segment 
select segment,round(sum(sales),2) as total_sales from orders 
group by segment 
order by total_sales desc;

#top 10 customers by sales 
select customer_name , round(sum(sales),2) as total_sales from orders
group by customer_name
order by total_sales desc
limit 10;

#top 10 products by sales
select product_name,round(sum(sales),2) as total_sales from orders 
group by product_name
order by total_sales desc
limit 10;

#top 10 loss making products 
select product_name ,sum(sales) as total_sales from orders 
group by product_name
order by total_sales asc
limit 10;

#monthly sales trend
select order_year,order_month,round(sum(sales),2) as total_sales from orders 
group by order_year,order_month
order by order_year,order_month;

#discount impact on profit 
select discount,round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_profit,
round(avg(discount),2) as avg_discount from orders 
group by discount
order by total_profit desc;

#profit by region
select region ,round(sum(profit),2) as total_profit from orders
group by region
order by total_profit desc;

#profit margin by region
select region,round(sum(profit),2) as total_profit,
round(sum(sales),2) as total_sales,
round((sum(profit)/sum(sales))*100,2) as profit_margin_percent
from orders
group by region
order by profit_margin_percent desc;

#category and sub_category performance 
select category,sub_category ,
round(sum(profit),2) as total_profit,
round(sum(sales),2) as total_sales,
round((sum(profit)/sum(sales))*100,2) as profit_margin_percent
from orders 
group by category ,sub_category 
order by profit_margin_percent desc;

#shipping mode performance
select ship_mode,
count(distinct order_id ) as total_orders,
round(sum(sales),2) as total_sales ,
round(sum(profit),2) as total_profit,
round(avg(shipping_date),2) as avg_shipping_date
from orders 
group by ship_mode 
order by total_sales desc;


alter table orders
drop column discount_level;
