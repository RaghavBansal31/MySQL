CREATE DATABASE IF NOT EXISTS Bookstore;
USE Bookstore;

CREATE TABLE customers(
customer_id INT PRIMARY KEY,
name varchar(15),
email varchar(30),
country varchar(10)
);

INSERT INTO customers
VALUES
(1,	"Alice Johnson", "alice@example.com", "USA"),
(2,	"Bob Smith", "bob@example.com",	"Canada"),
(3,	"Carol White", "carol@example.com",	"UK");


CREATE TABLE books(
book_id INT PRIMARY KEY,
title varchar(30),
author varchar(15),
price INT,
stock_quantity INT
);
DROP TABLE books;
INSERT INTO books
VALUES
(101,"The MySQL Guide",	"Jane Doe",29.99,50),
(102,"Learning SQL","John Smith",39.95,20),
(103,"Advanced Database Design","Emily Johnson",49.50,15);

CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
order_date DATE
);

INSERT INTO orders
VALUES
(201,1,	"2024-12-01"),
(202,2,	"2024-12-05"),
(203,1, "2025-01-15");

CREATE TABLE order_items(
order_item_id INT PRIMARY KEY,
order_id INT,
FOREIGN KEY (order_id) REFERENCES orders(order_id),
book_id INT,
FOREIGN KEY (book_id) REFERENCES books(book_id),
quantity INT
);

INSERT INTO order_items
VALUES
(301,201,101,2),
(302,201,102,1),
(303,202,103,1),
(304,203,101,1),
(305,203,103,2);

/*List all books that are in stock.*/
SELECT 
b.book_id,
b.title,
b.author,
b.price,
IFNULL(SUM(oi.quantity),0) AS Ordered_Quantity,
b.stock_quantity - IFNULL(SUM(oi.quantity),0)  AS Remaining_Quantity
FROM books AS b
LEFT JOIN order_items AS oi ON b.book_id = oi.book_id
GROUP BY b.book_id,b.title,b.author,b.price
HAVING Remaining_Quantity > 0;

/*Find the total amount spent by each customer*/
SELECT
c.customer_id,
c.name,
SUM(b.price * oi.quantity) AS Money_Spent
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
JOIN order_items AS oi ON o.order_id = oi.order_id
JOIN books AS b ON oi.book_id = b.book_id
GROUP BY 
c.customer_id, c.name
ORDER BY 
Money_Spent DESC;
