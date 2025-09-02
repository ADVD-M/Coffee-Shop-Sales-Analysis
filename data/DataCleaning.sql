Create database CoffeeShop

CREATE TABLE coffee_shop_sales(
    TransactionID VARCHAR(50),
    TransactionDate DATE,
    TransactionTime TIME,
    Quantity INT,
    StoreID VARCHAR(20),
    StoreLocation VARCHAR(100),
    ProductID VARCHAR(50),
    UnitPrice DECIMAL(10,2),
    ProductCategory VARCHAR(50),
    ProductType VARCHAR(50),
    ProductDetail TEXT
);

LOAD DATA LOCAL INFILE "C:\\ProgramData\\MySQL\\MySQL Server 9.4\\Uploads\\Coffee Shop Sales.csv"
INTO TABLE coffee_shop_sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    @TransactionID, 
    @TransactionDate, 
    @TransactionTime, 
    Quantity,
    StoreID,
    StoreLocation,
    ProductID,
    UnitPrice,
    ProductCategory,
    ProductType,
    ProductDetail
)
SET 
    TransactionID = @TransactionID,
    TransactionDate = STR_TO_DATE(@TransactionDate, '%d-%m-%Y'),
    TransactionTime = STR_TO_DATE(@TransactionTime, '%H:%i:%s');

alter table coffee_shop_sales
modify column TransactionID INT 

ALTER TABLE coffee_shop_sales
ADD COLUMN TotalAmount DECIMAL(12,2) AS (UnitPrice * Quantity);

CREATE INDEX idx_transaction_date ON coffee_shop_sales(TransactionDate);

SELECT * FROM coffee_shop_sales 
INTO OUTFILE 'C:\\ProgramData\\MySQL\\MySQL Server 9.4\\Uploads\\Coffee_data.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
