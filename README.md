# sql-server-data-analysis
Data Analysis Using SQL Server

📌 Overview

This project analyzes client data using SQL Server to answer key business questions. The dataset consists of four tables: financial, subscription, payment, and industry details.

📊 Questions Answered

1)How many Finance Lending and Blockchain clients does the organization have?

2)Which industry has the highest renewal rate?

3)What was the average inflation rate when subscriptions were renewed?

4)What is the median amount paid each year for all payment methods?

🛠️ Approach

Data Imported into SQL Server from CSV files.

-SQL Queries Used: JOIN, AVG, PERCENTILE_CONT, and GROUP BY.

Assumptions Made:

-renewed = 1 indicates a subscription renewal.

-Inflation rates are mapped based on start_date.

-Median payments are calculated using PERCENTILE_CONT(0.5).

📌 SQL Queries

1️⃣ Finance Lending & Blockchain Clients

SELECT COUNT(DISTINCT client_id) AS total_clients FROM industry_client_details WHERE industry IN ('Finance Lending', 'Blockchain');

2️⃣ Industry with Highest Renewal Rate

SELECT TOP 1 ic.industry, CAST(COUNT(CASE WHEN s.renewed = 1 THEN 1 END) AS FLOAT) / COUNT(*) AS renewal_rate FROM subscription_information s JOIN industry_client_details ic ON s.client_id = ic.client_id GROUP BY ic.industry ORDER BY renewal_rate DESC;

3️⃣ Average Inflation Rate at Renewal

SELECT AVG(CAST(f.inflation_rate AS FLOAT)) AS avg_inflation_at_renewal FROM subscription_information s JOIN financial_information f ON s.start_date BETWEEN f.start_date AND f.end_date WHERE s.renewed = 1;

4️⃣ Median Payment per Year per Method

SELECT YEAR(payment_date) AS year, payment_method, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY amount_paid) OVER (PARTITION BY YEAR(payment_date), payment_method) AS median_payment FROM payment_information;

🚀 How to Run

-Load Data into SQL Server using SQL Server Import Wizard.

-Execute the provided SQL queries in SSMS.

-Analyze and interpret the results.

📂 File Structure

├── data/ # CSV Files (Optional) ├── queries.sql # SQL Queries ├── README.md # Documentation

📢 Conclusion

This project provides insights into client renewals, financial trends, and transaction patterns, supporting business decision-making.

🔹 Author: Charan 🔹Tools Used: SQL Server 🔹 Database Management: SQL

📌 For questions, feel free to reach out! 🚀
