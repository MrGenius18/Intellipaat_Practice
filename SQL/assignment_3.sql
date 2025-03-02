-- Create Jomato Database and use this Database 
CREATE DATABASE Jomato;
USE Jomato;
-- =============================================

-- Jomato table creation & CSV bulk file insert
CREATE TABLE Jomato(
OrderId int primary key,
RestaurantName varchar(255),
RestaurantType varchar(255),
Rating float,
NoofRating int,
AverageCost int,
OnlineOrder varchar(20),
TableBooking varchar(20),
CuisinesType varchar(255),
Area varchar(255),
LocalAddress varchar(255),
Deliverytime int);

BULK INSERT Jomato
FROM 'F:\Intellipaat\102_SQL\03_Assignments\Jomato.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n');
-- =============================================

-- execute the table
SELECT * FROM Jomato;
-- ==============================================

-- Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick Chicken Bites’.
CREATE FUNCTION StuffChickenIntoQuickBites (@String VARCHAR(100))
RETURNS VARCHAR(100)
AS
BEGIN
    Return REPLACE(@String, 'Quick Bites', 'Quick Chicken Bites');
END;
GO

-- Test the Function
SELECT dbo.StuffChickenIntoQuickBites('Quick Bites') AS ModifiedString;

-- Update the RestaurantType in the Jomato table
UPDATE Jomato
SET RestaurantType = dbo.StuffChickenIntoQuickBites(RestaurantType)
WHERE RestaurantType LIKE '%Quick Bites%';
-- ==============================================

-- Use the function to display the restaurant name and cuisine type which has the maximum number of rating.
SELECT TOP 1
RestaurantName,
CuisinesType
FROM Jomato
ORDER BY NoofRating DESC;
-- ==============================================

-- Create a Rating Status column to display the rating as 
-- ‘Excellent’ if it has more the 4 start rating, 
-- ‘Good’ if it has above 3.5 and below 4 star rating, 
-- ‘Average’ if it is above 3 and below 3.5 and 
-- ‘Bad’ if it is below 3 star rating.
ALTER TABLE Jomato ADD RatingStatus VARCHAR(20);

UPDATE Jomato 
SET RatingStatus=
CASE 
	WHEN Rating >= 4 THEN 'Excellent'
	WHEN Rating >= 3.5 THEN 'Good'
	WHEN Rating >= 3 THEN 'Average'
	ELSE 'Bad'
END;
-- ==============================================

-- Find the Ceil, floor and absolute values of the rating column and display the current date and separately display the year, month_name and day.
SELECT 
RestaurantName, 
Rating, 
CEILING(Rating) as Ceiling_Rating,
FLOOR(Rating) as Floor_Rating,
ABS(Rating) as Absolute_Rating,
GETDATE() as Date,
YEAR(GETDATE()) as Year,
DATENAME(MONTH, GETDATE()) as Month_Name,
DAY(GETDATE()) as Day
from Jomato;
-- ==============================================

-- Display the restaurant type and total average cost using rollup.
select RestaurantType, sum(AverageCost) as Total_Avg_Cost
from Jomato
group by rollup(RestaurantType);
-- ==============================================