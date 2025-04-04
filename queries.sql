create database four_files;

use four_files


--Q1: Count of Finance Lending and Blockchain Clients

SELECT COUNT(DISTINCT client_id) AS total_clients
FROM [dbo].[industry_client_details]
WHERE industry IN ('Finance Lending', 'Blockchain');


--Q2: Industry with the Highest Renewal Rate

SELECT TOP 1 
       ic.industry, 
       CAST(COUNT(CASE WHEN s.renewed = 1 THEN 1 END) AS FLOAT) / COUNT(*) AS renewal_rate
FROM  [dbo].[subscription_information] s
JOIN [dbo].[industry_client_details] ic ON s.client_id = ic.client_id
GROUP BY ic.industry
ORDER BY renewal_rate DESC;


--Q3: Average Inflation Rate When Subscriptions Were Renewed

SELECT AVG(CAST(f.inflation_rate AS FLOAT)) AS avg_inflation_at_renewal
FROM [dbo].[subscription_information] s
JOIN [dbo].[finanical_information] f 
ON s.start_date >= f.start_date AND s.start_date <= f.end_date
WHERE s.renewed = 1;

--Q4: Median Amount Paid Each Year for All Payment Methods

SELECT YEAR(payment_date) AS year, 
       payment_method,
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY amount_paid) OVER (PARTITION BY YEAR(payment_date), payment_method) AS median_payment
FROM [dbo].[payment_information];
