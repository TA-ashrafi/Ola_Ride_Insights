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











	

