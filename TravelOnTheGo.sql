CREATE DATABASE IF NOT EXISTS `TravelOnTheGo`;
USE `TravelOnTheGo`;

/* creating table PASSENGER*/
CREATE TABLE IF NOT EXISTS `PASSENGER`(
Passenger_Name VARCHAR (50),
Category VARCHAR (50),
Gender VARCHAR (50),
Boarding_city VARCHAR (50),
Destination VARCHAR (50),
Distance INT,
Bus_Type VARCHAR (50),
PRIMARY KEY (Passenger_Name)
);

/* creating table PRICE*/
CREATE TABLE IF NOT EXISTS `PRICE`(
Bus_Type VARCHAR (50),
Distance INT,
Price INT
);

/*inserting data in the table PASSENGER*/
INSERT INTO PASSENGER VALUE("Sejal","AC", 'F', "Bengaluru", "Chennai", 350, "Sleeper");
INSERT INTO PASSENGER VALUE("Anmol","Non-AC",'M',"Mumbai","Hyderabad",700,"Sitting");
INSERT INTO PASSENGER VALUE("Pallavi","AC",'F',"Panaji","Bengaluru",600,"Sleeper");
INSERT INTO PASSENGER VALUE("Khusboo","AC",'F',"Chennai","Mumbai",1500,"Sleeper");
INSERT INTO PASSENGER VALUE("Udit","Non-AC",'M',"Trivandrum","Panaji",1000,"Sleeper");
INSERT INTO PASSENGER VALUE("Ankur","AC",'M',"Nagpur","Hyderabad",500,"Sitting");
INSERT INTO PASSENGER VALUE("Hemant","Non-AC",'M',"Panaji","Mumbai",700,"Sleeper");
INSERT INTO PASSENGER VALUE("Manish","Non-AC",'M',"Hyderabad","Bengaluru",500,"Sitting");
INSERT INTO PASSENGER VALUE("Piyush","AC",'M',"Pune","Nagpur",700,"Sitting");

/*inserting data in the table PRICE*/
INSERT INTO PRICE VALUE("Sleeper", 350, 770);
INSERT INTO PRICE VALUE("Sleeper", 500, 1100);
INSERT INTO PRICE VALUE("Sleeper", 600, 1320);
INSERT INTO PRICE VALUE("Sleeper", 700, 1540);
INSERT INTO PRICE VALUE("Sleeper", 1000, 2200);
INSERT INTO PRICE VALUE("Sleeper", 1200, 2640);
INSERT INTO PRICE VALUE("Sleeper", 1500, 2700);
INSERT INTO PRICE VALUE("Sitting", 500, 620);
INSERT INTO PRICE VALUE("Sitting", 600, 744);
INSERT INTO PRICE VALUE("Sitting", 700, 868);
INSERT INTO PRICE VALUE("Sitting", 1000, 1240);
INSERT INTO PRICE VALUE("Sitting", 1200, 1488);
INSERT INTO PRICE VALUE("Sitting", 1500, 1860);

/* Numbers of males and females passengers travelled for a minimum distance of 
600 KMs?*/

SELECT Gender, COUNT(*) FROM Passenger 
WHERE Distance >=600 GROUP BY Gender;

/* Finding minimum ticket price for Sleeper Bus. */

SELECT Bus_Type, MIN(Price)
FROM `Price` WHERE Bus_Type = 'Sleeper';

/* Names of passengers whose names start with character 'S'*/

SELECT * FROM Passenger WHERE Passenger_Name LIKE 'S%';


/* Calculating price charged for each passenger displaying Passenger name, Boarding City, 
Destination City, Bus_Type, Price in the output*/

SELECT DISTINCT Passenger_Name, Boarding_city, Destination, Passenger.Bus_Type, Price FROM Passenger
JOIN price ON Passenger.Bus_Type = Price.Bus_Type AND Passenger.Distance = Price.Distance
ORDER BY Passenger_Name;

/*The passenger name/s and his/her ticket price who travelled in the Sitting bus 
for a distance of 1000 KMs*/

SELECT Passenger_Name, Price AS 'Ticket price'
FROM Passenger JOIN Price ON Passenger.Bus_Type = 'Sitting' AND Passenger.Distance = 1000
GROUP BY Passenger_Name;
/*It will return zero as there is no Passenger travelling at
Bus_Type "Sitting" for a distance of 1000 kms*/

/* Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to 
Panaji?*/

SELECT Passenger_Name, Destination, Boarding_city, Price.Bus_Type, Price
FROM Passenger JOIN Price ON Price.Distance = Passenger.Distance
WHERE Passenger_Name = 'Pallavi'; 

/* The list of distances from the "Passenger" table which are unique (non-repeated 
distances) in descending order.*/

SELECT DISTINCT (Distance) AS 'Non-Repeating Distances'
FROM Passenger
ORDER BY Distance DESC;

/*Displaying the passenger name and percentage of distance travelled by that passenger 
from the total distance travelled by all passengers without using user variables*/

SELECT Passenger_Name, Distance AS 'Distance Travelled', Distance * 100 / (SELECT SUM(Distance) FROM Passenger )
AS 'Percentage of distance travelled from the Total Distance' FROM Passenger;

 
/* Displaying the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise
*/

SELECT Distance, Price,
CASE WHEN Price > 1000 THEN 'Expensive'
WHEN Price > 500 AND Price < 1000 THEN 'Average Coast' ELSE 'Cheap' END AS Category
FROM Price;