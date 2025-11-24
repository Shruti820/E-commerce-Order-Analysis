USE office;
SELECT * FROM esd_project;

-- Top 5 highest-selling products.
SELECT Product_Name,
SUM(Sales) AS Total_SAles
FROM esd_project
GROUP BY Product_Name
ORDER BY Total_Sales DESC
LIMIT 5;

-- Monthly revenue trends.
SELECT date_format(STR_TO_DATE(Order_Date,'%d-%m-%Y'),'%Y-%m') AS month,
SUM(Sales) AS monthly_revenue
FROM esd_project
GROUP BY date_format(STR_TO_DATE(Order_Date,'%d-%m-%Y'),'%Y-%m')
ORDER BY month;

-- Average order value per customer.
SELECT Customer_Name,
SUM(Sales)/COUNT(DISTINCT Order_ID) AS avg_order_value
FROM esd_project
GROUP BY Customer_Name
ORDER BY avg_order_value DESC;

-- Best-performing product categories.
SELECT Category,
SUM(Sales) AS Total_Sales
FROM esd_project
GROUP BY Category
ORDER BY Total_Sales DESC;

-- Identify repeat customers.
SELECT Customer_Name,
COUNT(DISTINCT Order_ID) AS Total_Orders
FROM esd_project
GROUP BY Customer_Name
HAVING COUNT(DISTINCT Order_ID)>1
ORDER BY Total_Orders DESC;

-- Peak order days/times.
SELECT Order_Date,
COUNT(*) AS Total_Orders
FROM esd_project
GROUP BY Order_Date
ORDER BY Total_Orders DESC;

-- Rank products by total sales and units sold.
SELECT Product_Name,
SUM(Sales) AS total_sales,
SUM(Quantity) AS total_units_sold,
RANK() OVER (ORDER BY SUM(Sales) DESC) AS sales_rank,
RANK() OVER (ORDER BY SUM(Quantity) DESC) AS units_rank
FROM esd_project
GROUP BY Product_Name
ORDER BY total_sales DESC;