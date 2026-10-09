
CREATE DATABASE OM;
USE OM;


CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    city VARCHAR(50) DEFAULT 'Chandigarh'
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE DEFAULT (CURRENT_DATE),
    total_amount DECIMAL(10, 2) CHECK (total_amount > 0),
    status VARCHAR(20) DEFAULT 'Pending' CHECK (status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);

INSERT INTO Customers (customer_id, name, email, phone, city) VALUES
(1, 'Aarav Sharma', 'aarav.s@example.com', '9876543210', 'Delhi'),
(2, 'Priya Singh', 'priya.s@example.com', '9876543211', 'Mumbai'),
(3, 'Rohan Verma', 'rohan.v@example.com', '9876543212', 'Chandigarh'),
(4, 'Ananya Patel', 'ananya.p@example.com', '9876543213', 'Bangalore'),
(5, 'Kabir Mehta', 'kabir.m@example.com', '9876543214', 'Delhi');

INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES
(101, 1, '2026-10-01', 12500.00, 'Shipped'),
(102, 1, '2026-10-03', 3500.00, 'Delivered'),
(103, 2, '2026-10-04', 6200.00, 'Pending'),
(104, 3, '2026-10-05', 2500.00, 'Processing'),
(105, 4, '2026-10-06', 15000.00, 'Delivered');

SELECT * 
FROM Orders 
WHERE total_amount > 5000;

SELECT 
    customer_id, 
    SUM(total_amount) AS total_order_amount 
FROM Orders 
GROUP BY customer_id;

SELECT 
    c.customer_id, 
    c.name, 
    SUM(o.total_amount) AS total_spent 
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING SUM(o.total_amount) > 10000;

SELECT AVG(total_amount) AS average_order_amount 
FROM Orders;

UPDATE Orders 
SET status = 'Delivered' 
WHERE order_id = 103;

DELETE FROM Orders 
WHERE order_id = 104;

ALTER TABLE Orders 
ADD payment_method VARCHAR(30) DEFAULT 'Credit Card';

SELECT * 
FROM Orders;