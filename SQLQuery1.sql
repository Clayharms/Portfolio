-- I need to write an SQL script that generates
-- the order id, customer first and last name, city,
-- state, the order date, sales volume, revenue,
-- product name, product category, brand name, 
-- store name and sales rep. These are scattered among 9 tables
-- I will need to use joins to get this data organized.
SELECT 
	ord.order_id,
	CONCAT(cus.first_name, ' ', cus.last_name) AS 'customers',
	cus.city,
	cus.state,
	ord.order_date,
	SUM(ite.quantity) AS 'total_units',
	SUM(ite.quantity * ite.list_price) AS 'revenue',
	pro.product_name,
	cat.category_name,
	prob.brand_name,
	sto.store_name,
	CONCAT(sta.first_name, ' ', sta.last_name) AS 'sales_rep'
FROM sales.orders ord
JOIN sales.customers cus
ON ord.customer_id = cus.customer_id
JOIN sales.order_items ite
ON ord.order_id = ite.order_id
JOIN production.products pro
ON ite.product_id = pro.product_id
JOIN production.categories cat
ON pro.category_id = cat.category_id
JOIN sales.stores sto
ON ord.store_id = sto.store_id
JOIN sales.staffs sta
ON ord.staff_id = sta.staff_id
JOIN production.brands prob
ON pro.brand_id = prob.brand_id
-- because I now have two functions in the SELECT clause,
-- I need to group the other fields in order for the script to work
GROUP BY 
	ord.order_id,
	CONCAT(cus.first_name, ' ', cus.last_name),
	cus.city,
	cus.state,
	ord.order_date,
	pro.product_name,
	cat.category_name,
	prob.brand_name,
	sto.store_name,
	CONCAT(sta.first_name, ' ', sta.last_name)