DROP TABLE products;
DROP TABLE order_items;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    price DECIMAL(10,2)
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT
);


INSERT INTO products (product_id, product_name, price) VALUES
(1, 'Laptop Dell', 15000000),
(2, 'Chuột Logitech', 500000),
(3, 'Bàn phím cơ', 1200000),
(4, 'Tai nghe Sony', 2000000),
(5, 'Màn hình LG', 7000000);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(101, 1, 1),
(101, 2, 2),
(102, 3, 1),
(103, 4, 2),
(105, 5, 1),
(106, 3, 5),
(107, 4, 6),
(108, 4, 5),
(109, 5, 2),
(110, 5, 10);


-- Hiển thị mỗi sản phẩm đã bán được bao nhiêu sản phẩm
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_name;


-- Tính doanh thu của từng sản phẩm
SELECT
    p.product_name,
    SUM(oi.quantity * p.price) AS total_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_name;



-- Chỉ hiển thị sản phẩm có doanh thu > 5.000.000
SELECT
    p.product_name,
    SUM(oi.quantity * p.price) AS total_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_name
HAVING SUM(oi.quantity * p.price) > 5000000;



-- tổng hợp tình hình kinh doanh
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity,
    SUM(oi.quantity * p.price) AS total_revenue,
    SUM(oi.quantity * p.price) / SUM(oi.quantity) AS avg_price
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_name
HAVING SUM(oi.quantity) >= 10
ORDER BY total_revenue DESC
LIMIT 5;


