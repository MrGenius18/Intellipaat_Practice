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

-- Create a stored procedure to display the restaurant name, type and cuisine where the table booking is not zero.
CREATE PROCEDURE non_zero_booking
AS
	SELECT RestaurantName, RestaurantType, CuisinesType
	FROM Jomato
	WHERE TableBooking != 'No'
GO

-- call the Procedure
EXEC non_zero_booking;
-- ==============================================

-- Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’.
begin try
	begin TRANSACTION 
		UPDATE Jomato
		SET RestaurantType = 'Cafeteria' WHERE RestaurantType = 'Cafe'
	-- COMMIT TRANSACTION
	PRINT 'Transaction Completed'
end try
begin catch
	ROLLBACK TRANSACTION
	PRINT 'Transaction Failed'	
end catch;

-- Check the result and rollback it.
select * from Jomato;
ROLLBACK TRANSACTION;
-- ==============================================

-- Generate a row number column and find the top 5 areas with the highest rating of restaurants.
WITH RankedRestaurants 
AS (
    SELECT 
		Area,
        RestaurantName,
        Rating,
        ROW_NUMBER() OVER (PARTITION BY Area ORDER BY Rating DESC) AS row_num
    FROM Jomato
)
SELECT TOP 5 Area, AVG(Rating) AS AverageRating
FROM RankedRestaurants
WHERE row_num = 1
GROUP BY Area
ORDER BY AverageRating DESC;
-- ==============================================

-- Use the while loop to display the 1 to 50.
declare @counter int = 1;

WHILE @counter <= 50
BEGIN
    PRINT @counter;
    SET @counter = @counter + 1;
END
-- ==============================================

-- Write a query to Create a Top rating view to store the generated top 5 highest rating of restaurants.
CREATE VIEW Top5HighestRatingRestaurants
AS
	SELECT TOP 5 * FROM Jomato
ORDER BY Rating DESC;

SELECT * FROM Top5HighestRatingRestaurants;
-- ==============================================

-- Create a trigger that give an message whenever a new record is inserted.
CREATE TRIGGER NotifyOnInsert
ON Jomato
AFTER INSERT
AS
BEGIN
    PRINT 'A new record has been successfully inserted into the Jomato table.';
END;

INSERT INTO Jomato 
VALUES (0, 'Test Restaurant', 'Fast Food', 4.5, 100, 500, 'Yes', 'No', 'Italian', 'Downtown', '123 Test St', 30, 'Excellent');
-- ==============================================