CREATE DATABASE OLA;
USE OLA;

DROP TABLE IF EXISTS ola_database;
CREATE TABLE Ola_database(
Booking_Id 				VARCHAR(20) PRIMARY KEY,
Customer_Id 			VARCHAR(20),	
Vehicle_Type 			VARCHAR(50),	
Pickup_Location 		VARCHAR(100),	
Drop_Location 			VARCHAR(100) ,	
Trip_Start_Time 		DATETIME,	
Trip_End_Time 			DATETIME,	
Trip_Date 				DATE, 	
Days_Of_Week 			VARCHAR(10),	
Trip_Hour 				INT,	
Booking_Value 			DECIMAL(10,2),	
Ride_Distance 			DECIMAL(10,2),	
Driver_Ratings 			DECIMAL(3,1),	
Customer_Ratings 		DECIMAL(3,1),	
Avg_Vtat 				DECIMAL(5,1),	
Avg_Ctat 				DECIMAL(5,1),	
Booking_Status 			VARCHAR(50),	
Customer_Cancel 		INT, 	
Customer_Cancel_Reason 	VARCHAR(100),	
Driver_Cancels 			INT,	
Driver_Cancel_Reason 	VARCHAR(100),	
Incomplete_Rides 		INT,	
Incomplete_Rides_Reason VARCHAR(100)
);

SELECT * FROM ola_database;

-- 1. Find total trips completed .
CREATE VIEW Total_Trips AS
SELECT 'Total City ' as city  , count(*) AS Total_Trips
FROM ola_database 
WHERE Booking_Status = 'Success';


-- 2. Get the average fare amount for each payment method.
CREATE VIEW Avg_Fareamount AS 
SELECT Vehicle_Type , AVG(Booking_Value) as AVE_FARE
FROM ola_database
WHERE Booking_Status = 'Success'
GROUP BY Vehicle_Type;

-- 3. List top  drivers by total number of trips.
CREATE VIEW Top_Driver AS
SELECT Driver_ratings , COUNT(*) AS Total_Trip
FROM ola_database
WHERE Booking_Status = 'Success'
GROUP BY Driver_Ratings
ORDER BY Total_Trip DESC 
LIMIT 5;


-- 4. Find the total revenue generated on weekends.
CREATE VIEW Total_revenue_Weekends AS 
SELECT SUM(Booking_Value) AS Weekend_Revenue 
FROM Ola_database 
WHERE Booking_Status = 'Success' 
AND Days_Of_Week IN ('Saturday' , 'Sunday');


-- 5. Show the total trips taken by each ride_type.
CREATE VIEW Total_Each_Ride AS 
SELECT Vehicle_Type , Count(*) AS Total_trip 
FROM ola_database
WHERE Booking_Status = 'Success'
GROUP BY vehicle_Type;


-- MEDIUM LEVEL QUERIES

-- 6. Find the driver with the highest average rating in each city.
CREATE VIEW Higest_Avg_Rating_city AS 
SELECT 'City' AS City , Driver_Ratings , AVG(Driver_Ratings) AS AVG_Rating
FROM Ola_Database 
WHERE Booking_Status = 'Success'
GROUP BY Driver_Ratings
ORDER BY Driver_Ratings DESC
LIMIT 1;

-- 7. List customers who took more than 5 rides in July 2025.
CREATE VIEW More_Than_5_Ride_07_2025 AS
SELECT Customer_Id , COUNT(*) AS Ride_count 
FROM Ola_Database
WHERE Booking_Status = 'Success' AND Date_Format(Trip_Start_Time , '%Y-%m') = '2025-07'
GROUP BY Customer_Id
HAVING Ride_Count > 5;


-- 8. Find the average trip duration per city.
CREATE VIEW Trip_Duration AS  
SELECT 'City' As City ,  AVG(TIMESTAMPDIFF(MINUTE, Trip_Start_Time, Trip_End_Time)) AS Duration
FROM Ola_database
WHERE Booking_Status = 'Success';

-- 9. Show the top 3 most popular pickup locations.
SELECT Pickup_Location, COUNT(*) AS Trip_Count
FROM Ola_Database
WHERE Booking_Status = 'Success'
GROUP BY Pickup_Location
ORDER BY Trip_Count DESC
LIMIT 3;

-- 10. Find the % of cash vs online payment rides in city.
CREATE VIEW Per_Ride_Cite AS
SELECT 
COALESCE(Pickup_Location, 'Unknown') AS City,
Vehicle_Type,
(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY Pickup_Location)) AS Percentage
FROM Ola_database
WHERE Booking_Status = 'Success'
GROUP BY Pickup_Location, Vehicle_Type
ORDER BY Percentage DESC;


-- 11. Calculate the daily revenue growth rate for each city.
WITH DailyRevenue AS(
SELECT 
DATE(Trip_Start_Time) AS Trip_Date, 
SUM(Booking_Value) AS Daily_Revenue
FROM Ola_Database
WHERE Booking_Status = 'Success'
GROUP BY DATE(trip_Start_Time))
SELECT Trip_Date , ((Daily_Revenue - LAG(Daily_Revenue) OVER(ORDER BY Trip_Date)) / LAG(Daily_Revenue) OVER(ORDER BY Trip_Date) * 100) AS Growth_Rate 
FROM DailyRevenue
ORDER BY Trip_Date;

-- 12. Find customers who spent more than ₹5,000 in total for the month.
SELECT Customer_Id, SUM(Booking_Value) AS Total_Spent
FROM Ola_database
WHERE Booking_Status = 'Success'
  AND DATE_FORMAT(Trip_Start_Time, '%Y-%m') = '2025-07'
GROUP BY Customer_Id
HAVING Total_Spent > 5000;






















	

