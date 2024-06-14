-- Data cleaning 
SELECT * FROM sales;

-- Add the time_of_day column if it does not exist
IF NOT EXISTS (SELECT * FROM sys.columns WHERE name = 'time_of_day' AND object_id = OBJECT_ID('sales'))
BEGIN
    ALTER TABLE sales ADD time_of_day VARCHAR(20);
END;

-- Add day_name column if it does not exist
IF NOT EXISTS (SELECT * FROM sys.columns WHERE name = 'day_name' AND object_id = OBJECT_ID('sales'))
BEGIN
    ALTER TABLE sales ADD day_name VARCHAR(10);
END;

-- Add month_name column if it does not exist
IF NOT EXISTS (SELECT * FROM sys.columns WHERE name = 'month_name' AND object_id = OBJECT_ID('sales'))
BEGIN
    ALTER TABLE sales ADD month_name VARCHAR(10);
END;

-- Ensure the columns are created before running the updates
GO

-- Update the new columns with appropriate values
UPDATE sales
SET 
    time_of_day = CASE
        WHEN CAST([time] AS TIME) BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
        WHEN CAST([time] AS TIME) BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
        ELSE 'Evening'
    END,
    day_name = DATENAME(WEEKDAY, [date]),
    month_name = DATENAME(MONTH, [date]);

-- Generic queries

-- How many unique cities does the data have?
SELECT DISTINCT city FROM sales;

-- In which city is each branch?
SELECT DISTINCT city, branch FROM sales;

-- Product queries

-- How many unique product lines does the data have?
SELECT DISTINCT product_line FROM sales;

-- What is the most selling product line?
SELECT
    SUM(quantity) AS qty,
    product_line
FROM sales
GROUP BY product_line
ORDER BY qty DESC;

-- What is the total revenue by month?
SELECT
    month_name AS month,
    SUM(total) AS total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue;

-- What month had the largest COGS?
SELECT
    month_name AS month,
    SUM(cogs) AS cogs
FROM sales
GROUP BY month_name
ORDER BY cogs DESC;

-- What product line had the largest revenue?
SELECT
    product_line,
    SUM(total) AS total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue?
SELECT
    branch,
    city,
    SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch
ORDER BY total_revenue;

-- What product line had the largest VAT?
SELECT
    product_line,
    AVG(Tax_5) AS avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

-- Fetch each product line and add a column to those product 
-- line showing "Good", "Bad". Good if its greater than average sales

-- First calculate the average quantity
DECLARE @avg_quantity FLOAT;
SELECT @avg_quantity = AVG(quantity) FROM sales;

-- Then classify each product line
SELECT
    product_line,
    CASE
        WHEN AVG(quantity) > @avg_quantity THEN 'Good'
        ELSE 'Bad'
    END AS remark
FROM sales
GROUP BY product_line;

-- Which branch sold more products than average product sold?
SELECT 
    branch, 
    SUM(quantity) AS qnty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- What is the most common product line by gender?
SELECT
    gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- What is the average rating of each product line?
SELECT
    ROUND(AVG(rating), 2) AS avg_rating,
    product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- Customer queries

-- How many unique customer types does the data have?
SELECT DISTINCT customer_type FROM sales;

-- How many unique payment methods does the data have?
SELECT DISTINCT payment FROM sales;

-- What is the most common customer type?
SELECT
    customer_type,
    COUNT(*) AS count
FROM sales
GROUP BY customer_type
ORDER BY count DESC;

-- Which customer type buys the most?
SELECT
    customer_type,
    COUNT(*)
FROM sales
GROUP BY customer_type;

-- What is the gender of most of the customers?
SELECT
    gender,
    COUNT(*) AS gender_cnt
FROM sales
GROUP BY gender
ORDER BY gender_cnt DESC;

-- What is the gender distribution per branch?
SELECT
    gender,
    COUNT(*) AS gender_cnt
FROM sales
WHERE branch = 'C'
GROUP BY gender
ORDER BY gender_cnt DESC;

-- Which time of the day do customers give most ratings?
SELECT
    time_of_day,
    AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which time of the day do customers give most ratings per branch?
SELECT
    time_of_day,
    AVG(rating) AS avg_rating
FROM sales
WHERE branch = 'A'
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which day of the week has the best avg ratings?
SELECT
    day_name,
    AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating DESC;

-- Which day of the week has the best average ratings per branch?
SELECT 
    day_name,
    COUNT(day_name) AS total_sales
FROM sales
WHERE branch = 'C'
GROUP BY day_name
ORDER BY total_sales DESC;

-- Sales queries

-- Number of sales made in each time of the day per weekday
SELECT
    time_of_day,
    COUNT(*) AS total_sales
FROM sales
WHERE day_name = 'Sunday'
GROUP BY time_of_day
ORDER BY total_sales DESC;

-- Which of the customer types brings the most revenue?
SELECT
    customer_type,
    SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue DESC;

-- Which city has the largest tax/VAT percent?
SELECT
    city,
    ROUND(AVG(Tax_5), 2) AS avg_tax_pct
FROM sales
GROUP BY city
ORDER BY avg_tax_pct DESC;

-- Which customer type pays the most in VAT?
SELECT
    customer_type,
    AVG(Tax_5) AS total_tax
FROM sales
GROUP BY customer_type
ORDER BY total_tax DESC;
