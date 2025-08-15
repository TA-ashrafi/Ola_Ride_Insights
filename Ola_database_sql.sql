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


