-- Transform ProductDetail into 1NF
SELECT 
    OrderID,
    CustomerName,
    TRIM(product) AS Product
FROM ProductDetail,
JSON_TABLE(
    CONCAT('["', REPLACE(Products, ',', '","'), '"]'),
    "$[*]" COLUMNS(product VARCHAR(100) PATH "$")
) AS jt;


-- Table for Orders (removes partial dependency)
CREATE TABLE Orders AS
SELECT DISTINCT 
    OrderID, 
    CustomerName
FROM OrderDetails;

-- Table for OrderItems (fully depends on composite key)
CREATE TABLE OrderItems AS
SELECT 
    OrderID, 
    Product, 
    Quantity
FROM OrderDetails;
