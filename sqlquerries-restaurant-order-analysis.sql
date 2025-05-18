use restaurant_db;

-- Exploring the Menu Table

-- 1. View Menu Items table 
Select * From menu_items;

-- 2. Find the number of items from the menu
select count(*) from menu_items;

-- 3. What are the least and most expensive items on the menu
select * from menu_items 
Order by price;

select * from menu_items
order by price desc;

-- 4. How many Asian Dishes are on the menu
select count(*) from menu_items 
Where category = "Asian";

-- 5. What are most and least expensive Asian dishes on the menu
select * from menu_items 
Where category = "Asian"
order by price;

select * from menu_items 
Where category = "Asian"
order by price desc;

-- 6. How many dishes are in each category?
Select category, count(menu_item_id) as num_dishes
from menu_items
group by category;

-- 7. What is the average price in each dish category
select category, avg(price) as avg_dish_price
from menu_items
group by category;

-- Exploring the Orders Table

-- 1. View Orders table
Select * from order_details;

-- 2. What is the date range of the table?
Select * from order_details
order by order_date;

-- 3. What is oldest and newest order date?
select min(order_date), max(order_date) from order_details;

-- 4. How many order were made within this date range?
select count(distinct order_id) from order_details;

-- 5. How many items were ordered within this date range?
select count(*) from order_details;

-- 6. Which orders had the most number of items?
select order_id, count(item_id) as num_orders
from order_details
group by order_id
order by num_orders desc;

-- 7. How many orders had more than 12 items?
select count(*) from
(select order_id, count(item_id) as num_orders
from order_details
group by order_id
having num_orders > 12) as orders_12andabove;

-- New Objectives

-- 1. Combine Menu Items and Order Details table in to one single table
select * from order_details od
left join menu_items mi
on od.item_id = mi.menu_item_id;

select * from order_details od
Inner join menu_items mi
on od.item_id = mi.menu_item_id;

-- 2. What were the least and most ordered items? What categories where they in?
select item_name, count(order_details_id) as num_purchases 
from order_details od
left join menu_items mi
on od.item_id = mi.menu_item_id
group by item_name
order by num_purchases;

select item_name, count(order_details_id) as num_purchases 
from order_details od
left join menu_items mi
on od.item_id = mi.menu_item_id
group by item_name
order by num_purchases desc;

select item_name, category, count(order_details_id) as num_purchases 
from order_details od
left join menu_items mi
on od.item_id = mi.menu_item_id
group by item_name, category
order by num_purchases desc;

-- 3. What were the top 5 orders that spent the most money?
select order_id, sum(price) as total_spend
from order_details od
left join menu_items mi
on od.item_id = mi.menu_item_id
Group by order_id
order by total_spend desc limit 5;

-- 4. View the Details of the highest spend order. What insights can you gather from the same?
select category, count(item_id) as num_items
from order_details od
left join menu_items mi
on od.item_id = mi.menu_item_id
Where order_id = 440
group by category;

-- 5. View the details of top 5 highest spend orders. What insights can you gather from the same?
select category, count(item_id) as num_items
from order_details od
left join menu_items mi
on od.item_id = mi.menu_item_id
Where order_id in (440, 2075, 1957, 330, 2675)
group by category;

select order_id, category, count(item_id) as num_items
from order_details od
left join menu_items mi
on od.item_id = mi.menu_item_id
Where order_id in (440, 2075, 1957, 330, 2675)
group by order_id, category;


