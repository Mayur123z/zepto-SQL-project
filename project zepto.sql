select*from zepto

--data exploration 
select count(*) from zepto;


--sample data
select *  from zepto 
limit 10;


--null values
select * from zepto 
where name is null
or
category is null
or
mrp is null
or
discountpercent is null
or
discountedsellingprice is null
or
weightingms is null
or
availablequantity is null
or
outofstock is null
or
quantity is null;

--different product categories
select distinct category
from zepto
order by category;



--product in stock vs out of stock 
select outofstock, count(sku_id)
from zepto 
group by outofstock;


--product names present multiple times
select name, count(sku_id) as "number of SKUs"
from zepto
group by name
having count(sku_id)>1
order by count(sku_id) desc;


--data cleaning

--products with price = 0
select*from zepto
where mrp=0 or discountedsellingprice = 0;


--convert paise into rupees
update zepto
set mrp=mrp/100.0,
discountedsellingprice=discountedsellingprice/ 100.0;
select mrp, discountedsellingprice from zepto


--find best top 10 best value product based on the discounted percentage,
select distinct name, mrp, discountpercent
from zepto
order by discountpercent desc
limit 10;  


--what are the products with high mrp and out of stock
select distinct name , mrp
from zepto
where outofstock = true  and mrp > 300
order by mrp desc;



--cal estimated revennue for each category
select category,
sum(discountedsellingprice*availablequantity) as total_revenue
from zepto
group by category
order by total_revenue;



--find all products where mrp is greater then 500rs and discount is less then 10%
select distinct name, mrp, discountpercent
from zepto
where mrp>500 and discountpercent < 10 
order by mrp desc, discountpercent desc;



--find top 5 categories offering highest average discount percentage 
select category,
round (avg(discountpercent),2) as avg_discount
from zepto
group by category 
order by avg_discount desc 
limit 5;

--select price per gram for product above 100 g and sort by best value 
select distinct name, weightingms, discountedsellingprice,
round(discountedsellingprice/weightingms,2) as price_per_grams
from zepto
where weightingms >= 100
order by price_per_grams;


--group the products into categories like low, medium, bulk 
select distinct name, weightingms,
case when weightingms < 1000 then 'low'
     when weightingms < 5000 then 'medium'
	 else 'bulk'
	 end as weight_category 
from zepto;



--what is the total inventory weight as per category
select category,
sum(weightingms * availablequantity) as total_weight
from zepto
group by category 
order by total_Weight;



