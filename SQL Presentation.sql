-- To extract actionable insights from U.S_e-commerce transaction data to understand sales performance, customer behavior,transaction success rate.

SELECT * 
FROM `us_e-commerce`;

-- OBJECTIVE 1: Track Sales Trends Over Time

-- Monthly Sales Trend
SELECT 
    FORMAT(Date, 'yyyy-MM') AS Month,
    SUM(Amount_US$) AS Total_Sales
FROM `us_e-commerce`
GROUP BY FORMAT(Date, 'yyyy-MM')
ORDER BY  Month;

-- Monthly Sales Trend by Delivery Type
SELECT 
    FORMAT(Date, 'yyyy-MM') AS Month,
    Delivery_Type,
    SUM(Amount_US$) AS Monthly_Sales
FROM `us_e-commerce`
GROUP BY FORMAT(Date, 'yyyy-MM'), Delivery_Type
ORDER BY Month, Delivery_Type;

-- Sales  by Gender, Device & Delivery
SELECT Gender, Device_Type, Delivery_Type,
    SUM(Amount_US$) AS Total_Sales
FROM `us_e-commerce`
GROUP BY Gender, Device_Type, Delivery_Type
ORDER BY Total_Sales DESC;

-- OBJECTIVE 2: Identify Top-Performing Products, Categories, and Regions

-- Categories and Products that generate the highest sales revenue
SELECT 
Category,Product,
    SUM(Amount_US$) AS Sales
FROM `us_e-commerce`
GROUP BY Category, Product
ORDER BY Sales DESC;

-- Which city contribute most to total sales
SELECT City,
    SUM(Amount_US$) AS Total_Sales
FROM `us_e-commerce`
GROUP BY City
ORDER BY Total_Sales DESC;

-- Understand Customer Segment(customer login type) Behavior and Regional Preferences

-- Customer segments with highest purchase and generate the most sales
SELECT Customer_Login_type,
    SUM(Amount_US$) AS Total_Sales
FROM `us_e-commerce`
GROUP BY Customer_Login_type
ORDER BY Total_Sales DESC;

-- How do buying patterns vary across regions and time
SELECT 
    FORMAT(Date, 'yyyy-MM') AS Month,
    City,
    SUM(Amount_US$) AS Monthly_Sales
FROM `us_e-commerce`
GROUP BY FORMAT(Date, 'yyyy-MM'), City
ORDER BY Month,City;

-- Customer Segment  Purchase Performance by Region
SELECT City, Customer_Login_type,
    SUM(Amount_US$) AS Regional_Sales
FROM `us_e-commerce`
GROUP BY City, Customer_Login_type
ORDER BY City, Regional_Sales DESC;

-- Top Customer Segments by Device, Gender & Delivery
SELECT Customer_Login_type, Gender, Device_Type, Delivery_Type,
    SUM(Amount_US$) AS  Customer_Segment_Sales
FROM `us_e-commerce`
GROUP BY Customer_Login_type, Delivery_Type, Device_Type, Gender
ORDER BY Customer_Segment_Sales DESC;


-- OBJECTIVE 4: Analyze Transaction Success vs Failure

-- Count of Successful vs Failed Transactions
SELECT Transaction_Result,
    COUNT(*) AS Transaction_Count
FROM `us_e-commerce`
WHERE `Transaction Start` = 1
GROUP BY Transaction_Result;
-- note that 0 for transaction results means failed transactions while 1 means successful transaction

-- Transaction Success Rate
SELECT 
    COUNT(CASE WHEN Transaction_Result= 1 THEN 1 END) * 1.0 / COUNT(*) AS Success_Rate
FROM `us_e-commerce`
WHERE `Transaction Start` = 1;

-- Success Rate by City
SELECT City,
    COUNT(CASE WHEN Transaction_Result = 1 THEN 1 END) * 1.0 / COUNT(*) AS Regional_Success_Rate
FROM `us_e-commerce`
WHERE `Transaction Start` = 1
GROUP BY City
ORDER BY Regional_Success_Rate DESC;

-- Transaction Success Rate by Delivery Type
SELECT Delivery_Type,
    COUNT(CASE WHEN Transaction_Result = 1 THEN 1 END) * 1.0 /
    COUNT(*) AS Success_Rate
FROM `us_e-commerce`
WHERE `Transaction Start` = 1
GROUP BY Delivery_Type
ORDER BY Success_Rate DESC;

-- Transaction Success Rate by Gender and Device
SELECT Gender, Device_Type,
    COUNT(CASE WHEN Transaction_Result = 1 THEN 1 END) * 1.0 /
    COUNT(*) AS Success_Rate
FROM `us_e-commerce`
WHERE `Transaction Start` = 1
GROUP BY Gender, Device_Type
ORDER BY Success_Rate DESC;

-- Failed Transactions by Delivery Type
SELECT Delivery_Type,
    COUNT(*) AS Failed_Transactions
FROM `us_e-commerce`
WHERE Transaction_Result = 0
GROUP BY Delivery_Type
ORDER BY Failed_Transactions DESC;

-- OBJECTIVE 5: Quantify Sales Revenue Impact of Failed Transactions

-- Total Sales_Revenue Lost to Failed Transactions
SELECT 
    SUM(Amount_US$) AS Lost_Sales_Revenue
FROM `us_e-commerce`
WHERE Transaction_Result = 0;

-- Failed Transactions by  Customer Segment
SELECT Customer_Login_type,   
    COUNT(*) AS Failed_Transactions
FROM `us_e-commerce`
WHERE Transaction_Result = 0
GROUP BY Customer_Login_type
ORDER BY Failed_Transactions DESC;

-- Failed Transaction by Product & Category
SELECT Product, Category,
    SUM(Amount_US$) AS Failed_Transaction_Sales
FROM `us_e-commerce`
WHERE Transaction_Result = 0
GROUP BY Product, Category
ORDER BY Failed_Transaction_Sales DESC;

-- Objectives 6: Delivery Type Popularity
SELECT Delivery_Type,
    COUNT(*) AS Orders,
    SUM(Amount_US$) AS Total_Sales
FROM `us_e-commerce`
GROUP BY Delivery_Type
ORDER BY Orders DESC;







