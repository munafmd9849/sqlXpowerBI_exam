create database Exam_sql;
use Exam_sql;
select * from customer_data;
select * from product_data;	
select * from targets;
select * from sales_data_2;


# Total Sales and Profit by Region for 2022

select  region, sum(sales_amount) Sales,sum(profit) Profit
from sales_data_2 s
where year(OrderDate)=2022
group by region;

## Top 5 customers based on total purchase

select s.customerId ,CustomerName,sum(Unit_Cost_Price) as purchases from sales_data_2 s
left join customer_data cd
on s.customerId=cd.customerId
left join product_data p
on s.productId=p.productId
group by s.customerId,CustomerName
order by purchases desc
limit 5;


## Products with >20% discount but positive profit

select s.productId ,ProductName as `profitableProducts>20%dis` from sales_data_2 s
join product_data p
on s.productId=p.productId
where `Discount (%)`>20 and profit>0;




#3Region-wise average discount

select region, avg(`Discount (%)`) as avgDiscount from sales_data_2
group by region
;


## Year-wise sales growth %
## a.
## current - last - intial /100

select year(OrderDate) as currentYear,(sum(Sales_Amount)-(select sum(Sales_Amount) from sales_data_2
where year(OrderDate)=currentYear-1)-(select sum(Sales_Amount) from sales_data_2
where year(OrderDate)=2020))/100 as yearwisegrowth
from sales_data_2
group by year(OrderDate)
order by year(OrderDate) desc;
 
# b
## current - last/100
select year(OrderDate) as currentYear,(sum(Sales_Amount)-(select sum(Sales_Amount) from sales_data_2
where year(OrderDate)=currentYear-1))/100 as yearwisegrowth
from sales_data_2
group by year(OrderDate)
order by year(OrderDate) desc;




select * from customer_data;
select * from product_data;	
select * from targets;
select * from sales_data_2;


#Product category with highest profit margin

select Category, (Sales_Amount-Profit)/100 heighestProfitMargin
from product_data p
join  sales_data_2 s
on s.ProductID=p.ProductID
order by heighestProfitMargin desc
limit 1;


#AOV per customer segment

select customerName,avg(Unit_Cost_Price) AOV
from customer_data c
join sales_data_2 s
on c.customerId=s.customerId
join product_data p
on p.productId=s.productId
group by customerName;


#Top 3 products with continuous yearly sales growth

select productName as currentYear,(sum(Sales_Amount)-(select sum(Sales_Amount) from sales_data_2
where year(OrderDate)=currentYear-1)-(select sum(Sales_Amount) from sales_data_2
where year(OrderDate)=2020))/100 as yearwisegrowth
from sales_data_2 
join product_data
on sales_data_2.productId=product_data.productId
group by year(OrderDate)
order by year(OrderDate) desc;