use project;
create table zepto_1(
sku_id int Primary key auto_increment,
Category varchar(150) ,
Namess varchar(140), 
mrp int,
discountPercent int , 
availableQuantity int, 
discountedSellingPrice int , 
weightInGms int , 
outOfStcok varchar(20) , 
quantity int);


select * from zepto_1 where 
sku_id is null 
or
Category is null
or 
Namess is null 
or 
mrp is null 
or 
discountpercent is null 
or 
availableQuantity is null 
or 
discountedSellingPrice is null 
or 
weightInGms is null 
or 
outOfStcok is null 
or 
quantity is null ;

-- there are no null values in the data 
-- now check how many type of unique values do we have in the data 
select distinct(Category) 
from zepto_1
order by category;
-- there are 6 distinct category in the dataset 
-- Fruits & Vegetables, Cooking Essentials, Munchies, Dairy, Bread & Batter, Beverages, Packaged Food

-- Products in stock and product in out of stock  category wise
select  category ,outofstcok, count(*) as no_of_products from zepto_1
group by category , outofstcok;

-- Product names present multiple times under different packaging and different sizes  
select Namess , count(sku_id) as 'No. of products'  from zepto_1 
group by Namess 
having count(sku_id) > 1 
order by count(sku_id) desc ;

-- Data Cleaning 
-- products with price 0 
select * from zepto_1 where mrp = 0 ;
-- there are no zero values in the data 

-- the mrp is in paise we will convert it in rupees 
update zepto_1 
set mrp = mrp/100,
discountedSellingPrice = discountedSellingPrice/100 ;

-- Q1. Find the top 10 best- value products based on the discount percentage 
select Distinct Namess , mrp , discountPercent from zepto_1
order by discountPercent desc limit 10 ;
-- These insight is helpful to know the top products with the most discount which will help to 
-- understand that these products listed either might be margin products or it might be the products that 
-- have less sell or the day it had listed there might a sale going on. These will need another data 
-- to categorize products and perform analysis like sales in which we can know how the product is performing and if sale is less
-- then we can categorize product with low selling etc.

-- Q2. what are the products with high Mrp but out of stock top 10 
select Namess , mrp , outOfStcok, discountPercent from zepto_1
where outOfStcok = 'True'
order by mrp desc limit 10; 
-- These insight is helping just for knowing the products with high mrp are out of stock which
-- tells that demands exceed supply for premium item a restocking priority signal for the 
-- procurement team . Just out of 
-- curiosity i tried to understand by looking that is the outofstock of the product is beacause of the 
-- discountpercent but looking at it is not helping i need to find relation between them. 
   
-- Q3. Calculate the estimated revenue for each category 
select category , sum(discountedSellingPrice * availableQuantity) as revenue from zepto_1 
group by category 
order by revenue desc ;
-- these insight is useful for the marketing team to know the category which will be generating most revenue 
-- and lowest revenue and based on these they can run the campaigns or adds more on the lowest revenue in that 
-- region. 
 
-- Q4. Find all products where mrp > 500 and discount < 10 percent 
select distinct Namess , mrp , discountPercent from zepto_1 
where mrp > 500 and discountPercent < 10 
order by mrp Desc, discountPercent Desc;
-- These table insight is helping us to analyze the that most of the high mrp products with less discount 
-- are the products like oil, ghee and nan pro type which are high in sales low in margin and we cannot 
-- keep these products too much longer on the shelf as these will get ruined these insight will help the 
-- sales team which will know the high value product that might get stock out easily 

-- Q5. Identify the top 5 categories which gives the best average discount percentage 
select category ,round(avg(discountPercent),2) as disc_perc from zepto_1
group by category  
order by disc_perc desc  ;
--  These insight is help us to know that the fruits & vegetables are giving the highes discount as
-- the vegetables and fruits have higher margins and there shelf life is very less 

-- Q6. Find the price per gram for products above 100 g and sort the best value. 
select Distinct Namess , round(discountedSellingPrice/weightInGms,2) as price_per_gram  from zepto_1 
where weightInGms >= 100 
order by price_per_gram desc;

-- Q7. Group the products into the categories like Low, Medium , Bulk 
select Namess ,weightInGms 
,case when weightInGms <1000 then 'Low'
when weightInGms < 5000 then 'Medium'
Else'High'
end as weight_category 
from zepto_1 ; 
-- these insight help the store manager for sorting out the low, medium and high categories of the
-- products which help them in sotring efficiently. 

-- Q8. What is the Total Inventory weight for Category 
select category , sum(weightInGms * availableQuantity) as 'Total_Inventory_Weight' from zepto_1 
group by category 
order by Total_Inventory_Weight desc; 
-- these insight is alos helpful for the store mangaer for efficiently storing the products 

-- Q9. Which are products with the highest discountPercent in each category 
with ranked_data as (
select category ,
namess , 
dense_rank() over(partition by category order by discountPercent desc) as Rank_per_cat_na, 
discountPercent from zepto_1
)
select * from ranked_data where Rank_per_cat_na = 1 or Rank_per_cat_na = 2 or Rank_per_cat_na = 3 ; 
-- these insight help in understanding which company products have been giving the highest discount 
-- and each category products with the highest discountPercent. 


-- Ranking each category products based on there revneue help in understanding the 
with category_t as (
select category,Namess ,
sum(discountedSellingPrice * availableQuantity) as revenue from zepto_1 
group by category , Namess
order by revenue desc  
)
select *, dense_rank() over(partition by category order by revenue desc) as rank_revenue 
from category_t;

