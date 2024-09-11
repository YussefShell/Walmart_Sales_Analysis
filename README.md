
# Walmart Sales Data Analysis

## About

This project aims to explore Walmart's sales data to understand the top-performing branches and products, sales trends of different products, and customer behavior. The goal is to study how sales strategies can be improved and optimized. The dataset was obtained from the [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting).

"In this recruiting competition, job-seekers are provided with historical sales data for 45 Walmart stores located in different regions. Each store contains many departments, and participants must project the sales for each department in each store. To add to the challenge, selected holiday markdown events are included in the dataset. These markdowns are known to affect sales, but it is challenging to predict which departments are affected and to what extent." [source](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting)

## Purpose of the Project

The main objective of this project is to gain insight into Walmart’s sales data to understand the different factors that affect sales across various branches.

## Data Overview

The dataset, obtained from the Kaggle Walmart Sales Forecasting Competition, contains sales transactions from three different Walmart branches located in Mandalay, Yangon, and Naypyitaw. The data includes 17 columns and 1,000 rows:

| Column                  | Description                             | Data Type      |
| :---------------------- | :-------------------------------------- | :------------- |
| invoice_id              | Invoice of the sales made               | VARCHAR(30)    |
| branch                  | Branch where sales were made            | VARCHAR(5)     |
| city                    | Location of the branch                  | VARCHAR(30)    |
| customer_type           | Type of customer                        | VARCHAR(30)    |
| gender                  | Customer gender                         | VARCHAR(10)    |
| product_line            | Product line of the sold product        | VARCHAR(100)   |
| unit_price              | Price of each product                   | DECIMAL(10, 2) |
| quantity                | Amount of product sold                  | INT            |
| VAT                     | Tax on the purchase                     | FLOAT(6, 4)    |
| total                   | Total cost of the purchase              | DECIMAL(10, 2) |
| date                    | Date of the purchase                    | DATE           |
| time                    | Time of the purchase                    | TIMESTAMP      |
| payment_method          | Payment method                          | VARCHAR(20)    |
| cogs                    | Cost of Goods Sold (COGS)               | DECIMAL(10, 2) |
| gross_margin_percentage | Gross margin percentage                 | FLOAT(11, 9)   |
| gross_income            | Gross Income                            | DECIMAL(10, 2) |
| rating                  | Customer rating                         | FLOAT(2, 1)    |

## Analysis List

1. **Product Analysis**
   - Analyze different product lines to identify top performers and areas for improvement.

2. **Sales Analysis**
   - Explore sales trends of products to evaluate the effectiveness of current sales strategies and recommend modifications to increase sales.

3. **Customer Analysis**
   - Segment customers to understand purchase patterns and profitability of each segment.

## Approach Used

1. **Data Wrangling**: The first step involves inspecting the data to ensure there are no **NULL** values or missing data. If any are found, appropriate methods are used to replace or filter out the missing data.
   - A database is built.
   - Tables are created, and the data is inserted.
   - **NOT NULL** constraints ensure there are no NULL values.

2. **Feature Engineering**: New columns are generated from existing ones to provide deeper insights.
   - A `time_of_day` column is added to categorize sales into Morning, Afternoon, and Evening.
   - A `day_name` column is added to extract the day of the week for each transaction.
   - A `month_name` column is added to extract the month of the year for each transaction.

3. **Exploratory Data Analysis (EDA)**: EDA is conducted to answer key business questions and provide insights.

## Business Questions to Answer

### General Questions

1. How many unique cities are in the data?
2. In which city is each branch located?

### Product Questions

1. How many unique product lines exist?
2. What is the most common payment method?
3. Which product line generates the most revenue?
4. What is the total revenue by month?
5. Which month had the largest COGS?
6. Which product line had the highest revenue?
7. Which city generates the most revenue?
8. Which product line has the largest VAT?
9. Identify "Good" or "Bad" product lines based on sales performance.
10. Which branch sold more products than the average number of products sold?
11. What is the most common product line by gender?
12. What is the average rating of each product line?

### Sales Questions

1. Number of sales made during different times of the day per weekday.
2. Which customer type generates the most revenue?
3. Which city has the highest tax percentage (VAT)?
4. Which customer type pays the most in VAT?

### Customer Questions

1. How many unique customer types are in the data?
2. How many unique payment methods are available?
3. What is the most common customer type?
4. Which customer type purchases the most?
5. What is the gender distribution of customers?
6. What is the gender distribution per branch?
7. What time of day do customers give the highest ratings?
8. Which day of the week has the best average ratings?

## Revenue and Profit Calculations

- **COGS** (Cost of Goods Sold) = `unit_price * quantity`
- **VAT** = `5% * COGS`

VAT is added to the COGS to determine the total amount billed to the customer.

- **Total (gross_sales)** = `VAT + COGS`
- **Gross Profit (gross_income)** = `total (gross_sales) - COGS`
- **Gross Margin Percentage** = `(gross_income / total revenue)`

### Example:

- **Unit Price** = 45.79
- **Quantity** = 7

   COGS = 45.79 * 7 = 320.53
   VAT = 5% * 320.53 = 16.0265
   Total = 320.53 + 16.0265 = 336.5565
   Gross Margin Percentage = 4.76%

## Code

For the complete code, check the [Walmart Sales Analysis GitHub repository](https://github.com/YussefShell/Walmart_Sales_Analysis/blob/main/Walmart_Sales_Sql.sql).
