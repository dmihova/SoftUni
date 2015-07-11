-- Task 1
DROP DATABASE IF EXISTS `orders`;

CREATE DATABASE `orders` 
CHARACTER SET utf8 
COLLATE utf8_general_ci;

USE `orders`;

CREATE TABLE `products` (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL);
    
CREATE TABLE `customers` (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name NVARCHAR(50) NOT NULL);
    
CREATE TABLE `orders`(
	id INT AUTO_INCREMENT PRIMARY KEY,
    date DATETIME NOT NULL);
    
CREATE TABLE `order_items`(
	id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(id),
    product_id INT NOT NULL REFERENCES products(id),
    quantity DECIMAL(10, 2) NOT NULL);

-- Task 2    
INSERT INTO `products` VALUES 
	(1,'beer',1.20), 
    (2,'cheese',9.50), 
    (3,'rakiya',12.40), 
    (4,'salami',6.33), 
    (5,'tomatos',2.50), 
    (6,'cucumbers',1.35), 
    (7,'water',0.85), 
    (8,'apples',0.75);
    
INSERT INTO `customers` VALUES 
	(1,'Peter'), 
    (2,'Maria'), 
    (3,'Nakov'), 
    (4,'Vlado');

INSERT INTO `orders` VALUES 
	(1,'2015-02-13 13:47:04'), 
    (2,'2015-02-14 22:03:44'), 
    (3,'2015-02-18 09:22:01'), 
    (4,'2015-02-11 20:17:18');
    
INSERT INTO `order_items` VALUES 
	(12,4,6,2.00), 
    (13,3,2,4.00), 
    (14,3,5,1.50), 
    (15,2,1,6.00), 
    (16,2,3,1.20), 
    (17,1,2,1.00), 
    (18,1,3,1.00), 
    (19,1,4,2.00), 
    (20,1,5,1.00), 
    (21,3,1,4.00),
    (22,1,1,3.00);

-- Task 3
SELECT 
	p.name AS product_name,
    COUNT(oi.id) AS num_orders,
    IFNULL(SUM(oi.quantity), 0) AS quantity,
	p.price AS price,
    IFNULL(SUM(oi.quantity), 0) * p.price AS total_price
FROM products AS p
LEFT JOIN order_items AS oi
	ON p.id = oi.product_id
GROUP BY p.name