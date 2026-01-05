
DROP TABLE orders;
DROP TABLE customers; 
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    city VARCHAR(255)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status ENUM('pending', 'completed', 'cancelled'),
    total_amount decimal(10, 2), 
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
INSERT INTO customers (customer_id, full_name, city) VALUES
(1, 'Nguyễn Văn An', 'Hà Nội'),
(2, 'Trần Thị Bình', 'TP Hồ Chí Minh'),
(3, 'Lê Văn Cường', 'Đà Nẵng'),
(4, 'Phạm Thị Dung', 'Hải Phòng'),
(5, 'Hoàng Văn Em', 'Cần Thơ');

INSERT INTO orders (order_id, customer_id, order_date, status, total_amount) VALUES
(101, 1, '2025-01-01', 'completed', 1500000),
(102, 1, '2025-01-05', 'pending',   800000),
(103, 2, '2025-01-03', 'completed', 1200000),
(104, 3, '2025-01-04', 'cancelled', 500000),
(105, 4, '2025-01-06', 'completed', 2000000);


-- hiển thị danh sách đơn kèm tên khách hàng
SELECT 
    o.order_id,
    c.full_name,
    o.order_date,
    o.status
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id;

-- hiển thị mỗi khách đặt bao nhiêu đơn 
SELECT 
    c.customer_id,
    c.full_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;

-- các khách hàng có ít nhất 1 đơn 
SELECT 
    c.customer_id,
    c.full_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
HAVING COUNT(o.order_id) >= 1;

-- Tổng tiền mỗi khách hàng đã chi tiêu
select 
	c.customer_id, 
    c.full_name, 
    sum(o.total_amount) as total_spent
from customers c
join orders o 
