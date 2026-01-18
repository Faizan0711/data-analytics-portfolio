-- Q1: Executive Summary KPIs
-- Total Orders, Revenue, Profit, Profit Margin

SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM sales;

-- Q2: Monthly Revenue Trend

SELECT
    strftime('%Y-%m', order_date) AS year_month,
    ROUND(SUM(sales), 2) AS monthly_revenue
FROM sales
GROUP BY year_month
ORDER BY year_month;


-- Q3: Revenue by Category and Subcategory

SELECT
    category,
    subcategory,
    ROUND(SUM(sales), 2) AS total_revenue
FROM sales
GROUP BY category, subcategory
ORDER BY total_revenue DESC;

-- Revenue and Profit by Category and Subcategory

SELECT
    category,
    subcategory,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM sales
GROUP BY category, subcategory
ORDER BY total_revenue DESC;

--  Q4: Top 10 Products by Revenue and Profit

SELECT
    product_name,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit
FROM sales
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 10;
-- Q5: Average Discount by Category (NULL-safe)

SELECT
    category,
    ROUND(AVG(COALESCE(discount_pct, 0)), 2) AS avg_discount_pct
FROM sales
GROUP BY category
ORDER BY avg_discount_pct DESC;

-- Q6: Region Performance (Revenue, Profit, Profit Margin)

SELECT
    region,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        CASE 
            WHEN SUM(sales) = 0 THEN 0
            ELSE (SUM(profit) / SUM(sales)) * 100
        END,
    2) AS profit_margin_pct
FROM sales
GROUP BY region
ORDER BY total_revenue DESC;
-- Q7: Average Shipping Time by Region

SELECT
    region,
    ROUND(AVG(julianday(ship_date) - julianday(order_date)), 2) AS avg_shipping_days
FROM sales
GROUP BY region
ORDER BY avg_shipping_days;
