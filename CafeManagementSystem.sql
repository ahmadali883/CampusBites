
create database CafeSystem
use CafeSystem
--table for customer info 

	select * from Items;
	select * from Orders;
	select * from OrderedItems;
	select * from Customer;
	select * from Cashier;
	select * from payment;
	select * from CashRegister;
	select * from InventoryManager;
	select * categories

	DELETE FROM Orders WHERE OrderID = 10

	delete from Orders;
	delete from items
	delete from OrderedItems;

	delete from Orders where OrderID=7;

	create table OrderedItems( --
	OrderID int,
	itemID int,
	quantity int,
	foreign key (itemID) references items(itemID),
	foreign key (OrderID) references Orders(OrderID),
	Primary key(OrderID,itemID)
	);
	alter table OrderedItems
	add foreign key (itemID) references items(itemid)




	drop table Orders

	ALTER TABLE Items
DROP COLUMN ItemID;


SELECT
    constraint_name
FROM
    information_schema.table_constraints
WHERE
    table_name = 'CategoriesHasItems' AND constraint_type = 'foreign key';


	items
	ordereditems

	select * from CategoriesHasItems

	alter table items
	drop constraint PK__Items__727E83EB9E7DD5F4

	select BasePrice from Pricing join Items on Pricing.PricingID = Items.priceid where Items.itemID = 102;

	select * from InventoryManager

create table Customer(
CustomerId int identity(1,1)primary key,
FullName varchar(15),
Email varchar(20),
Password varchar(10),
ContactNo varchar(11),
Username varchar(20) Unique,
);

select * from items



select * from Customer;

INSERT INTO Customer (FullName, Email, Password, ContactNo, Username)
VALUES ('Ahmad Ali', 'ahmad.ali@gmail.com', '1122', '03139898091', 'ahmad');


select * from customer;
--tabke for Inventory Manager
create table InventoryManager(
IManagerID int identity(1,1) primary key,
IManagerName varchar(20),
Username varchar(20),
IMContactno varchar(11),
Password varchar(10),
 Email VARCHAR(30)
);


INSERT INTO InventoryManager (IManagerName, Username, IMContactno, Password, Email)
VALUES ('Ahmad Khan', 'ahmadkhan', '12345678901', '2233', 'ahmad.khan@example.com');

-- Update IManagerName and Username to 'Ali'
UPDATE InventoryManager
SET IManagerName = 'Ali', Username = 'ali'
WHERE IManagerName = 'Ahmad Khan';


--table for Cafe Manager
create table CafeManager(
CManagerID int identity(1,1) primary key,
CManagerName varchar(30),
Username varchar(20),
CManagerEmail varchar(20),
CManagerContactno varchar(11),
Password varchar(10),

);


--table for Orders
create table Orders(
OrderID int identity(1,1) primary key,
Customerid int NOT NULL,
IManagerId int NOT NULL,
 payment_status varchar(20) DEFAULT NULL,
 foreign key (Customerid) references Customer(CustomerId),
foreign key (IManagerId) references InventoryManager(IManagerID)
);




INSERT INTO Orders (Customerid, IManagerId)
VALUES (1, 1);


select * from CafeManager
select * from Cashier


	select * from Orders;



alter table Orders
add foreign key (ItemsListID) references OrderedItems(ID);

--table for rating and reviews
create table RatingandReviews(
RatingID int NOT NULL,
Customerid int NOT NULL,
Rating int,
Review varchar(30),
primary key(RatingID),
foreign key (Customerid) references Customer(CustomerId),

);

--table for Cash Register
create table CashRegister(
paymentID int,
foreign key (paymentID) references Payment(PaymentID),
);




--table for Payment
create table Payment(
PaymentID int identity(1,1) PRIMARY KEY,
OrderId int NOT NULL,
Amount int,
AmountPaid int,
CashBacktocustomer int,
 PaymentDate datetime,
foreign key (OrderId) references Orders(OrderID),
);

-- Create a trigger named CheckAmountPaid

CREATE TRIGGER CheckAmountPaid
ON Payment
AFTER INSERT
AS
BEGIN
    -- Check if AmountPaid is less than Amount
    IF (SELECT COUNT(*) FROM inserted WHERE AmountPaid < Amount) > 0
    BEGIN
        -- Perform actions when AmountPaid is less than Amount
        print('AmountPaid cannot be less than Amount');
        ROLLBACK; -- Rollback the transaction to prevent the invalid data from being inserted
    END
END;


INSERT INTO Payment (OrderId, Amount, AmountPaid, CashBacktocustomer)
VALUES (8, 150.00, 100.00, 0);




-- Create a trigger after insert on the Pricing table
CREATE TRIGGER tr_PriceInserted
ON Pricing
AFTER INSERT
AS
BEGIN
    DECLARE @BasePrice int;
    DECLARE @ControlByManager int;

    SELECT @BasePrice = BasePrice, @ControlByManager = ControlByManager
    FROM inserted;

    -- Your logic here to handle the newly inserted base price
    -- For example, you can log the information or perform additional actions

    PRINT 'New base price inserted. BasePrice: ' + CAST(@BasePrice AS varchar(10)) +
          ', ControlByManager: ' + CAST(@ControlByManager AS varchar(10));
END;

INSERT INTO Pricing (BasePrice, ControlByManager)
VALUES (20, 1);




-- Create a trigger after insert on the CategoriesHasItems table
CREATE TRIGGER tr_InvalidCategory
ON CategoriesHasItems
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @InvalidCategoryCount int;

    -- Check if there are any invalid CategoryIDs (not 1, 2, or 3)
    SELECT @InvalidCategoryCount = COUNT(*)
    FROM inserted
    WHERE CategoryID NOT IN (1, 2, 3);

    -- If there are invalid CategoryIDs, perform the desired action
    IF @InvalidCategoryCount > 0
    BEGIN
        -- Your logic here, for example, you can log an error message or rollback the transaction
        -- For demonstration purposes, we are rolling back the transaction and printing a message
        ROLLBACK;
        PRINT 'Invalid CategoryID detected. Rollback initiated.';
    END
END;


-- Insert valid data
INSERT INTO CategoriesHasItems (ItemID, CategoryID)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);

-- Insert invalid data (CategoryID not 1, 2, or 3)
INSERT INTO CategoriesHasItems (ItemID, CategoryID)
VALUES
    (4, 4),
    (5, 1),
    (6, 6);




--table for shedule
create table Shedule(
SheduleID int not null,
shiftType varchar(10),
StartingTime time,
EndingTime time,
primary key(SheduleID),
);

--table for Cashier
create table Cashier(
CashierID int identity(1,1) primary key,
CashierName varchar(30),
Username varchar(10),
CashierContactno varchar(11),
Password varchar(10),
CashierEmail varchar(20),
--ControllerCashRegistered int not null,
--foreign key (ControllerCashRegistered) references CashRegister(RegisterID)
);


-- Insert data into Cashier table with Khan
INSERT INTO Cashier (CashierName, Username, CashierContactno, Password, CashierEmail)
VALUES
    ('Khan', 'khan', '1234567890', '3344', 'khan@example.com');


alter table Cashier
add CashierEmail varchar(50)

INSERT INTO Cashier (CashierName, Username, CashierContactno, Password, CashierEmail)
VALUES ('Ahmad Khan', 'ahmadkhan', '12345678901', '2233', 'ahmad.khan@example.com');


--table for Staff
create table Staff(
--SheduleId int not null,
CafeManagerId int not null,
InventoryManagerId int not null,
CashierId int not null,
--foreign key (SheduleId) references Shedule(SheduleID),
foreign key (CafeManagerId) references CafeManager(CManagerID),
foreign key (InventoryManagerId) references InventoryManager(IManagerID),
foreign key (CashierId) references Cashier(CashierID),
);



--table for menu
create table Menu(
MenuID int identity(1,1) primary key,
MenuName varchar(20),
Description varchar(50),
CafeManagerId int not null,
foreign key (CafeManagerId) references CafeManager(CManagerID)
);

--table for Categories
create table Categories(
CategoryID int not null,
CategoryName varchar(30),
CategoryDes varchar(50),
menuId int not null,
primary key(CategoryID),
foreign key (menuId) references Menu(MenuID)
);
select * from Categories;
select * from menu;
select * from Items

create table CategoriesHasItems(
    ItemID int not null,
    CategoryID int not null,
    primary key(ItemID, CategoryID),
    foreign key (ItemID) references Items(ItemID),
    foreign key (CategoryID) references Categories(CategoryID)
);

--table for MenuHasCategories
create table MenuHasCategories(
menuId int not null,
categoryId int not null,
foreign key (menuId) references Menu(MenuID),
foreign key (categoryId) references Categories(CategoryID)
);

--table for cafe
create table Cafe(
CafeID int not null,
CafeName varchar(30),
CafeLocation varchar(30),
CafeManagerId int not null,
InventoryManagerId int not null,
CashierId int not null,
ServeMenuid int not null,
Description varchar(50),
primary key(CafeID),
foreign key (CafeManagerId) references CafeManager(CManagerID),
foreign key (InventoryManagerId) references InventoryManager(IManagerID),
foreign key (ServeMenuid) references Menu(MenuId),
);

--table for pricing of item
create table Pricing(
PricingID int identity(1,1) primary key,
BasePrice int,
ControlBymanager int not null,
foreign key (ControlBymanager) references CafeManager(CManagerID)
);

select *from items
-- Alter the table to change ItemID to identity column

ALTER TABLE Items
ADD ItemID int identity(1,1) primary key;

--table for items in cafe
create table Items(
ItemID int not null,
ItemName varchar(15),
ItemDes varchar(30),
ItemAvailibility varchar(10),
priceid int not null,
quantity int,
primary key(ItemID),
foreign key (priceid) references Pricing(PricingID)
);

-- SQL query to retrieve items for a specific category with quantity
SELECT Items.ItemID, Items.ItemName, Items.ItemDes, Items.ItemAvailibility, Items.priceid, Items.quantity
FROM Items
INNER JOIN CategoriesHasItems ON Items.ItemID = CategoriesHasItems.ItemID
INNER JOIN Categories ON CategoriesHasItems.CategoryID = Categories.CategoryID
WHERE Categories.CategoryName = 'Beverages';


-- Drop the foreign key constraint
ALTER TABLE Items
add quantity int;
select * from Items

delete from Items

UPDATE Items
SET Quantity = 10  -- Replace 10 with the desired quantity
WHERE ItemID IN (1, 2, 3);


ALTER TABLE Items
ADD FOREIGN KEY (priceid) REFERENCES Pricing(PricingID);

ALTER TABLE Enrollement
ADD FOREIGN KEY (programID) REFERENCES Program(ProgramID);

--table for Inventory
create table Inventory(
InventoryID int not null,
InventoryName varchar(30),
InventoryManagerid int not null,
MinimumStockLevel int,
QuantityInHand int,
ExpirationDate date,
primary key(InventoryID),
foreign key (InventoryManagerid) references InventoryManager(IManagerID)
);
INSERT INTO CafeManager VALUES ('Moeed Asif', 'moeed00', 'moeed@gmail.com', '03255146456', 'moeed123');
select * from CafeManager
select * from items

create table CategoriesHasItems(
    ItemID int not null,
    CategoryID int not null,
    primary key(ItemID, CategoryID),
    foreign key (ItemID) references Items(ItemID),
    foreign key (CategoryID) references Categories(CategoryID)
);

select * from Items
-- Insert data into Menu table
insert into Menu (MenuName, Description, CafeManagerId) values 
('Main Menu', 'Main menu items', 1);

-- Insert data into Categories table
insert into Categories (CategoryID,CategoryName, CategoryDes, menuId) values
(1,'Food', 'Delicious main courses', 1),
(2,'Desserts', 'Sweet treats for dessert', 1),
(3,'Beverages', 'Refreshing drinks', 1);

select * from Items
-- Insert data into Items table
insert into Items (ItemName, ItemDes, ItemAvailibility, priceid,quantity) values
('Burger', 'Classic beef burger', 'Available', 1,10),
('Cheesecake', 'Creamy cheesecake', 'Available', 2,20),
('Iced Tea', 'Refreshing iced tea', 'Available', 3,30);
select * from Categories;

-- Insert data into CategoriesHasItems table
insert into CategoriesHasItems (ItemID, CategoryID) values
(10, 1), -- Burger belongs to Food category
(11, 2), -- Cheesecake belongs to Desserts category
(12, 3); -- Iced Tea belongs to Beverages category
select * from Items
select * from CategoriesHasItems	
delete from CategoriesHasItems
-- Insert data into Pricing table
insert into Pricing (BasePrice, ControlBymanager) values
(10, 1), -- Base price for Food items controlled by Cafe Manager 1
(15, 1),  -- Base price for Desserts controlled by Cafe Manager 1
(20, 1);  -- Base price for Beverages controlled by Cafe Manager 1
