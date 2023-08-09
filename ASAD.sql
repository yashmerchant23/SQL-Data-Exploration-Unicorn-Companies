--Creating the Database
CREATE TABLE Unicorn_Companies (         
	Company VARCHAR(255) PRIMARY KEY,
	Valuation_in_billions numeric,
	Date_Joined date,
	Country VARCHAR(255),
	City VARCHAR(255),
	Industry VARCHAR(255),
	Select_Investors VARCHAR(255),
	Founded_year integer,
	Total_raised VARCHAR(255),
	Financial_Stage VARCHAR(255),
	Investor_count integer,
	Deal_terms VARCHAR(255),
	Portfolio_Exits VARCHAR(255)
)


-- dropping columns irrelevant for this project 
ALTER TABLE Unicorn_companies  
DROP COLUMN Financial_Stage, 
DROP COLUMN Portfolio_Exits ; 


-- top 10 UNICORNS according to their Valuation 
SELECT * FROM Unicorn_Companies
ORDER BY Valuation_in_billions DESC
LIMIT 10


-- top 10 UNICORNS according to countries 
SELECT * FROM Unicorn_Companies
WHERE country = 'United States'
ORDER BY Valuation_in_billions DESC
LIMIT 10


-- Differnet number of Industries
SELECT industry,COUNT(company) FROM Unicorn_Companies
GROUP BY industry 
ORDER BY COUNT(company) DESC


-- Number of Companies Tiger Global Management has invested in this dataset
SELECT company,valuation_in_billions, country, select_investors FROM Unicorn_companies
WHERE select_investors LIKE 'Tiger Global Management%' 
OR select_investors LIKE '%, Tiger Global Management' 
OR select_investors LIKE '%, Tiger Global Management,%'

	
-- Number of companies became Unicorn in the year 2019
SELECT COUNT(*) FROM Unicorn_companies              
WHERE date_joined between '2019-01-01' AND '2019-12-31'   -- ANS IS 107 COMPANIES


-- Number of Unicorns in different countries
SELECT country,COUNT(company) FROM Unicorn_Companies
GROUP BY country 
ORDER BY COUNT(company) DESC

	
-- Number of companies in different countries with exact 1 billion dollar valuation
SELECT country,COUNT(company) FROM Unicorn_Companies
WHERE valuation_in_billions = '1'
GROUP BY country 
ORDER BY COUNT(company) DESC


-- When did the companies became Unicorns
SELECT company,EXTRACT(YEAR FROM date_joined) AS YEAR,
EXTRACT(MONTH FROM date_joined) AS MONTH from Unicorn_Companies
ORDER BY year ASC


-- top 10 companies with most investors  
SELECT company,investor_count from unicorn_companies
ORDER BY investor_count DESC
LIMIT 10


-- valuation of all fintech companies
SELECT company,country,city, valuation_in_billions FROM unicorn_companies
WHERE industry = 'Fintech'
ORDER BY valuation_in_billions DESC


-- As AI is becoming popular, the companies purely focused on AI have recently became tech stars. 
-- So find the year the AI companies joined the Unicorn culb
SELECT company,country,valuation_in_billions, EXTRACT(YEAR FROM date_joined) AS YEAR from Unicorn_Companies
WHERE industry = 'Artificial intelligence'
ORDER BY year ASC


-- companies in silicon valley 
SELECT company,country,city, valuation_in_billions, industry FROM Unicorn_companies
WHERE city = 'Mountain View' OR city = 'San Francisco' OR city = 'Palo Alto' OR city ='Fremont'
OR city ='San Jose'
ORDER BY valuation_in_billions DESC


-- companies in silicon valley of india: bengaluru
SELECT company,country,city, valuation_in_billions, industry FROM Unicorn_companies
WHERE city = 'Bengaluru' 
ORDER BY valuation_in_billions DESC


-- top 10 companies that became unicorns in least time 
SELECT company,country, valuation_in_billions,EXTRACT(YEAR FROM date_joined),founded_year,
(EXTRACT(YEAR FROM date_joined) - founded_year) AS AGE FROM Unicorn_companies
ORDER BY AGE DESC
LIMIT 10


--average age to become a unicorn company
SELECT ROUND(AVG((EXTRACT(YEAR FROM date_joined) - founded_year)),2) AS AVERAGE_AGE FROM Unicorn_companies

--average age to become a unicorn company in India
SELECT ROUND(AVG((EXTRACT(YEAR FROM date_joined) - founded_year)),2) AS AVERAGE_AGE FROM Unicorn_companies  
WHERE country = 'India'


-- Companies that took less than average time to become unicorn
SELECT * FROM Unicorn_Companies
WHERE (EXTRACT(YEAR FROM date_joined) - founded_year) < (SELECT ROUND(AVG((EXTRACT(YEAR FROM date_joined) - founded_year)),2) 
FROM Unicorn_Companies)
ORDER BY valuation_in_billions DESC   -- total 681 companies
