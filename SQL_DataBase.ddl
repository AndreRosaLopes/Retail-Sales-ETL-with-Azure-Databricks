-- Simulation of OLTP (Online Transaction Processing) of Jan/2025
-- Create Customers Table
CREATE TABLE RETAIL.CUSTOMERS (
    Customer_ID INT PRIMARY KEY,
    Social_Security_Number VARCHAR(50),
    Name VARCHAR(100),
    Email VARCHAR(150),
    Phone VARCHAR(15),
    Address VARCHAR(200),
    Zip_Code VARCHAR(10)
);

-- Create Brands Table
CREATE TABLE RETAIL.BRANDS (
    Brand_ID INT PRIMARY KEY,
    Brand_Description VARCHAR(100)
);

-- Create Categories Table
CREATE TABLE RETAIL.CATEGORIES (
    Category_ID INT PRIMARY KEY,
    Category_Description VARCHAR(100)
);

-- Create Products Table
CREATE TABLE RETAIL.PRODUCTS (
    Product_ID INT PRIMARY KEY,
    Brand_ID INT,
    Category_ID INT,
    SKU VARCHAR(50),
    Product_Description VARCHAR(100),
    Unit_Price DECIMAL(10,2),
    FOREIGN KEY (Brand_ID) REFERENCES RETAIL.BRANDS(Brand_ID),
    FOREIGN KEY (Category_ID) REFERENCES RETAIL.CATEGORIES(Category_ID)
);

-- Create Stores Table
CREATE TABLE RETAIL."STORES" (
    Store_ID INT PRIMARY KEY,
    Store_Name VARCHAR(100),
    Store_District VARCHAR(100),
    Store_Region VARCHAR(100)
);

-- Create Promotions Table
CREATE TABLE RETAIL.PROMOTIONS (
    Promotion_ID INT PRIMARY KEY,
    Product_ID INT,
    Promotion_Name VARCHAR(255),
    Promotion_Media_Type VARCHAR(50),
    Promotion_Begin_Date DATE,
    Promotion_End_Date DATE,
    Discount_Unit_Price DECIMAL(10, 2),
    FOREIGN KEY (Product_ID) REFERENCES RETAIL.PRODUCTS(Product_ID)
);

-- Create Payment Methods Table
CREATE TABLE RETAIL.PAYMENT_METHODS (
    Payment_Method_ID INT PRIMARY KEY,
    Payment_Method_Description VARCHAR(50),
    Payment_Method_Group VARCHAR(50)
);

-- Create Inventory Table
CREATE TABLE RETAIL.INVENTORY (
    Inventory_ID INT PRIMARY KEY,
    Product_ID INT,
    Store_ID INT,
    Stock_Quantity INT,
    Average_Unit_Cost DECIMAL(10,2),
    FOREIGN KEY (Product_ID) REFERENCES RETAIL.PRODUCTS(Product_ID),
    FOREIGN KEY (Store_ID) REFERENCES RETAIL.STORES(Store_ID)
);

-- Create Sales Table
CREATE TABLE RETAIL.SALES (
    Sale_ID INT PRIMARY KEY,                           -- Primary key
    Customer_ID INT,                                   -- Foreign key referencing the CUSTOMERS table
    Store_ID INT,                                      -- Foreign key referencing the STORES table
    Payment_Method_ID INT,                             -- Foreign key referencing the PAYMENT_METHODS table
    Sales_Date DATE,                                   -- Date of the transaction
    FOREIGN KEY (Customer_ID) REFERENCES CUSTOMERS(Customer_ID),
    FOREIGN KEY (Store_ID) REFERENCES RETAIL.STORES(Store_ID),
    FOREIGN KEY (Payment_Method_ID) REFERENCES RETAIL.PAYMENT_METHODS(Payment_Method_ID)
);


-- Create Transactions Table
CREATE TABLE RETAIL.TRANSACTION_ITEM (
    Transaction_ID INT PRIMARY KEY,                    -- Primary key
    Sale_ID INT,                                       -- Foreign key referencing the SALES table
    Product_ID INT,                                    -- Foreign key referencing the PRODUCTS table
    Transaction_Quantity INT,                          -- Quantity of the product in the transaction
    FOREIGN KEY (Sale_ID) REFERENCES RETAIL.SALES(Sale_ID),
    FOREIGN KEY (Product_ID) REFERENCES RETAIL.PRODUCTS(Product_ID)
);


-- Insert Sample Data

-- Insert Customers (20 customers)
INSERT INTO CUSTOMERS (Customer_ID, Social_Security_Number, Name, Email, Phone, Address, Zip_Code) VALUES
(1, '123-45-6789', 'John Doe', 'johndoe@example.com', '1234567890', '123 Elm St, NY', '10001'),
(2, '987-65-4321', 'Jane Smith', 'janesmith@example.com', '0987654321', '456 Oak St, LA', '90001'),
(3, '111-22-3333', 'Michael Johnson', 'michaelj@example.com', '1112223333', '789 Pine St, TX', '73301'),
(4, '444-55-6666', 'Emily Davis', 'emilyd@example.com', '4445556666', '321 Cedar St, IL', '60007'),
(5, '777-88-9999', 'William Brown', 'williamb@example.com', '7778889999', '654 Birch St, FL', '33101'),
(6, '222-33-4444', 'Olivia Wilson', 'oliviaw@example.com', '2223334444', '987 Maple St, CO', '80202'),
(7, '555-66-7777', 'Ethan Moore', 'ethanm@example.com', '5556667777', '432 Pine St, NV', '89501'),
(8, '666-77-8888', 'Sophia Taylor', 'sophiat@example.com', '6667778888', '123 Oak St, CA', '90003'),
(9, '777-88-9999', 'Liam Harris', 'liamh@example.com', '7778889999', '654 Elm St, OR', '97201'),
(10, '888-99-0000', 'Ava Clark', 'avac@example.com', '8889990000', '321 Birch St, WA', '98001'),
(11, '111-22-3334', 'James Lewis', 'jamesl@example.com', '1112223334', '222 Maple St, AZ', '85001'),
(12, '333-44-5555', 'Isabella Walker', 'isabellaw@example.com', '3334445555', '543 Pine St, GA', '30301'),
(13, '444-55-6667', 'Alexander Allen', 'alexander.a@example.com', '4445556667', '765 Oak St, NC', '27601'),
(14, '555-66-7778', 'Mia King', 'miak@example.com', '5556667778', '876 Cedar St, MI', '48201'),
(15, '666-77-8889', 'Daniel Scott', 'daniels@example.com', '6667778889', '987 Birch St, OH', '44101'),
(16, '777-88-9990', 'Charlotte Harris', 'charlotte.h@example.com', '7778889990', '432 Cedar St, MA', '02115'),
(17, '888-99-0001', 'Benjamin Wright', 'benjaminw@example.com', '8889990001', '654 Oak St, PA', '19103'),
(18, '999-00-1112', 'Amelia Young', 'amelia.y@example.com', '9990001112', '321 Maple St, WI', '53202'),
(19, '000-11-2223', 'Lucas Martinez', 'lucasm@example.com', '0001112223', '876 Pine St, MN', '55101'),
(20, '111-22-3334', 'Harper Lee', 'harperl@example.com', '9990001112', '543 Oak St, NJ', '07305');


-- Insert Brands (Example 5 brands)
INSERT INTO BRANDS (Brand_ID, Brand_Description) VALUES
(1, 'Brand A'),
(2, 'Brand B'),
(3, 'Brand C'),
(4, 'Brand D'),
(5, 'Brand E');

-- Insert Categories (Example 5 categories)
INSERT INTO CATEGORIES (Category_ID, Category_Description) VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Furniture'),
(4, 'Food'),
(5, 'Sports');

-- Insert Products (20 products)
INSERT INTO PRODUCTS (Product_ID, Brand_ID, Category_ID, SKU, Product_Description, Unit_Price) VALUES
(1, 1, 1, 'ELEC001', 'Smartphone XYZ', 499.99),
(2, 2, 1, 'ELEC002', 'Laptop Pro 15"', 1299.99),
(3, 3, 1, 'ELEC003', 'Wireless Headphones', 89.99),
(4, 4, 1, 'ELEC004', '4K LED TV 55"', 599.99),
(5, 5, 1, 'ELEC005', 'Bluetooth Speaker', 49.99),
(6, 1, 2, 'CLOTH001', 'T-Shirt Classic', 19.99),
(7, 2, 2, 'CLOTH002', 'Jeans Slim Fit', 39.99),
(8, 3, 2, 'CLOTH003', 'Jacket Winter', 89.99),
(9, 4, 2, 'CLOTH004', 'Sneakers Sporty', 59.99),
(10, 5, 2, 'CLOTH005', 'Hoodie Comfortable', 34.99),
(11, 1, 3, 'FURN001', 'Wooden Dining Table', 249.99),
(12, 2, 3, 'FURN002', 'Office Chair Ergonomic', 179.99),
(13, 3, 3, 'FURN003', 'Sofa Modular', 899.99),
(14, 4, 3, 'FURN004', 'Bookshelf Modern', 149.99),
(15, 5, 3, 'FURN005', 'Coffee Table Glass', 129.99),
(16, 1, 4, 'FOOD001', 'Organic Almonds 500g', 9.99),
(17, 2, 4, 'FOOD002', 'Vegan Protein Powder 1kg', 29.99),
(18, 3, 4, 'FOOD003', 'Chia Seeds 250g', 5.99),
(19, 4, 4, 'FOOD004', 'Gluten-Free Pasta 400g', 4.49),
(20, 5, 4, 'FOOD005', 'Organic Green Tea 20 bags', 7.99);

-- Insert Inventory (5 stores, each with at least 15 products)
INSERT INTO INVENTORY (Inventory_ID, Product_ID, Store_ID, Stock_Quantity, Average_Unit_Cost) VALUES
(1, 1, 1, 30, 350.00), -- Store 1, Product 1 (Smartphone XYZ)
(2, 2, 1, 20, 850.00), -- Store 1, Product 2 (Laptop Pro 15")
(3, 3, 1, 50, 45.00),  -- Store 1, Product 3 (Wireless Headphones)
(4, 4, 1, 15, 400.00), -- Store 1, Product 4 (4K LED TV 55")
(5, 5, 1, 60, 35.00),  -- Store 1, Product 5 (Bluetooth Speaker)
(6, 6, 1, 40, 10.00),  -- Store 1, Product 6 (T-Shirt Classic)
(7, 7, 1, 25, 25.00),  -- Store 1, Product 7 (Jeans Slim Fit)
(8, 8, 1, 30, 60.00),  -- Store 1, Product 8 (Jacket Winter)
(9, 9, 1, 15, 45.00),  -- Store 1, Product 9 (Sneakers Sporty)
(10, 10, 1, 35, 25.00), -- Store 1, Product 10 (Hoodie Comfortable)
(11, 11, 1, 10, 120.00), -- Store 1, Product 11 (Wooden Dining Table)
(12, 12, 1, 20, 80.00),  -- Store 1, Product 12 (Office Chair Ergonomic)
(13, 13, 1, 15, 400.00), -- Store 1, Product 13 (Sofa Modular)
(14, 14, 1, 10, 75.00),  -- Store 1, Product 14 (Bookshelf Modern)
(15, 15, 1, 25, 60.00),  -- Store 1, Product 15 (Coffee Table Glass)

(16, 1, 2, 25, 350.00),  -- Store 2, Product 1 (Smartphone XYZ)
(17, 2, 2, 30, 850.00),  -- Store 2, Product 2 (Laptop Pro 15")
(18, 3, 2, 40, 45.00),   -- Store 2, Product 3 (Wireless Headphones)
(19, 4, 2, 10, 400.00),  -- Store 2, Product 4 (4K LED TV 55")
(20, 5, 2, 50, 35.00),   -- Store 2, Product 5 (Bluetooth Speaker)
(21, 6, 2, 30, 10.00),   -- Store 2, Product 6 (T-Shirt Classic)
(22, 7, 2, 35, 25.00),   -- Store 2, Product 7 (Jeans Slim Fit)
(23, 8, 2, 45, 60.00),   -- Store 2, Product 8 (Jacket Winter)
(24, 9, 2, 20, 45.00),   -- Store 2, Product 9 (Sneakers Sporty)
(25, 10, 2, 40, 25.00),  -- Store 2, Product 10 (Hoodie Comfortable)
(26, 11, 2, 15, 120.00), -- Store 2, Product 11 (Wooden Dining Table)
(27, 12, 2, 25, 80.00),  -- Store 2, Product 12 (Office Chair Ergonomic)
(28, 13, 2, 10, 400.00), -- Store 2, Product 13 (Sofa Modular)
(29, 14, 2, 20, 75.00),  -- Store 2, Product 14 (Bookshelf Modern)
(30, 15, 2, 30, 60.00),  -- Store 2, Product 15 (Coffee Table Glass)

(31, 1, 3, 40, 350.00),  -- Store 3, Product 1 (Smartphone XYZ)
(32, 2, 3, 50, 850.00),  -- Store 3, Product 2 (Laptop Pro 15")
(33, 3, 3, 60, 45.00),   -- Store 3, Product 3 (Wireless Headphones)
(34, 4, 3, 30, 400.00),  -- Store 3, Product 4 (4K LED TV 55")
(35, 5, 3, 70, 35.00),   -- Store 3, Product 5 (Bluetooth Speaker)
(36, 6, 3, 50, 10.00),   -- Store 3, Product 6 (T-Shirt Classic)
(37, 7, 3, 45, 25.00),   -- Store 3, Product 7 (Jeans Slim Fit)
(38, 8, 3, 35, 60.00),   -- Store 3, Product 8 (Jacket Winter)
(39, 9, 3, 15, 45.00),   -- Store 3, Product 9 (Sneakers Sporty)
(40, 10, 3, 30, 25.00),  -- Store 3, Product 10 (Hoodie Comfortable)
(41, 11, 3, 25, 120.00), -- Store 3, Product 11 (Wooden Dining Table)
(42, 12, 3, 15, 80.00),  -- Store 3, Product 12 (Office Chair Ergonomic)
(43, 13, 3, 25, 400.00), -- Store 3, Product 13 (Sofa Modular)
(44, 14, 3, 20, 75.00),  -- Store 3, Product 14 (Bookshelf Modern)
(45, 15, 3, 40, 60.00),  -- Store 3, Product 15 (Coffee Table Glass)

(46, 1, 4, 30, 350.00),  -- Store 4, Product 1 (Smartphone XYZ)
(47, 2, 4, 40, 850.00),  -- Store 4, Product 2 (Laptop Pro 15")
(48, 3, 4, 50, 45.00),   -- Store 4, Product 3 (Wireless Headphones)
(49, 4, 4, 25, 400.00),  -- Store 4, Product 4 (4K LED TV 55")
(50, 5, 4, 55, 35.00),   -- Store 4, Product 5 (Bluetooth Speaker)
(51, 6, 4, 35, 10.00),   -- Store 4, Product 6 (T-Shirt Classic)
(52, 7, 4, 40, 25.00),   -- Store 4, Product 7 (Jeans Slim Fit)
(53, 8, 4, 30, 60.00),   -- Store 4, Product 8 (Jacket Winter)
(54, 9, 4, 20, 45.00),   -- Store 4, Product 9 (Sneakers Sporty)
(55, 10, 4, 30, 25.00),  -- Store 4, Product 10 (Hoodie Comfortable)
(56, 11, 4, 20, 120.00), -- Store 4, Product 11 (Wooden Dining Table)
(57, 12, 4, 30, 80.00),  -- Store 4, Product 12 (Office Chair Ergonomic)
(58, 13, 4, 15, 400.00), -- Store 4, Product 13 (Sofa Modular)
(59, 14, 4, 25, 75.00),  -- Store 4, Product 14 (Bookshelf Modern)
(60, 15, 4, 35, 60.00),  -- Store 4, Product 15 (Coffee Table Glass)

(61, 1, 5, 50, 350.00),  -- Store 5, Product 1 (Smartphone XYZ)
(62, 2, 5, 60, 850.00),  -- Store 5, Product 2 (Laptop Pro 15")
(63, 3, 5, 70, 45.00),   -- Store 5, Product 3 (Wireless Headphones)
(64, 4, 5, 30, 400.00),  -- Store 5, Product 4 (4K LED TV 55")
(65, 5, 5, 80, 35.00),   -- Store 5, Product 5 (Bluetooth Speaker)
(66, 6, 5, 50, 10.00),   -- Store 5, Product 6 (T-Shirt Classic)
(67, 7, 5, 45, 25.00),   -- Store 5, Product 7 (Jeans Slim Fit)
(68, 8, 5, 40, 60.00),   -- Store 5, Product 8 (Jacket Winter)
(69, 9, 5, 20, 45.00),   -- Store 5, Product 9 (Sneakers Sporty)
(70, 10, 5, 40, 25.00),  -- Store 5, Product 10 (Hoodie Comfortable)
(71, 11, 5, 30, 120.00), -- Store 5, Product 11 (Wooden Dining Table)
(72, 12, 5, 25, 80.00),  -- Store 5, Product 12 (Office Chair Ergonomic)
(73, 13, 5, 35, 400.00), -- Store 5, Product 13 (Sofa Modular)
(74, 14, 5, 30, 75.00),  -- Store 5, Product 14 (Bookshelf Modern)
(75, 15, 5, 50, 60.00);  -- Store 5, Product 15 (Coffee Table Glass)



-- Insert Stores (5 stores)
INSERT INTO "STORES" (Store_ID, Store_Name, Store_District, Store_Region) VALUES
(1, 'Store 1', 'District A', 'Region 1'),
(2, 'Store 2', 'District B', 'Region 2'),
(3, 'Store 3', 'District C', 'Region 3'),
(4, 'Store 4', 'District D', 'Region 4'),
(5, 'Store 5', 'District E', 'Region 5');

-- Insert Promotions (5 products on discount from 5% to 20%)
INSERT INTO PROMOTIONS (Promotion_ID, Product_ID, Promotion_Name, Promotion_Media_Type, Promotion_Begin_Date, Promotion_End_Date, Discount_Unit_Price) VALUES
(1, 1, 'Smartphone XYZ Discount', 'Online', '2025-02-20', '2025-03-20', 474.99),  -- 5% de desconto no Smartphone XYZ
(2, 3, 'Wireless Headphones Discount', 'Online', '2025-02-20', '2025-03-15', 76.49),  -- 15% de desconto nos Wireless Headphones
(3, 10, 'Hoodie Comfortable Sale', 'In-store', '2025-02-20', '2025-02-28', 31.49),    -- 10% de desconto no Hoodie Comfortable
(4, 15, 'Coffee Table Glass Offer', 'In-store', '2025-02-20', '2025-03-05', 116.49);   -- 10% de desconto no Coffee Table Glass


-- Insert Payment Methods
INSERT INTO PAYMENT_METHODS (Payment_Method_ID, Payment_Method_Description, Payment_Method_Group) VALUES
(1, 'Credit Card', 'Electronic'),
(2, 'PayPal', 'Electronic'),
(3, 'Cash', 'Traditional'),
(4, 'Bank Transfer', 'Traditional');

INSERT INTO TRANSACTION_ITEM (Transaction_ID, Sale_ID, Product_ID, Transaction_Quantity) VALUES
(1, 1, 7, 3, 954.42),
(2, 1, 20, 8, 1623.76),
(3, 1, 11, 10, 4335.4),
(4, 1, 9, 5, 156.35),
(5, 1, 5, 1, 68.17),
(6, 1, 4, 8, 3935.36),
(7, 2, 17, 8, 199.92),
(8, 3, 20, 6, 1425.12),
(9, 3, 9, 5, 2157.65),
(10, 3, 7, 3, 177.78),
(11, 3, 1, 1, 206.15),
(12, 4, 16, 2, 759.02),
(13, 4, 17, 3, 529.62),
(14, 4, 11, 6, 1149.24),
(15, 4, 1, 1, 27.75),
(16, 4, 7, 5, 2357.35),
(17, 5, 1, 1, 443.28),
(18, 6, 1, 1, 201.54),
(19, 6, 10, 1, 339.96),
(20, 6, 15, 1, 324.24),
(21, 6, 17, 2, 783.08),
(22, 6, 14, 4, 210.2),
(23, 6, 8, 8, 2802.0),
(24, 7, 16, 1, 148.78),
(25, 7, 6, 8, 2422.72),
(26, 7, 5, 1, 284.86),
(27, 7, 14, 2, 989.82),
(28, 7, 4, 2, 566.06),
(29, 7, 9, 5, 339.05),
(30, 7, 17, 3, 1027.29),
(31, 7, 15, 1, 427.64),
(32, 7, 18, 9, 1600.74),
(33, 8, 10, 1, 16.35),
(34, 9, 4, 5, 1706.4),
(35, 9, 13, 10, 3772.4),
(36, 10, 16, 6, 2809.2),
(37, 10, 6, 7, 1381.1),
(38, 10, 7, 8, 3496.4),
(39, 10, 13, 4, 671.72),
(40, 10, 8, 5, 1489.45),
(41, 10, 1, 1, 141.27),
(42, 11, 18, 1, 189.31),
(43, 12, 6, 2, 90.22),
(44, 13, 14, 8, 3440.96),
(45, 14, 7, 7, 2366.7),
(46, 15, 2, 1, 421.68),
(47, 15, 6, 9, 3275.01),
(48, 15, 9, 6, 2719.68),
(49, 15, 8, 4, 94.8),
(50, 16, 7, 8, 1932.96),
(51, 17, 9, 5, 79.0),
(52, 18, 3, 9, 4208.67),
(53, 18, 15, 1, 442.58),
(54, 18, 14, 2, 985.16),
(55, 18, 20, 1, 410.6),
(56, 18, 1, 1, 190.41),
(57, 18, 11, 6, 581.64),
(58, 18, 4, 9, 4376.79),
(59, 18, 6, 8, 2592.0),
(60, 19, 17, 5, 417.95),
(61, 20, 19, 6, 2352.3),
(62, 21, 20, 1, 185.72),
(63, 21, 4, 7, 1167.11),
(64, 22, 10, 1, 467.0),
(65, 23, 10, 1, 5.64),
(66, 24, 19, 6, 822.0),
(67, 25, 16, 6, 2940.06),
(68, 26, 14, 7, 2178.19),
(69, 27, 18, 6, 1613.16),
(70, 28, 10, 1, 103.17),
(71, 28, 8, 4, 520.44),
(72, 28, 7, 6, 1377.78),
(73, 28, 14, 4, 863.04),
(74, 28, 19, 7, 2388.33),
(75, 28, 3, 8, 2455.44),
(76, 28, 9, 2, 821.6),
(77, 29, 2, 1, 484.83),
(78, 29, 5, 1, 379.62),
(79, 29, 14, 8, 2086.16),
(80, 29, 1, 1, 408.66),
(81, 29, 18, 2, 525.58),
(82, 29, 13, 10, 82.8),
(83, 30, 1, 1, 438.21),
(84, 31, 4, 6, 2405.46),
(85, 31, 16, 1, 138.86),
(86, 31, 2, 6, 2518.68),
(87, 31, 10, 1, 318.97),
(88, 31, 17, 3, 276.51),
(89, 31, 5, 1, 236.1),
(90, 31, 18, 2, 894.7),
(91, 31, 12, 4, 1401.6),
(92, 31, 19, 3, 528.36),
(93, 32, 14, 3, 142.32),
(94, 33, 8, 6, 1420.2),
(95, 34, 5, 1, 470.63),
(96, 35, 20, 4, 566.0),
(97, 36, 12, 2, 208.58),
(98, 37, 11, 8, 2138.4),
(99, 37, 2, 10, 2077.5),
(100, 37, 13, 2, 171.84),
(101, 37, 15, 1, 321.25),
(102, 37, 3, 3, 424.71),
(103, 37, 1, 1, 447.03),
(104, 37, 20, 5, 1117.75),
(105, 37, 5, 1, 368.98),
(106, 38, 4, 5, 228.7),
(107, 38, 18, 5, 1147.55),
(108, 38, 9, 5, 864.2),
(109, 38, 20, 7, 1014.93),
(110, 38, 19, 4, 1301.28),
(111, 38, 3, 1, 276.17),
(112, 38, 8, 8, 2196.48),
(113, 38, 5, 1, 204.57),
(114, 38, 1, 1, 491.01),
(115, 38, 14, 4, 1417.48),
(116, 39, 7, 10, 3608.2),
(117, 39, 9, 6, 385.02),
(118, 39, 6, 1, 58.07),
(119, 39, 15, 1, 214.99),
(120, 39, 17, 8, 535.28),
(121, 39, 4, 5, 1521.9),
(122, 40, 10, 1, 482.33),
(123, 41, 17, 2, 379.44),
(124, 42, 5, 1, 117.72),
(125, 43, 3, 1, 443.01),
(126, 43, 1, 1, 156.61),
(127, 43, 8, 8, 1462.16),
(128, 43, 12, 8, 520.8),
(129, 43, 11, 2, 325.22),
(130, 43, 5, 1, 43.18),
(131, 44, 8, 8, 731.92),
(132, 45, 13, 1, 161.21),
(133, 46, 3, 3, 883.83),
(134, 47, 5, 1, 446.91),
(135, 48, 3, 5, 188.15),
(136, 49, 17, 6, 1286.7),
(137, 50, 9, 7, 102.06),
(138, 51, 9, 2, 94.2),
(139, 52, 12, 10, 4866.0),
(140, 53, 5, 1, 254.44),
(141, 54, 7, 8, 2818.4),
(142, 54, 15, 1, 117.93),
(143, 54, 16, 3, 1283.19),
(144, 54, 12, 5, 814.15),
(145, 54, 1, 1, 130.14),
(146, 55, 17, 10, 1128.9),
(147, 56, 1, 1, 454.28),
(148, 57, 6, 10, 2924.7),
(149, 58, 14, 1, 374.01),
(150, 59, 16, 5, 884.6),
(151, 59, 9, 6, 330.06),
(152, 59, 2, 5, 1286.0),
(153, 59, 12, 10, 4327.4),
(154, 59, 7, 9, 1499.13),
(155, 59, 18, 10, 1175.6),
(156, 59, 20, 5, 916.2),
(157, 60, 2, 3, 1371.93),
(158, 60, 19, 7, 1162.42),
(159, 60, 16, 7, 2041.48),
(160, 60, 15, 1, 414.7),
(161, 60, 12, 5, 1108.55),
(162, 60, 7, 5, 1434.3),
(163, 60, 6, 3, 724.38),
(164, 60, 10, 1, 216.99),
(165, 60, 5, 1, 455.68),
(166, 61, 14, 7, 2087.26),
(167, 62, 16, 5, 1072.2),
(168, 63, 5, 1, 357.07),
(169, 64, 8, 2, 337.34),
(170, 64, 16, 4, 288.72),
(171, 64, 2, 5, 2266.25),
(172, 64, 7, 9, 4410.54),
(173, 65, 1, 1, 142.23),
(174, 65, 5, 1, 77.18),
(175, 65, 7, 8, 2154.0),
(176, 65, 2, 8, 3421.36),
(177, 65, 9, 9, 2493.27),
(178, 65, 17, 1, 381.34),
(179, 66, 20, 4, 973.12),
(180, 67, 15, 1, 130.42),
(181, 67, 1, 1, 133.15),
(182, 67, 20, 10, 429.3),
(183, 67, 3, 3, 614.22),
(184, 67, 11, 9, 3684.78),
(185, 67, 14, 1, 211.05),
(186, 67, 18, 2, 603.0),
(187, 67, 12, 4, 1196.28),
(188, 68, 7, 3, 293.22),
(189, 68, 20, 5, 886.15),
(190, 68, 15, 1, 64.33),
(191, 68, 5, 1, 153.8),
(192, 68, 10, 1, 249.11),
(193, 68, 9, 10, 2158.1),
(194, 68, 2, 3, 1414.89),
(195, 68, 19, 8, 2356.08),
(196, 68, 6, 10, 4578.7),
(197, 68, 11, 3, 134.64),
(198, 69, 15, 1, 174.96),
(199, 70, 2, 6, 2486.16),
(200, 71, 16, 7, 885.78),
(201, 72, 10, 1, 440.86),
(202, 73, 11, 8, 3493.04),
(203, 74, 8, 4, 1435.12),
(204, 75, 5, 1, 148.06),
(205, 76, 6, 6, 428.94),
(206, 77, 12, 9, 1180.26),
(207, 78, 9, 5, 1104.3),
(208, 78, 5, 1, 207.73),
(209, 78, 8, 10, 272.1),
(210, 78, 12, 6, 1555.5),
(211, 78, 17, 4, 837.32),
(212, 79, 17, 5, 295.75),
(213, 79, 11, 10, 3195.6),
(214, 79, 9, 10, 1452.3),
(215, 79, 16, 1, 416.29),
(216, 80, 19, 7, 1586.83),
(217, 81, 13, 7, 455.0),
(218, 81, 5, 1, 65.91),
(219, 81, 20, 4, 777.08),
(220, 81, 7, 1, 79.97),
(221, 81, 12, 7, 1319.71),
(222, 82, 7, 2, 381.56),
(223, 82, 14, 1, 286.09),
(224, 82, 5, 1, 28.11),
(225, 83, 16, 5, 2030.5),
(226, 84, 8, 4, 779.28),
(227, 84, 18, 7, 1562.89),
(228, 85, 14, 9, 2234.61),
(229, 85, 8, 7, 3351.11),
(230, 85, 7, 5, 124.0),
(231, 85, 13, 10, 3779.8),
(232, 85, 12, 9, 985.5),
(233, 86, 8, 6, 2305.14),
(234, 86, 2, 3, 706.77),
(235, 86, 18, 5, 850.1),
(236, 86, 12, 9, 3972.6),
(237, 86, 19, 1, 185.05),
(238, 86, 5, 1, 394.84),
(239, 87, 3, 1, 218.04),
(240, 87, 1, 1, 87.49),
(241, 87, 16, 4, 1997.2),
(242, 87, 19, 6, 216.72),
(243, 87, 20, 10, 3877.8),
(244, 88, 8, 8, 2975.92),
(245, 89, 2, 1, 150.11),
(246, 89, 15, 1, 261.48),
(247, 89, 17, 10, 379.9),
(248, 89, 7, 10, 2733.1),
(249, 89, 11, 6, 2821.56),
(250, 89, 18, 10, 4637.2),
(251, 89, 19, 1, 228.1),
(252, 89, 14, 8, 3734.88),
(253, 89, 4, 4, 1535.72),
(254, 90, 16, 8, 3998.0),
(255, 91, 9, 8, 126.24),
(256, 91, 12, 4, 1317.16),
(257, 91, 4, 1, 351.51),
(258, 91, 1, 1, 393.47),
(259, 91, 13, 2, 343.1),
(260, 91, 6, 3, 207.0),
(261, 92, 14, 3, 1403.73),
(262, 92, 9, 7, 485.8),
(263, 92, 1, 1, 232.29),
(264, 92, 12, 7, 1375.64),
(265, 92, 20, 5, 2146.15),
(266, 92, 16, 7, 2336.88),
(267, 93, 17, 1, 413.6),
(268, 93, 2, 2, 834.02),
(269, 93, 19, 6, 1536.54),
(270, 93, 6, 1, 249.29),
(271, 94, 18, 2, 878.22),
(272, 95, 14, 8, 2154.96),
(273, 95, 11, 5, 1403.35),
(274, 95, 16, 2, 897.76),
(275, 95, 7, 7, 2007.67),
(276, 96, 1, 1, 40.7),
(277, 96, 10, 1, 323.88),
(278, 96, 2, 5, 1458.25),
(279, 96, 4, 10, 4572.6),
(280, 96, 16, 2, 711.76),
(281, 97, 19, 4, 478.2),
(282, 97, 13, 10, 3556.0),
(283, 98, 9, 9, 920.34),
(284, 99, 8, 3, 1391.7),
(285, 99, 4, 1, 484.61),
(286, 99, 11, 4, 1418.64),
(287, 99, 17, 6, 623.22),
(288, 99, 2, 9, 1442.07),
(289, 99, 20, 8, 1126.16),
(290, 100, 12, 1, 192.57),
(291, 100, 8, 10, 3855.9),
(292, 100, 4, 1, 299.82),
(293, 100, 20, 4, 1314.0),
(294, 100, 7, 8, 1185.68),
(295, 100, 1, 1, 306.5),
(296, 100, 10, 1, 251.21),
(297, 100, 11, 5, 661.0),
(298, 100, 14, 2, 448.5),
(299, 100, 9, 2, 218.94),
(300, 101, 16, 1, 159.01),
(301, 101, 9, 8, 1640.32),
(302, 102, 9, 4, 147.4),
(303, 103, 6, 6, 1841.82),
(304, 104, 9, 5, 64.15),
(305, 105, 9, 6, 954.66),
(306, 106, 4, 6, 1650.18),
(307, 106, 13, 9, 2945.52),
(308, 106, 9, 5, 981.6),
(309, 106, 6, 1, 165.77),
(310, 106, 14, 8, 2214.0),
(311, 107, 8, 3, 84.09),
(312, 108, 14, 6, 157.92),
(313, 109, 2, 10, 137.8),
(314, 109, 11, 5, 216.5),
(315, 110, 14, 3, 251.25),
(316, 110, 19, 3, 434.55),
(317, 110, 12, 6, 2583.66),
(318, 110, 18, 8, 3312.4),
(319, 110, 1, 1, 325.31),
(320, 110, 2, 3, 759.78),
(321, 110, 4, 8, 270.48),
(322, 110, 8, 2, 315.92),
(323, 110, 6, 6, 2253.84),
(324, 110, 15, 1, 291.92),
(325, 111, 20, 10, 2510.4),
(326, 111, 16, 4, 718.56),
(327, 111, 14, 10, 2008.1),
(328, 111, 19, 5, 1793.8),
(329, 111, 1, 1, 483.87),
(330, 111, 15, 1, 410.68),
(331, 111, 2, 5, 1922.6),
(332, 111, 9, 1, 30.13),
(333, 111, 8, 1, 388.94),
(334, 112, 10, 1, 347.79),
(335, 112, 20, 8, 3933.92),
(336, 112, 18, 7, 2540.09),
(337, 112, 16, 4, 1373.12),
(338, 112, 9, 2, 168.5),
(339, 112, 2, 2, 895.0),
(340, 112, 14, 2, 322.56),
(341, 113, 4, 1, 431.61),
(342, 113, 20, 4, 120.28),
(343, 113, 1, 1, 179.5),
(344, 114, 9, 6, 1034.94),
(345, 114, 19, 6, 2902.68),
(346, 114, 11, 3, 729.0),
(347, 114, 2, 2, 448.9),
(348, 114, 18, 1, 290.77),
(349, 114, 5, 1, 43.1),
(350, 114, 16, 10, 1957.0),
(351, 114, 12, 4, 270.44),
(352, 114, 4, 9, 1665.81),
(353, 115, 6, 3, 362.4),
(354, 115, 14, 6, 565.38),
(355, 115, 20, 4, 370.0),
(356, 116, 1, 1, 38.87),
(357, 116, 2, 2, 77.3),
(358, 116, 18, 7, 419.16),
(359, 116, 13, 1, 221.16),
(360, 116, 3, 6, 1873.08),
(361, 116, 10, 1, 164.22),
(362, 116, 11, 10, 2751.2),
(363, 116, 5, 1, 86.26),
(364, 116, 19, 4, 506.92),
(365, 116, 4, 2, 361.8),
(366, 117, 10, 1, 480.76),
(367, 117, 13, 8, 2545.84),
(368, 117, 1, 1, 160.93),
(369, 117, 15, 1, 262.67),
(370, 117, 7, 7, 1707.3),
(371, 117, 9, 6, 1523.28),
(372, 118, 19, 6, 1208.88),
(373, 119, 3, 7, 2873.15),
(374, 120, 10, 1, 45.83),
(375, 121, 10, 1, 223.58),
(376, 121, 9, 10, 2145.2),
(377, 121, 14, 2, 187.26),
(378, 121, 7, 7, 2336.11),
(379, 121, 1, 1, 259.59),
(380, 121, 5, 1, 237.92),
(381, 121, 15, 1, 419.66),
(382, 121, 16, 2, 981.7),
(383, 121, 18, 8, 1541.2),
(384, 121, 6, 8, 1008.0),
(385, 122, 6, 1, 239.84),
(386, 123, 2, 7, 2256.66),
(387, 124, 20, 9, 1119.51),
(388, 125, 14, 10, 1279.5),
(389, 125, 17, 8, 3412.48),
(390, 125, 3, 1, 137.25),
(391, 125, 11, 4, 1636.44),
(392, 125, 6, 9, 1393.11),
(393, 125, 5, 1, 374.94),
(394, 125, 15, 1, 57.46),
(395, 126, 15, 1, 161.42),
(396, 127, 13, 1, 184.27),
(397, 127, 6, 4, 29.96),
(398, 127, 3, 10, 4563.4),
(399, 127, 4, 5, 1808.85),
(400, 127, 8, 2, 884.9),
(401, 127, 7, 6, 184.56),
(402, 128, 10, 1, 339.39),
(403, 128, 18, 9, 3915.54),
(404, 128, 4, 8, 880.64),
(405, 128, 5, 1, 220.34),
(406, 128, 9, 1, 83.37),
(407, 128, 7, 3, 292.83),
(408, 129, 3, 1, 277.84),
(409, 129, 9, 8, 2133.52),
(410, 130, 7, 10, 1114.0),
(411, 131, 10, 1, 158.84),
(412, 131, 5, 1, 172.6),
(413, 131, 6, 8, 957.68),
(414, 131, 3, 1, 460.69),
(415, 131, 12, 2, 644.24),
(416, 131, 8, 5, 743.5),
(417, 131, 15, 1, 119.21),
(418, 131, 7, 5, 90.95),
(419, 131, 14, 3, 1409.22),
(420, 131, 4, 7, 2059.54),
(421, 132, 13, 8, 3220.8),
(422, 133, 7, 8, 1308.4),
(423, 133, 15, 1, 85.78),
(424, 133, 19, 9, 2996.55),
(425, 133, 20, 8, 1383.76),
(426, 134, 15, 1, 401.88),
(427, 134, 11, 5, 1440.85),
(428, 134, 20, 7, 1868.23),
(429, 134, 13, 1, 305.4),
(430, 134, 5, 1, 54.83),
(431, 134, 17, 5, 2328.35),
(432, 135, 10, 1, 131.64),
(433, 136, 12, 4, 522.64),
(434, 136, 17, 6, 1225.98),
(435, 136, 5, 1, 76.97),
(436, 137, 3, 3, 734.16),
(437, 138, 17, 8, 3773.6),
(438, 139, 1, 1, 24.86),
(439, 140, 19, 7, 2917.11),
(440, 140, 2, 8, 520.96),
(441, 140, 12, 2, 652.26),
(442, 140, 14, 2, 12.34),
(443, 140, 5, 1, 225.91),
(444, 140, 6, 8, 2564.0),
(445, 140, 8, 9, 1396.62),
(446, 140, 3, 10, 4666.0),
(447, 141, 8, 8, 1189.92),
(448, 141, 5, 1, 13.24),
(449, 141, 6, 6, 1495.44),
(450, 141, 10, 1, 337.83),
(451, 141, 15, 1, 363.39),
(452, 141, 11, 6, 2323.68),
(453, 141, 16, 10, 1886.1),
(454, 142, 2, 7, 770.14),
(455, 142, 19, 6, 194.04),
(456, 142, 7, 9, 3103.2),
(457, 142, 17, 7, 2408.42),
(458, 142, 15, 1, 449.9),
(459, 142, 16, 10, 4175.9),
(460, 142, 8, 5, 1889.8),
(461, 142, 20, 3, 883.38),
(462, 142, 12, 6, 1259.7),
(463, 143, 17, 7, 3245.2),
(464, 143, 6, 10, 2079.2),
(465, 144, 2, 3, 463.32),
(466, 144, 4, 2, 242.52),
(467, 144, 16, 9, 2129.58),
(468, 144, 5, 1, 214.44),
(469, 144, 10, 1, 394.69),
(470, 144, 15, 1, 104.3),
(471, 145, 17, 10, 3571.6),
(472, 145, 1, 1, 247.95),
(473, 146, 15, 1, 31.39),
(474, 147, 4, 7, 759.01),
(475, 148, 7, 9, 1211.04),
(476, 149, 5, 1, 497.41),
(477, 150, 9, 10, 446.8),
(478, 150, 4, 8, 304.0),
(479, 150, 3, 10, 408.5),
(480, 150, 6, 5, 179.9),
(481, 150, 12, 8, 2576.72),
(482, 150, 17, 2, 147.3),
(483, 150, 11, 1, 337.38),
(484, 150, 20, 2, 388.32),
(485, 150, 19, 2, 661.08),
(486, 150, 5, 1, 249.83),
(487, 151, 16, 8, 2062.16),
(488, 152, 8, 9, 541.44),
(489, 153, 19, 5, 158.75),
(490, 153, 11, 3, 1381.02),
(491, 154, 10, 1, 7.29),
(492, 155, 1, 1, 17.88),
(493, 156, 18, 10, 2687.7),
(494, 156, 2, 8, 3899.36),
(495, 156, 16, 10, 1097.5),
(496, 156, 10, 1, 359.07),
(497, 156, 14, 1, 265.4),
(498, 156, 15, 1, 198.46),
(499, 156, 4, 6, 1412.1),
(500, 156, 13, 8, 649.12),
(501, 156, 3, 2, 465.0),
(502, 157, 16, 7, 2118.76),
(503, 158, 9, 1, 476.74),
(504, 158, 8, 5, 1225.3),
(505, 158, 14, 2, 331.32),
(506, 158, 1, 1, 298.08),
(507, 158, 2, 4, 1368.56),
(508, 158, 19, 9, 2150.1),
(509, 159, 7, 10, 4661.0),
(510, 159, 14, 8, 274.56),
(511, 159, 1, 1, 166.38),
(512, 159, 9, 9, 3019.14),
(513, 159, 5, 1, 468.88),
(514, 159, 12, 5, 859.45),
(515, 159, 20, 1, 163.54),
(516, 159, 15, 1, 87.25),
(517, 159, 16, 9, 2977.38),
(518, 159, 4, 7, 267.26),
(519, 160, 5, 1, 165.51);

INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (1, NULL, 1, 1, '2025-01-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (2, 14, 1, 2, '2025-01-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (3, NULL, 1, 1, '2025-01-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (4, 15, 2, 2, '2025-01-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (5, 19, 2, 1, '2025-01-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (6, 15, 2, 2, '2025-01-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (7, 6, 2, 3, '2025-01-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (8, NULL, 2, 1, '2025-01-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (9, 7, 3, 1, '2025-01-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (10, 14, 3, 4, '2025-01-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (11, 3, 3, 2, '2025-01-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (12, NULL, 3, 3, '2025-01-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (13, 17, 3, 1, '2025-01-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (14, 8, 4, 3, '2025-01-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (15, 6, 4, 3, '2025-01-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (16, NULL, 5, 4, '2025-01-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (17, 1, 5, 1, '2025-01-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (18, 14, 1, 1, '2025-01-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (19, NULL, 1, 1, '2025-01-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (20, 19, 1, 2, '2025-01-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (21, NULL, 1, 3, '2025-01-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (22, 7, 1, 4, '2025-01-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (23, 10, 2, 2, '2025-01-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (24, 15, 3, 4, '2025-01-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (25, 2, 3, 1, '2025-01-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (26, 17, 3, 1, '2025-01-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (27, NULL, 4, 4, '2025-01-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (28, NULL, 4, 4, '2025-01-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (29, NULL, 5, 3, '2025-01-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (30, NULL, 5, 2, '2025-01-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (31, 18, 5, 2, '2025-01-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (32, 17, 5, 2, '2025-01-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (33, 5, 1, 4, '2025-01-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (34, 14, 1, 3, '2025-01-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (35, NULL, 1, 1, '2025-01-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (36, 2, 1, 1, '2025-01-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (37, NULL, 1, 3, '2025-01-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (38, NULL, 1, 2, '2025-01-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (39, NULL, 2, 2, '2025-01-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (40, NULL, 2, 4, '2025-01-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (41, 19, 2, 4, '2025-01-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (42, 20, 3, 1, '2025-01-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (43, 13, 4, 3, '2025-01-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (44, NULL, 5, 4, '2025-01-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (45, 15, 5, 3, '2025-01-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (46, NULL, 5, 2, '2025-01-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (47, 15, 5, 2, '2025-01-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (48, 2, 5, 1, '2025-01-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (49, 5, 5, 2, '2025-01-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (50, 5, 1, 2, '2025-01-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (51, NULL, 2, 3, '2025-01-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (52, 11, 2, 3, '2025-01-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (53, 14, 2, 2, '2025-01-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (54, 5, 2, 3, '2025-01-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (55, 10, 2, 3, '2025-01-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (56, 5, 3, 4, '2025-01-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (57, 3, 3, 1, '2025-01-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (58, 3, 3, 2, '2025-01-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (59, 15, 3, 3, '2025-01-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (60, NULL, 4, 4, '2025-01-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (61, NULL, 4, 1, '2025-01-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (62, 16, 4, 4, '2025-01-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (63, 20, 4, 4, '2025-01-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (64, 18, 4, 1, '2025-01-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (65, NULL, 4, 1, '2025-01-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (66, NULL, 5, 2, '2025-01-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (67, 9, 5, 2, '2025-01-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (68, NULL, 5, 2, '2025-01-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (69, 9, 5, 1, '2025-01-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (70, 11, 5, 3, '2025-01-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (71, 10, 1, 3, '2025-01-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (72, 7, 1, 3, '2025-01-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (73, 17, 1, 2, '2025-01-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (74, 3, 1, 1, '2025-01-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (75, 12, 2, 2, '2025-01-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (76, NULL, 2, 1, '2025-01-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (77, 14, 2, 4, '2025-01-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (78, 11, 3, 4, '2025-01-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (79, NULL, 3, 3, '2025-01-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (80, 2, 4, 3, '2025-01-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (81, 13, 4, 3, '2025-01-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (82, 19, 4, 2, '2025-01-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (83, NULL, 4, 4, '2025-01-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (84, 20, 4, 1, '2025-01-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (85, 10, 5, 2, '2025-01-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (86, 5, 5, 2, '2025-01-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (87, NULL, 5, 2, '2025-01-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (88, NULL, 5, 1, '2025-01-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (89, NULL, 5, 1, '2025-01-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (90, 16, 5, 2, '2025-01-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (91, NULL, 1, 3, '2025-01-06');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (92, NULL, 1, 3, '2025-01-06');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (93, NULL, 1, 2, '2025-01-06');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (94, 17, 1, 2, '2025-01-06');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (95, 3, 1, 4, '2025-01-06');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (96, NULL, 2, 4, '2025-01-06');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (97, 4, 2, 1, '2025-01-06');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (98, 10, 2, 2, '2025-01-06');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (99, 15, 3, 1, '2025-01-06');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (100, 18, 3, 4, '2025-01-06');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (101, 15, 4, 4, '2025-01-06');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (102, NULL, 4, 1, '2025-01-06');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (103, 14, 4, 2, '2025-01-06');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (104, NULL, 4, 3, '2025-01-06');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (105, NULL, 5, 3, '2025-01-06');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (106, NULL, 5, 4, '2025-01-06');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (107, 13, 5, 1, '2025-01-06');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (108, NULL, 5, 1, '2025-01-06');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (109, NULL, 5, 2, '2025-01-06');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (110, NULL, 5, 1, '2025-01-06');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (111, 9, 1, 3, '2025-01-07');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (112, 18, 1, 4, '2025-01-07');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (113, 14, 2, 4, '2025-01-07');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (114, NULL, 2, 3, '2025-01-07');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (115, NULL, 2, 1, '2025-01-07');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (116, NULL, 2, 4, '2025-01-07');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (117, 9, 2, 2, '2025-01-07');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (118, 3, 3, 1, '2025-01-07');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (119, 15, 3, 2, '2025-01-07');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (120, 2, 3, 2, '2025-01-07');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (121, NULL, 3, 1, '2025-01-07');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (122, 5, 4, 1, '2025-01-07');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (123, 14, 4, 1, '2025-01-07');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (124, NULL, 4, 2, '2025-01-07');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (125, 11, 4, 2, '2025-01-07');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (126, 17, 4, 4, '2025-01-07');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (127, 13, 4, 4, '2025-01-07');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (128, NULL, 5, 4, '2025-01-07');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (129, NULL, 1, 4, '2025-01-08');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (130, 11, 1, 1, '2025-01-08');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (131, NULL, 1, 2, '2025-01-08');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (132, NULL, 1, 4, '2025-01-08');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (133, 17, 1, 3, '2025-01-08');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (134, 5, 2, 4, '2025-01-08');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (135, NULL, 2, 4, '2025-01-08');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (136, NULL, 2, 1, '2025-01-08');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (137, NULL, 3, 3, '2025-01-08');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (138, 7, 3, 3, '2025-01-08');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (139, 14, 4, 1, '2025-01-08');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (140, 11, 4, 3, '2025-01-08');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (141, 19, 4, 2, '2025-01-08');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (142, 4, 4, 1, '2025-01-08');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (143, 10, 4, 3, '2025-01-08');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (144, 4, 5, 2, '2025-01-08');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (145, NULL, 5, 1, '2025-01-08');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (146, 10, 5, 3, '2025-01-08');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (147, 19, 1, 1, '2025-01-09');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (148, NULL, 1, 2, '2025-01-09');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (149, 18, 1, 1, '2025-01-09');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (150, NULL, 1, 3, '2025-01-09');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (151, 5, 1, 3, '2025-01-09');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (152, NULL, 1, 2, '2025-01-09');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (153, NULL, 2, 4, '2025-01-09');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (154, NULL, 2, 1, '2025-01-09');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (155, 20, 2, 3, '2025-01-09');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (156, 11, 2, 3, '2025-01-09');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (157, 15, 3, 1, '2025-01-09');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (158, NULL, 3, 2, '2025-01-09');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (159, NULL, 4, 3, '2025-01-09');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (160, 14, 4, 4, '2025-01-09');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (161, 17, 4, 2, '2025-01-09');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (162, 15, 4, 4, '2025-01-09');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (163, 13, 4, 3, '2025-01-09');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (164, 13, 4, 3, '2025-01-09');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (165, NULL, 5, 2, '2025-01-09');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (166, NULL, 5, 1, '2025-01-09');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (167, 9, 5, 3, '2025-01-09');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (168, 15, 5, 3, '2025-01-09');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (169, NULL, 1, 1, '2025-01-10');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (170, NULL, 1, 4, '2025-01-10');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (171, NULL, 2, 2, '2025-01-10');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (172, NULL, 2, 1, '2025-01-10');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (173, 13, 2, 4, '2025-01-10');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (174, NULL, 3, 2, '2025-01-10');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (175, 6, 3, 3, '2025-01-10');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (176, 5, 3, 1, '2025-01-10');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (177, NULL, 3, 1, '2025-01-10');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (178, NULL, 3, 2, '2025-01-10');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (179, NULL, 4, 3, '2025-01-10');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (180, NULL, 4, 1, '2025-01-10');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (181, NULL, 4, 4, '2025-01-10');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (182, 1, 4, 1, '2025-01-10');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (183, 18, 4, 3, '2025-01-10');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (184, 5, 4, 4, '2025-01-10');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (185, NULL, 5, 4, '2025-01-10');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (186, 12, 5, 1, '2025-01-10');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (187, 3, 5, 1, '2025-01-10');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (188, 8, 5, 3, '2025-01-10');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (189, 1, 1, 3, '2025-01-11');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (190, NULL, 1, 1, '2025-01-11');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (191, 2, 1, 4, '2025-01-11');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (192, NULL, 1, 4, '2025-01-11');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (193, NULL, 2, 1, '2025-01-11');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (194, 7, 2, 1, '2025-01-11');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (195, NULL, 2, 1, '2025-01-11');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (196, 20, 2, 4, '2025-01-11');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (197, NULL, 3, 2, '2025-01-11');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (198, 18, 3, 1, '2025-01-11');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (199, 15, 3, 4, '2025-01-11');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (200, 9, 4, 3, '2025-01-11');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (201, NULL, 4, 3, '2025-01-11');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (202, 11, 4, 3, '2025-01-11');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (203, NULL, 4, 2, '2025-01-11');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (204, 11, 4, 2, '2025-01-11');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (205, 5, 5, 2, '2025-01-11');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (206, 15, 5, 1, '2025-01-11');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (207, 2, 5, 1, '2025-01-11');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (208, NULL, 5, 2, '2025-01-11');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (209, NULL, 5, 2, '2025-01-11');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (210, NULL, 1, 3, '2025-01-12');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (211, 2, 1, 1, '2025-01-12');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (212, 15, 1, 2, '2025-01-12');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (213, NULL, 2, 2, '2025-01-12');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (214, 2, 3, 3, '2025-01-12');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (215, NULL, 3, 1, '2025-01-12');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (216, NULL, 3, 3, '2025-01-12');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (217, 13, 3, 3, '2025-01-12');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (218, 6, 3, 2, '2025-01-12');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (219, 1, 4, 2, '2025-01-12');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (220, 3, 4, 4, '2025-01-12');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (221, 10, 4, 4, '2025-01-12');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (222, 2, 4, 4, '2025-01-12');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (223, 3, 4, 3, '2025-01-12');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (224, 5, 5, 4, '2025-01-12');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (225, 7, 5, 4, '2025-01-12');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (226, 20, 5, 1, '2025-01-12');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (227, 16, 5, 1, '2025-01-12');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (228, NULL, 5, 1, '2025-01-12');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (229, NULL, 1, 1, '2025-01-13');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (230, 17, 1, 3, '2025-01-13');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (231, 6, 1, 3, '2025-01-13');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (232, 8, 2, 2, '2025-01-13');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (233, NULL, 2, 4, '2025-01-13');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (234, NULL, 3, 1, '2025-01-13');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (235, NULL, 3, 1, '2025-01-13');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (236, NULL, 3, 2, '2025-01-13');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (237, 4, 3, 3, '2025-01-13');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (238, 19, 4, 2, '2025-01-13');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (239, 16, 4, 1, '2025-01-13');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (240, NULL, 4, 1, '2025-01-13');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (241, 3, 5, 4, '2025-01-13');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (242, NULL, 5, 4, '2025-01-13');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (243, 17, 1, 4, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (244, NULL, 1, 1, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (245, 6, 1, 1, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (246, 1, 1, 4, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (247, 4, 1, 4, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (248, NULL, 2, 2, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (249, NULL, 2, 1, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (250, NULL, 2, 1, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (251, NULL, 2, 4, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (252, 9, 2, 2, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (253, 15, 2, 3, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (254, NULL, 3, 3, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (255, 9, 4, 1, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (256, NULL, 4, 3, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (257, 2, 4, 2, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (258, NULL, 4, 2, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (259, 18, 4, 1, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (260, 20, 5, 3, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (261, 10, 5, 4, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (262, NULL, 5, 4, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (263, 4, 5, 2, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (264, NULL, 5, 3, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (265, NULL, 5, 4, '2025-01-14');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (266, 7, 1, 1, '2025-01-15');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (267, 3, 1, 4, '2025-01-15');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (268, 7, 1, 2, '2025-01-15');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (269, NULL, 1, 1, '2025-01-15');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (270, NULL, 1, 4, '2025-01-15');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (271, 19, 2, 2, '2025-01-15');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (272, 1, 2, 3, '2025-01-15');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (273, NULL, 2, 1, '2025-01-15');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (274, NULL, 2, 4, '2025-01-15');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (275, 16, 2, 1, '2025-01-15');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (276, 12, 3, 4, '2025-01-15');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (277, 19, 4, 1, '2025-01-15');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (278, NULL, 4, 2, '2025-01-15');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (279, NULL, 5, 2, '2025-01-15');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (280, NULL, 5, 2, '2025-01-15');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (281, NULL, 5, 2, '2025-01-15');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (282, NULL, 5, 3, '2025-01-15');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (283, 5, 5, 2, '2025-01-15');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (284, 8, 5, 1, '2025-01-15');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (285, NULL, 1, 3, '2025-01-16');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (286, NULL, 1, 4, '2025-01-16');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (287, NULL, 1, 1, '2025-01-16');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (288, 5, 1, 1, '2025-01-16');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (289, NULL, 1, 2, '2025-01-16');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (290, 14, 1, 2, '2025-01-16');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (291, 19, 2, 2, '2025-01-16');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (292, 20, 2, 4, '2025-01-16');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (293, NULL, 2, 2, '2025-01-16');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (294, 20, 2, 1, '2025-01-16');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (295, NULL, 2, 3, '2025-01-16');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (296, NULL, 3, 1, '2025-01-16');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (297, NULL, 3, 2, '2025-01-16');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (298, 8, 3, 4, '2025-01-16');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (299, NULL, 4, 1, '2025-01-16');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (300, 16, 4, 4, '2025-01-16');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (301, NULL, 4, 2, '2025-01-16');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (302, NULL, 4, 2, '2025-01-16');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (303, 15, 4, 1, '2025-01-16');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (304, 13, 5, 1, '2025-01-16');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (305, 3, 5, 2, '2025-01-16');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (306, 13, 5, 2, '2025-01-16');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (307, NULL, 1, 4, '2025-01-17');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (308, NULL, 1, 4, '2025-01-17');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (309, 11, 1, 3, '2025-01-17');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (310, NULL, 1, 3, '2025-01-17');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (311, 2, 2, 4, '2025-01-17');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (312, 15, 2, 1, '2025-01-17');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (313, NULL, 2, 1, '2025-01-17');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (314, 8, 3, 4, '2025-01-17');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (315, NULL, 3, 4, '2025-01-17');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (316, NULL, 3, 2, '2025-01-17');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (317, NULL, 3, 3, '2025-01-17');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (318, 10, 3, 3, '2025-01-17');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (319, 9, 4, 4, '2025-01-17');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (320, 6, 4, 3, '2025-01-17');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (321, NULL, 4, 2, '2025-01-17');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (322, NULL, 4, 2, '2025-01-17');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (323, NULL, 4, 1, '2025-01-17');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (324, NULL, 4, 1, '2025-01-17');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (325, 2, 5, 2, '2025-01-17');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (326, NULL, 1, 4, '2025-01-18');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (327, 10, 1, 4, '2025-01-18');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (328, 14, 1, 3, '2025-01-18');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (329, 11, 1, 1, '2025-01-18');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (330, NULL, 1, 2, '2025-01-18');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (331, 11, 2, 3, '2025-01-18');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (332, 16, 2, 1, '2025-01-18');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (333, 9, 2, 1, '2025-01-18');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (334, NULL, 3, 3, '2025-01-18');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (335, NULL, 3, 4, '2025-01-18');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (336, 12, 4, 2, '2025-01-18');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (337, NULL, 4, 1, '2025-01-18');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (338, 15, 4, 3, '2025-01-18');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (339, 10, 5, 2, '2025-01-18');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (340, 7, 5, 3, '2025-01-18');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (341, 4, 5, 2, '2025-01-18');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (342, NULL, 5, 2, '2025-01-18');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (343, 4, 5, 2, '2025-01-18');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (344, NULL, 5, 4, '2025-01-18');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (345, 1, 1, 1, '2025-01-19');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (346, NULL, 1, 4, '2025-01-19');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (347, NULL, 1, 3, '2025-01-19');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (348, NULL, 1, 4, '2025-01-19');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (349, 12, 1, 1, '2025-01-19');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (350, NULL, 2, 3, '2025-01-19');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (351, NULL, 2, 2, '2025-01-19');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (352, NULL, 2, 1, '2025-01-19');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (353, 20, 2, 4, '2025-01-19');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (354, 3, 3, 2, '2025-01-19');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (355, 6, 3, 1, '2025-01-19');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (356, NULL, 3, 1, '2025-01-19');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (357, 3, 3, 1, '2025-01-19');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (358, 6, 3, 2, '2025-01-19');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (359, 17, 4, 4, '2025-01-19');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (360, 9, 5, 2, '2025-01-19');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (361, NULL, 5, 1, '2025-01-19');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (362, 19, 1, 3, '2025-01-20');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (363, NULL, 1, 2, '2025-01-20');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (364, 8, 1, 4, '2025-01-20');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (365, 13, 1, 2, '2025-01-20');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (366, NULL, 2, 3, '2025-01-20');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (367, 20, 2, 2, '2025-01-20');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (368, 12, 2, 3, '2025-01-20');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (369, 8, 2, 2, '2025-01-20');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (370, 12, 3, 3, '2025-01-20');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (371, 14, 3, 4, '2025-01-20');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (372, 1, 3, 4, '2025-01-20');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (373, NULL, 3, 4, '2025-01-20');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (374, NULL, 4, 1, '2025-01-20');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (375, 18, 5, 1, '2025-01-20');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (376, 2, 1, 4, '2025-01-21');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (377, 2, 1, 1, '2025-01-21');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (378, 13, 2, 2, '2025-01-21');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (379, NULL, 2, 4, '2025-01-21');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (380, NULL, 2, 2, '2025-01-21');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (381, NULL, 2, 4, '2025-01-21');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (382, NULL, 2, 2, '2025-01-21');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (383, 15, 2, 2, '2025-01-21');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (384, NULL, 3, 2, '2025-01-21');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (385, 16, 3, 4, '2025-01-21');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (386, 6, 3, 2, '2025-01-21');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (387, NULL, 3, 3, '2025-01-21');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (388, 4, 3, 4, '2025-01-21');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (389, NULL, 3, 2, '2025-01-21');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (390, 7, 4, 2, '2025-01-21');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (391, NULL, 4, 2, '2025-01-21');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (392, 3, 4, 1, '2025-01-21');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (393, NULL, 4, 1, '2025-01-21');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (394, 2, 5, 4, '2025-01-21');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (395, 19, 5, 1, '2025-01-21');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (396, NULL, 5, 4, '2025-01-21');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (397, 14, 1, 4, '2025-01-22');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (398, 4, 1, 1, '2025-01-22');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (399, NULL, 1, 4, '2025-01-22');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (400, 14, 2, 4, '2025-01-22');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (401, NULL, 2, 3, '2025-01-22');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (402, 10, 2, 3, '2025-01-22');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (403, 18, 2, 2, '2025-01-22');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (404, 15, 2, 2, '2025-01-22');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (405, NULL, 3, 2, '2025-01-22');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (406, NULL, 3, 2, '2025-01-22');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (407, NULL, 3, 1, '2025-01-22');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (408, 16, 3, 4, '2025-01-22');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (409, 20, 3, 3, '2025-01-22');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (410, NULL, 3, 1, '2025-01-22');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (411, 18, 4, 3, '2025-01-22');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (412, 13, 4, 4, '2025-01-22');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (413, NULL, 4, 3, '2025-01-22');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (414, 13, 4, 3, '2025-01-22');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (415, 16, 4, 4, '2025-01-22');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (416, NULL, 4, 2, '2025-01-22');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (417, 6, 5, 3, '2025-01-22');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (418, NULL, 5, 4, '2025-01-22');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (419, NULL, 1, 3, '2025-01-23');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (420, NULL, 2, 3, '2025-01-23');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (421, 3, 2, 3, '2025-01-23');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (422, 1, 2, 2, '2025-01-23');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (423, 15, 2, 2, '2025-01-23');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (424, NULL, 3, 1, '2025-01-23');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (425, 10, 3, 1, '2025-01-23');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (426, 15, 4, 1, '2025-01-23');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (427, 9, 4, 3, '2025-01-23');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (428, NULL, 5, 2, '2025-01-23');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (429, 9, 5, 4, '2025-01-23');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (430, NULL, 5, 4, '2025-01-23');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (431, 19, 1, 1, '2025-01-24');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (432, 13, 1, 3, '2025-01-24');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (433, NULL, 1, 2, '2025-01-24');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (434, 4, 1, 2, '2025-01-24');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (435, 8, 2, 3, '2025-01-24');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (436, 20, 2, 2, '2025-01-24');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (437, NULL, 2, 3, '2025-01-24');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (438, 7, 2, 4, '2025-01-24');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (439, NULL, 3, 4, '2025-01-24');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (440, 7, 3, 4, '2025-01-24');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (441, NULL, 3, 1, '2025-01-24');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (442, 12, 3, 4, '2025-01-24');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (443, 17, 3, 4, '2025-01-24');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (444, NULL, 4, 1, '2025-01-24');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (445, 11, 5, 2, '2025-01-24');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (446, NULL, 5, 4, '2025-01-24');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (447, NULL, 5, 3, '2025-01-24');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (448, NULL, 1, 2, '2025-01-25');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (449, 2, 1, 1, '2025-01-25');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (450, NULL, 2, 3, '2025-01-25');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (451, 3, 2, 4, '2025-01-25');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (452, NULL, 2, 3, '2025-01-25');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (453, 10, 3, 4, '2025-01-25');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (454, NULL, 3, 1, '2025-01-25');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (455, 8, 3, 1, '2025-01-25');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (456, 4, 3, 3, '2025-01-25');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (457, 20, 4, 1, '2025-01-25');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (458, NULL, 4, 4, '2025-01-25');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (459, 5, 4, 3, '2025-01-25');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (460, 17, 4, 3, '2025-01-25');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (461, 16, 4, 2, '2025-01-25');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (462, 6, 5, 4, '2025-01-25');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (463, 6, 5, 2, '2025-01-25');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (464, 11, 5, 4, '2025-01-25');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (465, NULL, 5, 4, '2025-01-25');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (466, 11, 5, 4, '2025-01-25');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (467, 8, 5, 1, '2025-01-25');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (468, NULL, 1, 2, '2025-01-26');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (469, 12, 1, 2, '2025-01-26');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (470, 13, 1, 3, '2025-01-26');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (471, NULL, 1, 3, '2025-01-26');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (472, 19, 2, 4, '2025-01-26');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (473, 13, 3, 1, '2025-01-26');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (474, 15, 3, 4, '2025-01-26');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (475, NULL, 3, 3, '2025-01-26');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (476, 7, 3, 3, '2025-01-26');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (477, 8, 4, 1, '2025-01-26');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (478, 11, 5, 4, '2025-01-26');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (479, NULL, 5, 1, '2025-01-26');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (480, 13, 1, 4, '2025-01-27');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (481, 3, 2, 4, '2025-01-27');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (482, NULL, 2, 2, '2025-01-27');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (483, NULL, 3, 4, '2025-01-27');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (484, 16, 3, 3, '2025-01-27');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (485, 7, 3, 1, '2025-01-27');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (486, NULL, 3, 1, '2025-01-27');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (487, NULL, 4, 4, '2025-01-27');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (488, NULL, 4, 1, '2025-01-27');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (489, 10, 4, 2, '2025-01-27');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (490, 17, 4, 3, '2025-01-27');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (491, NULL, 4, 1, '2025-01-27');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (492, NULL, 5, 3, '2025-01-27');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (493, NULL, 5, 1, '2025-01-27');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (494, NULL, 5, 2, '2025-01-27');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (495, 10, 1, 1, '2025-01-28');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (496, 12, 1, 3, '2025-01-28');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (497, 11, 2, 3, '2025-01-28');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (498, 7, 2, 3, '2025-01-28');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (499, NULL, 3, 1, '2025-01-28');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (500, NULL, 3, 3, '2025-01-28');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (501, 7, 3, 4, '2025-01-28');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (502, NULL, 3, 2, '2025-01-28');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (503, 17, 3, 1, '2025-01-28');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (504, 11, 4, 2, '2025-01-28');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (505, NULL, 4, 4, '2025-01-28');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (506, NULL, 4, 4, '2025-01-28');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (507, 5, 4, 2, '2025-01-28');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (508, 18, 4, 3, '2025-01-28');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (509, NULL, 4, 4, '2025-01-28');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (510, 14, 5, 1, '2025-01-28');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (511, NULL, 5, 2, '2025-01-28');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (512, 18, 5, 4, '2025-01-28');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (513, 4, 5, 2, '2025-01-28');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (514, 18, 5, 2, '2025-01-28');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (515, NULL, 1, 2, '2025-01-29');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (516, 16, 1, 4, '2025-01-29');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (517, 3, 1, 4, '2025-01-29');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (518, NULL, 2, 1, '2025-01-29');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (519, 9, 3, 4, '2025-01-29');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (520, NULL, 3, 2, '2025-01-29');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (521, NULL, 3, 2, '2025-01-29');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (522, 5, 3, 2, '2025-01-29');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (523, 12, 3, 3, '2025-01-29');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (524, NULL, 3, 1, '2025-01-29');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (525, 1, 4, 3, '2025-01-29');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (526, NULL, 4, 2, '2025-01-29');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (527, 13, 4, 1, '2025-01-29');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (528, 5, 4, 4, '2025-01-29');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (529, 20, 4, 2, '2025-01-29');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (530, 2, 5, 4, '2025-01-29');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (531, NULL, 5, 1, '2025-01-29');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (532, 2, 5, 1, '2025-01-29');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (533, NULL, 5, 1, '2025-01-29');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (534, 8, 5, 4, '2025-01-29');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (535, 12, 5, 1, '2025-01-29');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (536, NULL, 1, 4, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (537, 5, 1, 1, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (538, 19, 1, 4, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (539, 15, 1, 2, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (540, 4, 1, 4, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (541, 11, 1, 3, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (542, NULL, 2, 4, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (543, NULL, 2, 3, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (544, 3, 2, 1, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (545, 19, 2, 2, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (546, NULL, 2, 4, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (547, NULL, 2, 2, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (548, 10, 3, 2, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (549, 5, 3, 4, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (550, NULL, 3, 4, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (551, NULL, 3, 1, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (552, 16, 4, 1, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (553, 2, 4, 3, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (554, 20, 4, 1, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (555, 3, 4, 4, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (556, NULL, 4, 4, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (557, 9, 5, 2, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (558, NULL, 5, 2, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (559, 8, 5, 2, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (560, NULL, 5, 2, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (561, NULL, 5, 3, '2025-01-30');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (562, NULL, 1, 1, '2025-01-31');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (563, NULL, 2, 1, '2025-01-31');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (564, 18, 2, 4, '2025-01-31');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (565, NULL, 2, 3, '2025-01-31');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (566, 6, 2, 4, '2025-01-31');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (567, NULL, 2, 2, '2025-01-31');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (568, 7, 2, 2, '2025-01-31');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (569, 20, 3, 3, '2025-01-31');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (570, 11, 3, 3, '2025-01-31');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (571, 5, 3, 4, '2025-01-31');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (572, NULL, 4, 3, '2025-01-31');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (573, NULL, 4, 2, '2025-01-31');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (574, NULL, 4, 3, '2025-01-31');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (575, 6, 4, 3, '2025-01-31');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (576, 15, 4, 4, '2025-01-31');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (577, 4, 4, 2, '2025-01-31');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (578, NULL, 5, 3, '2025-01-31');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (579, 12, 5, 3, '2025-01-31');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (580, NULL, 5, 4, '2025-01-31');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (581, NULL, 5, 2, '2025-01-31');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (582, 10, 1, 4, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (583, 11, 1, 1, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (584, NULL, 1, 2, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (585, NULL, 1, 2, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (586, 2, 1, 3, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (587, 1, 1, 3, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (588, 20, 2, 4, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (589, 14, 2, 3, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (590, 4, 2, 3, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (591, 4, 2, 1, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (592, 4, 3, 1, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (593, 10, 3, 2, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (594, NULL, 3, 1, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (595, 9, 3, 1, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (596, NULL, 3, 3, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (597, NULL, 3, 1, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (598, 8, 4, 2, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (599, NULL, 4, 4, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (600, NULL, 4, 3, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (601, 9, 4, 2, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (602, 7, 4, 2, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (603, 18, 5, 1, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (604, 14, 5, 1, '2025-02-01');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (605, 13, 1, 1, '2025-02-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (606, NULL, 1, 2, '2025-02-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (607, 2, 1, 3, '2025-02-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (608, NULL, 2, 3, '2025-02-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (609, 10, 2, 1, '2025-02-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (610, NULL, 2, 2, '2025-02-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (611, 15, 2, 4, '2025-02-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (612, 20, 2, 1, '2025-02-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (613, NULL, 2, 1, '2025-02-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (614, 13, 3, 3, '2025-02-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (615, 19, 3, 4, '2025-02-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (616, 7, 3, 2, '2025-02-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (617, 12, 3, 1, '2025-02-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (618, NULL, 4, 1, '2025-02-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (619, 4, 4, 3, '2025-02-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (620, NULL, 4, 1, '2025-02-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (621, NULL, 5, 3, '2025-02-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (622, 15, 5, 2, '2025-02-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (623, 17, 5, 1, '2025-02-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (624, 5, 5, 3, '2025-02-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (625, 14, 5, 2, '2025-02-02');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (626, NULL, 1, 3, '2025-02-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (627, 4, 1, 2, '2025-02-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (628, 14, 2, 4, '2025-02-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (629, NULL, 2, 4, '2025-02-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (630, 17, 2, 2, '2025-02-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (631, 13, 2, 3, '2025-02-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (632, NULL, 2, 2, '2025-02-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (633, NULL, 3, 1, '2025-02-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (634, 14, 4, 3, '2025-02-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (635, 5, 5, 4, '2025-02-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (636, NULL, 5, 3, '2025-02-03');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (637, 15, 1, 4, '2025-02-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (638, NULL, 1, 4, '2025-02-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (639, NULL, 1, 4, '2025-02-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (640, 2, 1, 2, '2025-02-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (641, NULL, 2, 2, '2025-02-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (642, NULL, 2, 4, '2025-02-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (643, 14, 3, 4, '2025-02-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (644, 13, 3, 2, '2025-02-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (645, NULL, 3, 3, '2025-02-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (646, NULL, 3, 4, '2025-02-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (647, NULL, 3, 4, '2025-02-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (648, 7, 3, 2, '2025-02-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (649, NULL, 4, 2, '2025-02-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (650, 8, 4, 3, '2025-02-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (651, NULL, 4, 1, '2025-02-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (652, 20, 4, 3, '2025-02-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (653, 13, 5, 1, '2025-02-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (654, NULL, 5, 1, '2025-02-04');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (655, NULL, 1, 4, '2025-02-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (656, 1, 1, 1, '2025-02-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (657, NULL, 1, 2, '2025-02-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (658, 14, 1, 1, '2025-02-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (659, NULL, 1, 1, '2025-02-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (660, NULL, 2, 3, '2025-02-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (661, 15, 3, 2, '2025-02-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (662, NULL, 3, 2, '2025-02-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (663, 3, 3, 2, '2025-02-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (664, NULL, 4, 3, '2025-02-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (665, NULL, 4, 3, '2025-02-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (666, 12, 4, 2, '2025-02-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (667, 16, 5, 3, '2025-02-05');
INSERT INTO SALES (Sale_ID, Customer_ID, Store_ID, Payment_Method_ID, Sales_Date) VALUES (668, 13, 5, 2, '2025-02-05');


