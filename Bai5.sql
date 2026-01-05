DROP TABLE orders;
DROP TABLE customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    city VARCHAR(255)
);

-- 2. Tạo bảng orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status ENUM('pending', 'completed', 'cancelled'),
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 3. Thêm dữ liệu bảng customers
INSERT INTO customers (customer_id, full_name, city) VALUES
(1, 'Nguyễn Văn An', 'Hà Nội'),
(2, 'Trần Thị Bình', 'TP Hồ Chí Minh'),
(3, 'Lê Văn Cường', 'Đà Nẵng'),
(4, 'Phạm Thị Dung', 'Hải Phòng'),
(5, 'Hoàng Văn Em', 'Cần Thơ');

-- 4. Thêm dữ liệu bảng orders
INSERT INTO orders (order_id, customer_id, order_date, status, total_amount) VALUES
(101, 1, '2025-01-01', 'completed', 4000000),
(102, 1, '2025-01-05', 'completed', 3500000),
(106, 1, '2025-01-10', 'completed', 3000000),

(103, 2, '2025-01-03', 'completed', 5000000),
(107, 2, '2025-01-08', 'completed', 4000000),
(108, 2, '2025-01-15', 'completed', 3000000),

(104, 3, '2025-01-04', 'completed', 2000000),
(109, 3, '2025-01-09', 'completed', 1500000),

(105, 4, '2025-01-06', 'completed', 8000000);

-- 5. Truy vấn khách hàng VIP
SELECT 
    c.customer_id,
    c.full_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent,
    AVG(o.total_amount) AS avg_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
HAVING COUNT(o.order_id) >= 3
   AND SUM(o.total_amount) > 10000000
ORDER BY total_spent DESC;
