SELECT TOP (100) [id]
,[acquisition_id]
,[acquiring_object_id]
,[acquired_object_id]
,[term_code]
,[price_amount]
,[price_currency_code]
,[acquired_at]
,[source_url]
,[source_description]
,[created_at]
,[updated_at]
 FROM [InvestmentsDB].[dbo].[acquisitions];
------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

--  Average Acquisition Price by Year

SELECT YEAR(acquired_at) AS Year, AVG(price_amount) AS Avg_Price
FROM acquisitions
GROUP BY acquired_at
ORDER BY acquired_at;
--------------------------------------------------------------------------
--------------------------------------------------------------------------

-- Most Common Payment Method Used

SELECT term_code, COUNT(*) AS Count
FROM acquisitions
GROUP BY term_code
ORDER BY Count DESC;
------------------------------------------------
------------------------------------------------

-- Most Frequently Used Currency in Acquisitions

SELECT price_currency_code, COUNT(*) AS Count
FROM acquisitions
GROUP BY price_currency_code
ORDER BY Count DESC;
-----------------------------------------------------------
-----------------------------------------------------------


-- Q: Tops countris sorted by raised amount 

SELECT 
	f.id,
    f.name,
    o.city,
    o.country_code,
    f.raised_amount
FROM funds as f
JOIN office as o ON f.ID = o.ID
ORDER BY f.raised_amount DESC;
-----------------------------------------------------
----------------------------------------------------

select * from acquisitions;
select * from funds;
select * from investments;
select * from ipos;
select * from milestones;
select * from office;
---------------------------------------------------
--------------------------------------------------


SELECT id, price_amount,term_code
FROM acquisitions
ORDER BY price_amount DESC
LIMIT 10;


SELECT id, MAX(price_amount) AS Highest_Investment, source_description
FROM acquisitions
GROUP BY id, source_description -- Add source_description here
ORDER BY Highest_Investment DESC;
-----------------------------------------------
------------------------------------------------

-- State that investments most
SELECT 
	o.id,
    o.state_code,
    a.price_amount,
    o.latitude,
    o.longitude,
    a.updated_at
FROM office as o
JOIN acquisitions as a ON a.ID = o.ID
ORDER BY a.price_amount DESC;
------------------------------------------------
------------------------------------------------



EXEC sp_rename 'InvestmentsDB.funds.name', 'funds_name', 'COLUMN';

SELECT
    id,
    funds_name,
    MAX(raised_amount) AS Highest_amount,
    source_description
FROM funds
GROUP BY id, funds_name, source_description -- Add source_description here
ORDER BY Highest_amount DESC;

SELECT
    id,
    name,
    MAX(raised_amount) AS Highest_amount,
    source_description
FROM funds
GROUP BY id, funds_name, source_description -- Add source_description here
ORDER BY Highest_amount DESC;
----------------------------------------------------------------------------
----------------------------------------------------------------------------


-- The countries havae most offices

SELECT country_code, COUNT(*) AS Office_Count
FROM office
GROUP BY country_code
ORDER BY Office_Count DESC;

--  Distinct combination of region, country, and state
SELECT
    region,
    country_code,
    COUNT(*) AS Office_Count,
    State_code AS State,    
    zip_code AS zipcode     
FROM
    office
-- Use original column names in GROUP BY
GROUP BY
    region,
    country_code, -- You forgot to include country_code in your GROUP BY! This would also cause a 1055 error in MySQL.
    State_code,
    zip_code
ORDER BY
    region DESC;
------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------


--  Funder ipos validation country, city and amount
SELECT i.valuation_amount, i.stock_symbol, o.city, o.region, o.country_code, i.public_at
FROM office as o
JOIN  ipos as i ON o.id = i.id
ORDER BY o.id DESC;
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------









