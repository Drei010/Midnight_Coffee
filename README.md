# Midnight_Coffee
Software Engineering Project



Databse Details
 driver = "jdbc:mysql"
 
 
 username = "root"
 
 
 password = "rootpassword"
 
 
 hostname = "localhost"
 
 
dbport = "3306"


 databaseName = "midnightcoffeedb"
 
 
 useSSL = "?useSSL=false";


Table customer_credentials mySQL commands:





CREATE TABLE customer_credentials (`customerID` INT NOT NULL AUTO_INCREMENT, `customerFirstName` VARCHAR(100), `customerLastName` VARCHAR(100), `customerPassword` VARCHAR(256), `customerEmail` VARCHAR(100), `customerMobileNumber` INT, PRIMARY KEY (`customerID`));
