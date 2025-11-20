-- Create Database
CREATE DATABASE IF NOT EXISTS pizza_project;
USE pizza_project;

-- Create Tables
CREATE TABLE IF NOT EXISTS pizzatoppings (
    topping_id INT PRIMARY KEY AUTO_INCREMENT,
    topping_name VARCHAR(50),
    category VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS pizzas (
    pizza_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(6,2),
    vegetarian ENUM('Yes', 'No')
);

CREATE TABLE IF NOT EXISTS pizza_topping (
    pizza_id VARCHAR(50),
    topping_id INT,
    PRIMARY KEY (pizza_id, topping_id),
    FOREIGN KEY (pizza_id) REFERENCES pizzas(pizza_id),
    FOREIGN KEY (topping_id) REFERENCES pizzatoppings(topping_id)
);

CREATE TABLE IF NOT EXISTS customer_orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_time TIME,
    order_date DATE
);

CREATE TABLE IF NOT EXISTS order_details (
    detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id VARCHAR(50),
    pizza_id VARCHAR(50),
    quantity INT,
    price DECIMAL(6,2),
    FOREIGN KEY (order_id) REFERENCES customer_orders(order_id),
    FOREIGN KEY (pizza_id) REFERENCES pizzas(pizza_id)
);

-------------------------------------------------------------
--                   QUERY SECTION
-------------------------------------------------------------

-- 1. Unique Pizza Categories
SELECT DISTINCT category FROM pizzatoppings;


-- 2. Pizza with Ingredients
SELECT 
    p.pizza_id, 
    p.name,
    GROUP_CONCAT(t.topping_name) AS ingredients
FROM pizzas p
LEFT JOIN pizza_topping pt ON p.pizza_id = pt.pizza_id
LEFT JOIN pizzatoppings t ON pt.topping_id = t.topping_id
GROUP BY p.pizza_id, p.name;

INSERT IGNORE INTO pizzas (pizza_id, name, price, vegetarian) VALUES
('PZ1', 'Margherita', 250.00, 'Yes'),
('PZ2', 'Farmhouse', 350.00, 'Yes'),
('PZ3', 'Veggie Deluxe', 400.00, 'Yes'),
('PZ4', 'Paneer Special', 450.00, 'Yes'),
('PZ5', 'Pepperoni Feast', 550.00, 'No'),
('PZ6', 'Chicken Supreme', 600.00, 'No'),
('PZ7', 'Cheese Burst', 300.00, 'Yes'),
('PZ8', 'BBQ Chicken', 650.00, 'No');


-- 3. Missing Prices
SELECT pizza_id, name 
FROM pizzas 
WHERE price IS NULL;


SELECT pizza_id, topping_id
FROM pizza_topping
WHERE (pizza_id, topping_id) IN (
 ('PZ1',1), ('PZ1',3),
 ('PZ2',1), ('PZ2',4), ('PZ2',5), ('PZ2',6),
 ('PZ3',1), ('PZ3',3), ('PZ3',4), ('PZ3',10),
 ('PZ4',1), ('PZ4',7), ('PZ4',4),
 ('PZ5',1), ('PZ5',9),
 ('PZ6',1), ('PZ6',8), ('PZ6',10),
 ('PZ7',1), ('PZ7',2),
 ('PZ8',1), ('PZ8',8), ('PZ8',11)
);


-- 4. Orders With Dates
SELECT order_id, customer_id, order_date 
FROM customer_orders;


/*INSERT INTO customer_orders (order_id, customer_id, order_time, order_date) VALUES
('O1', 'C1', '12:00:00', '2025-01-10'),
('O2', 'C2', '14:30:00', '2025-01-10'),
('O3', 'C1', '18:45:00', '2025-01-11'),
('O4', 'C3', '20:10:00', '2025-01-11'),
('O5', 'C4', '16:20:00', '2025-01-12');*/

-- 5. Price Descending
SELECT * FROM pizzas 
ORDER BY price DESC;


INSERT INTO order_details (order_id, pizza_id, quantity, price) VALUES
('O1', 'PZ1', 2, 250.00),
('O1', 'PZ2', 1, 350.00),
('O2', 'PZ3', 1, 400.00),
('O3', 'PZ6', 2, 600.00),
('O4', 'PZ5', 1, 550.00),
('O4', 'PZ7', 3, 300.00),
('O5', 'PZ8', 1, 650.00);


-- 6. Sold in X and L Quantities
SELECT pizza_id, quantity 
FROM order_details 
WHERE quantity = 1 OR quantity >= 3;


-- 7. Price Between 100 and 300
SELECT * FROM pizzas 
WHERE price BETWEEN 100 AND 300;


-- 8. Veg and Non-Veg Pizzas
SELECT pizza_id, name, vegetarian 
FROM pizzas 
ORDER BY vegetarian;


-- 9. Total Quantity Sold
SELECT SUM(quantity) AS total_quantity 
FROM order_details;


-- 10. Average Pizza Price
SELECT ROUND(AVG(price), 2) AS avg_price 
FROM pizzas 
WHERE price IS NOT NULL;

-- 11. Total Order Value
SELECT order_id, SUM(quantity * price) AS order_value 
FROM order_details 
GROUP BY order_id;

-- 12. Total Quantity Sold (Repeat)
SELECT SUM(quantity) 
FROM order_details;


-- 13. Pizzas Costing > 500
SELECT * FROM pizzas 
WHERE price > 500;


-- 14. Unsold Pizzas
SELECT 
    p.pizza_id, 
    p.name
FROM pizzas p
LEFT JOIN order_details od ON p.pizza_id = od.pizza_id
WHERE od.pizza_id IS NULL;

-- 15. Total Revenue
SELECT SUM(quantity * price) AS total_revenue 
FROM order_details;
