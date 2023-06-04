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


Customer Credentials (Create)
CREATE TABLE customer_credentials (`customerID` INT NOT NULL AUTO_INCREMENT, `customerFirstName` VARCHAR(100), `customerLastName` VARCHAR(100), `customerPassword` VARCHAR(256), `customerEmail` VARCHAR(100), `customerMobileNumber` VARCHAR(256), `customerBirthday` VARCHAR(100), `lastLoginTimestamp` VARCHAR(100), deactivated VARCHAR(20), PRIMARY KEY (`customerID`));




INSERT INTO midnightcoffeedb.customer_credentials (`customerFirstName`, `customerLastName`, `customerPassword`, `customerEmail`, `customerMobileNumber`, `customerBirthday`, `lastLoginTimestamp`, deactivated)
    VALUES ('Admin', '0HkRcAneXwfW/VNPQxaW2g==', '0HkRcAneXwfW/VNPQxaW2g==', 'admin@gmail.com', '123456789', NULL, NULL, 'No');
INSERT INTO midnightcoffeedb.customer_credentials (`customerFirstName`, `customerLastName`, `customerPassword`, `customerEmail`, `customerMobileNumber`, `customerBirthday`, `lastLoginTimestamp`, deactivated)
    VALUES ('Marc', 'Fernando', 'TdglzEYQOKd0Rws+6bbhOA==', 'Marc@gmail.com', '09451549642', NULL, NULL, 'No');
INSERT INTO midnightcoffeedb.customer_credentials (`customerFirstName`, `customerLastName`, `customerPassword`, `customerEmail`, `customerMobileNumber`, `customerBirthday`, `lastLoginTimestamp`, deactivated)
    VALUES ('Admin', 'TdglzEYQOKd0Rws+6bbhOA==', 'TdglzEYQOKd0Rws+6bbhOA==', 'admin@gmail.com', '123456789', NULL, NULL, 'Yes');
INSERT INTO midnightcoffeedb.customer_credentials (`customerFirstName`, `customerLastName`, `customerPassword`, `customerEmail`, `customerMobileNumber`, `customerBirthday`, `lastLoginTimestamp`, deactivated)
    VALUES ('Andrei Kyle', 'Hidalgo', 'TdglzEYQOKd0Rws+6bbhOA==', 'Andrei@gmail.com', '09451549642', NULL, '2023-05-07 16:04:24', 'No');
INSERT INTO midnightcoffeedb.customer_credentials (`customerFirstName`, `customerLastName`, `customerPassword`, `customerEmail`, `customerMobileNumber`, `customerBirthday`, `lastLoginTimestamp`, deactivated)
    VALUES ('Kevin', 'Ruiz', 'TdglzEYQOKd0Rws+6bbhOA==', 'Kevin@gmail.com', '09451549642', NULL, '2023-05-07 16:07:16', 'No');
INSERT INTO midnightcoffeedb.customer_credentials (`customerFirstName`, `customerLastName`, `customerPassword`, `customerEmail`, `customerMobileNumber`, `customerBirthday`, `lastLoginTimestamp`, deactivated)
    VALUES ('Aronwins', 'Manuel', 'TdglzEYQOKd0Rws+6bbhOA==', 'Aronwins@gmail.com', '09451549642', NULL, '2023-05-07 16:07:17', 'No');
INSERT INTO midnightcoffeedb.customer_credentials (`customerFirstName`, `customerLastName`, `customerPassword`, `customerEmail`, `customerMobileNumber`, `customerBirthday`, `lastLoginTimestamp`, deactivated)
    VALUES ('Rvhin', 'Picadizo', 'TdglzEYQOKd0Rws+6bbhOA==', 'Rvhin@gmail.com', '09451549642', NULL, NULL, 'Yes');
INSERT INTO midnightcoffeedb.customer_credentials (`customerFirstName`, `customerLastName`, `customerPassword`, `customerEmail`, `customerMobileNumber`, `customerBirthday`, `lastLoginTimestamp`, deactivated)
    VALUES ('Jennard', 'Prado', 'TdglzEYQOKd0Rws+6bbhOA==', 'Jennard@gmail.com', '09451549642', NULL, NULL, 'Yes');
INSERT INTO midnightcoffeedb.customer_credentials (`customerFirstName`, `customerLastName`, `customerPassword`, `customerEmail`, `customerMobileNumber`, `customerBirthday`, `lastLoginTimestamp`, deactivated)
    VALUES ('Ero', 'Solis', 'A1hsoY0hHh4hzJJBhcjpbw==', 'ero.solis@gmail.com', '9472367447', NULL, NULL, 'No');
INSERT INTO midnightcoffeedb.customer_credentials (`customerFirstName`, `customerLastName`, `customerPassword`, `customerEmail`, `customerMobileNumber`, `customerBirthday`, `lastLoginTimestamp`, deactivated)
    VALUES ('Clark', 'Mansibang', '8Nb/bmRz3ygbQVPcLN0Lzw==', 'clarkmansibang@gmail.com', '639271832585', NULL, NULL, 'No');
INSERT INTO midnightcoffeedb.customer_credentials (`customerFirstName`, `customerLastName`, `customerPassword`, `customerEmail`, `customerMobileNumber`, `customerBirthday`, `lastLoginTimestamp`, deactivated)
    VALUES ('haha', 'haha', 'DyTHdOi/eTX0OoZxA3A96Q==', 'haha@gmail.com', '12111', '2011-04-01', '2023-05-07 14:51:14', 'No');






Product Table (Create)
CREATE TABLE products (`itemCode` INT NOT NULL AUTO_INCREMENT, `itemName` VARCHAR(50) NOT NULL, `itemOption` VARCHAR(50), `itemPrice` VARCHAR(255), `itemImage` VARCHAR(255) NOT NULL, `itemClass` VARCHAR(20) NOT NULL, `itemStock` VARCHAR(20) NOT NULL, deactivated VARCHAR(3) NOT NULL, deactivationtimestamp TIMESTAMP, PRIMARY KEY (`itemCode`));






Product Table (Insert Lahat)
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Espresso Shot', 'Espresso', 100, 'empty', 'Coffee', 'In Stock', 'No', NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Americano', 'Hot', 115, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Americano', 'Iced Regular', 125, 'empty', 'Coffee', 'In Stock', 'No', NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Americano', 'Iced Lofty', 145, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Long Black', 'Hot', 115, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Long Black', 'Iced Regular', 125, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Long Black', 'Iced Lofty', 145, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Caffè Latte', 'Hot', 145, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Caffè Latte', 'Iced Regular', 165, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Caffè Latte', 'Iced Lofty', 185, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Cappuccino', 'Hot', 145, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Cappuccino', 'Iced Regular', 165, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Cappuccino', 'Iced Lofty', 185, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Flat White', 'Hot', 145, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Flat White', 'Iced Regular', 165, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Flat White', 'Iced Lofty', 185, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Sweet Iced Black', 'Iced Regular', 135, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Sweet Iced Black', 'Iced Lofty', 155, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Signature Caramel Latte', 'Hot', 155, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Signature Caramel Latte', 'Iced Regular', 175, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Signature Caramel Latte', 'Iced Lofty', 195, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Caffè Mocha', 'Hot', 165, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Caffè Mocha', 'Iced Regular', 185, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Caffè Mocha', 'Iced Lofty', 205, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Dirty Matcha', 'Hot', 165, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Dirty Matcha', 'Iced Regular', 195, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Dirty Matcha', 'Iced Lofty', 215, 'empty', 'Coffee', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Caffè con Leche', 'Hot', 155, 'empty', 'Kremalatte', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Caffè con Leche', 'Iced Regular', 175, 'empty', 'Kremalatte', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Caffè con Leche', 'Iced Lofty', 195, 'empty', 'Kremalatte', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Vanilla Sweet Cream', 'Iced Regular', 175, 'empty', 'Kremalatte', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Vanilla Sweet Cream', 'Iced Lofty', 195, 'empty', 'Kremalatte', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Caffè Ngau Lai', 'Iced Regular', 155, 'empty', 'Kremalatte', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Vanilla Cream', 'Iced Regular', 170, 'empty', 'Kremalatte', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Vanilla Cream', 'Iced Lofty', 190, 'empty', 'Kremalatte', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Matcha Cream', 'Iced Regular', 180, 'empty', 'Kremalatte', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Matcha Cream', 'Iced Lofty', 200, 'empty', 'Kremalatte', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Ube n Macapuno', 'Iced Regular', 180, 'empty', 'Kremalatte', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Ube n Macapuno', 'Iced Lofty', 200, 'empty', 'Kremalatte', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Very Berry', 'Iced Regular', 180, 'empty', 'Kremalatte', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Very Berry', 'Iced Lofty', 200, 'empty', 'Kremalatte', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Strawberry Cream', 'Iced Regular', 180, 'empty', 'Kremalatte', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Strawberry Cream', 'Iced Lofty', 200, 'empty', 'Kremalatte', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Choco Ganache', 'Iced Regular', 190, 'empty', 'Kremalatte', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Choco Ganache', 'Iced Lofty', 210, 'empty', 'Kremalatte', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Sunset Jasmine Green Tea', 'Hot', 110, 'empty', 'Tea', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Pineapple Dragon Oolong Tea', 'Hot', 110, 'empty', 'Tea', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Classic Masala Chai', 'Hot', 120, 'empty', 'Tea', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Matcha Latte', 'Hot', 135, 'empty', 'Tea', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Matcha Latte', 'Iced Regular', 175, 'empty', 'Tea', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Matcha Latte', 'Iced Lofty', 195, 'empty', 'Tea', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Masala Chai Latte', 'Hot', 145, 'empty', 'Tea', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Masala Chai Latte', 'Iced Regular', 165, 'empty', 'Tea', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Masala Chai Latte', 'Iced Lofty', 185, 'empty', 'Tea', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Midnight Sweet Peached Iced Tea', 'Iced Regular', 135, 'empty', 'Tea', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Midnight Sweet Peached Iced Tea', 'Iced Lofty', 155, 'empty', 'Tea', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Jasmine Lychee', 'Iced Regular', 145, 'empty', 'Tea', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Jasmine Lychee', 'Iced Lofty', 165, 'empty', 'Tea', 'In Stock', 'No',  NULL);
insert into midnightcoffeedb.products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated , deactivationtimestamp)values ('Goodnight Cocoa', 'Hot', 130, 'empty', 'Tea', 'In Stock', 'No',  NULL);







Payment Method (Create)
CREATE TABLE payment_method (methodID INT NOT NULL AUTO_INCREMENT, methodName VARCHAR(100), QRImage VARCHAR(256), PRIMARY KEY (methodID));


Ingredients List (Create)
CREATE TABLE ingredients (`itemCode` INT NOT NULL AUTO_INCREMENT, `ingredientName` VARCHAR(50) NOT NULL, `ingredientWeight` INT NOT NULL, `minimumWeight` INT NOT NULL, deactivationtimestamp TIMESTAMP, PRIMARY KEY (`itemCode`));





Insert Ingredients
insert into midnightcoffeedb.ingredients (ingredientName, ingredientWeight, minimumWeight, deactivationtimestamp ) values ('Coffee', '100000', '1000', null);

insert into midnightcoffeedb.ingredients (ingredientName, ingredientWeight, minimumWeight, deactivationtimestamp ) values ('Kremalatte', '100000', '1000', null);

insert into midnightcoffeedb.ingredients (ingredientName, ingredientWeight, minimumWeight, deactivationtimestamp ) values ('Tea', '100000', '1000', null);




Recipes List (Create)
CREATE TABLE recipes (`itemCode` INT NOT NULL AUTO_INCREMENT, `itemName` VARCHAR(50), `itemOption` VARCHAR(50) NOT NULL, `ingredientList` VARCHAR(1000) NOT NULL, `weightList` VARCHAR(1000), PRIMARY KEY (`itemCode`));





Insert Recipes
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Espresso Shot', 'Espresso', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Americano', 'Hot', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Americano', 'Iced Regular', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Americano', 'Iced Lofty', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Long Black', 'Hot', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Long Black', 'Iced Regular', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Long Black', 'Iced Lofty', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Caffè Latte', 'Hot', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Caffè Latte', 'Iced Regular', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Caffè Latte', 'Iced Lofty', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Cappuccino', 'Hot', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Cappuccino', 'Iced Regular', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Cappuccino', 'Iced Lofty', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Flat White', 'Hot', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Flat White', 'Iced Regular', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Flat White', 'Iced Lofty', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Sweet Iced Black', 'Iced Regular', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Sweet Iced Black', 'Iced Lofty', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Signature Caramel Latte', 'Hot', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Signature Caramel Latte', 'Iced Regular', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Signature Caramel Latte', 'Iced Lofty', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Caffè Mocha', 'Hot', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Caffè Mocha', 'Iced Regular', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Caffè Mocha', 'Iced Lofty', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Dirty Matcha', 'Hot', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Dirty Matcha', 'Iced Regular', 'Coffee', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Dirty Matcha', 'Iced Lofty', 'Coffee', 100);

insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Caffè con Leche', 'Hot', 'Kremalatte', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Caffè con Leche', 'Iced Regular', 'Kremalatte', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Caffè con Leche', 'Iced Lofty', 'Kremalatte', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Vanilla Sweet Cream', 'Iced Regular', 'Kremalatte', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Vanilla Sweet Cream', 'Iced Lofty', 'Kremalatte', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Caffè Ngau Lai', 'Iced Regular', 'Kremalatte', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Vanilla Cream', 'Iced Regular', 'Kremalatte', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Vanilla Cream', 'Iced Lofty', 'Kremalatte', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Matcha Cream', 'Iced Regular', 'Kremalatte', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Matcha Cream', 'Iced Lofty', 'Kremalatte', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Ube n Macapuno', 'Iced Regular', 'Kremalatte', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Ube n Macapuno', 'Iced Lofty', 'Kremalatte', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Very Berry', 'Iced Regular', 'Kremalatte', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Very Berry', 'Iced Lofty', 'Kremalatte', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Strawberry Cream', 'Iced Regular', 'Kremalatte', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Strawberry Cream', 'Iced Lofty', 'Kremalatte', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Choco Ganache', 'Iced Regular', 'Kremalatte', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Choco Ganache', 'Iced Lofty', 'Kremalatte', 100);

insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Sunset Jasmine Green Tea', 'Hot', 'Tea', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Pineapple Dragon Oolong Tea', 'Hot', 'Tea', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Classic Masala Chai', 'Hot', 'Tea', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Matcha Latte', 'Hot', 'Tea', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Matcha Latte', 'Iced Regular', 'Tea', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Matcha Latte', 'Iced Lofty', 'Tea', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Masala Chai Latte', 'Hot', 'Tea', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Masala Chai Latte', 'Iced Regular', 'Tea', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Masala Chai Latte', 'Iced Lofty', 'Tea', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Midnight Sweet Peached Iced Tea', 'Iced Regular', 'Tea', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Midnight Sweet Peached Iced Tea', 'Iced Lofty', 'Tea', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Jasmine Lychee', 'Iced Regular', 'Tea', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Jasmine Lychee', 'Iced Lofty', 'Tea', 100);
insert into midnightcoffeedb.recipes (itemName, itemOption, ingredientList, weightList)values ('Goodnight Cocoa', 'Hot', 'Tea', 100);





Customer Orders (Create)
CREATE TABLE customer_orders (orderID INT NOT NULL AUTO_INCREMENT, customerID VARCHAR(100), summaryQuantity VARCHAR(256), summaryName VARCHAR(256), summaryOption VARCHAR(256), summaryPrice VARCHAR(256), orderTotal VARCHAR(100), orderDate VARCHAR(100), orderTime VARCHAR(100), PRIMARY KEY (orderID));



Feedback List (Create)
CREATE TABLE feedbacklist (`feedbackID` INT NOT NULL AUTO_INCREMENT, rating INT NOT NULL, message VARCHAR(500), `customerID` INT NOT NULL, `customerFirstName` VARCHAR(50) NOT NULL, `customerLastname` VARCHAR(50) NOT NULL, displayed VARCHAR(3) NOT NULL, `timestamp` TIMESTAMP DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY (`feedbackID`));





Update column ng itemStock sa products table
UPDATE products
SET itemStock = 'In Stock';



SalesCount (Create)


CREATE TABLE salescount (itemCode INT NOT NULL, itemName VARCHAR(500) NOT NULL, itemOption VARCHAR(100) NOT NULL, itemClass VARCHAR(100) NOT NULL, count INT NOT NULL, PRIMARY KEY (itemCode));








Admin Account
INSERT INTO midnightcoffeedb.customer_credentials (customerFirstName, customerLastName, customerPassword, customerEmail, customerMobileNumber) 
	VALUES ('admin', '0HkRcAneXwfW/VNPQxaW2g==', '0HkRcAneXwfW/VNPQxaW2g==', 'bruh@gmail.com', '21212121');





Admin_transactions

CREATE TABLE admin_transactions (`itemTransaction` VARCHAR(100), `itemName` VARCHAR(100), `transactionTimestamp` VARCHAR(100));



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


