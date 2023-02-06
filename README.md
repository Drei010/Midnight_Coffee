# Midnight_Coffee
Software Engineering Project



How to create the database

Step 1 go to services and create database 



![image](https://user-images.githubusercontent.com/91335885/216987017-f33f0b60-54c1-4052-8383-32fa17f7a1ba.png)

Step 2 name it "midnightcoffeedb"



![image](https://user-images.githubusercontent.com/91335885/216987373-8d4933b0-294d-4e47-8c89-32dacb2fc666.png)




Step 3 click execute command 




![image](https://user-images.githubusercontent.com/91335885/216987768-6b396fa6-7bf3-4ee5-8194-ad48750c4b77.png)



Step 4 copy paste and run


CREATE TABLE customer_credentials (`customerID` INT NOT NULL AUTO_INCREMENT, `customerFirstName` VARCHAR(100), `customerLastName` VARCHAR(100), `customerPassword` VARCHAR(256), `customerEmail` VARCHAR(100), `customerMobileNumber` INT, PRIMARY KEY (`customerID`));



![image](https://user-images.githubusercontent.com/91335885/216988157-6e15da89-183d-48af-97a6-62e7f6525734.png)






Step 5 make sure table was created 




![image](https://user-images.githubusercontent.com/91335885/216988315-54dfb157-d296-4ada-b5f8-965a60f59c8d.png)



Step 6 go to establishConn.java and change the username and password based on what you have set on your local computer



![image](https://user-images.githubusercontent.com/91335885/216988985-0691ecfb-9810-4288-9aa9-8318b4b063a9.png)




Databse Details
 driver = "jdbc:mysql"
 

 username = "root"
 
 
 password = "rootpassword"
 
 
 hostname = "localhost"
 
 
dbport = "3306"


 databaseName = "midnightcoffeedb"
 
 
 useSSL = "?useSSL=false";


