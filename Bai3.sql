-- Tính tổng doanh thu theo từng ngày
SELECT 
    order_date,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY order_date;

-- Tính số lượng đơn hàng theo từng ngày
SELECT 
    order_date,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_date;

-- Chỉ hiển thị các ngày có doanh thu > 10000000
SELECT 
    order_date,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY order_date
HAVING SUM(total_amount) > 10000000;


