CREATE OR REPLACE VIEW vw_current_stock AS
SELECT 
    p.product_id,
    p.product_name,
    SUM(pd.remaining_quantity) AS current_stock
FROM products p
JOIN purchase_details pd ON p.product_id = pd.product_id
GROUP BY p.product_id, p.product_name;


CREATE OR REPLACE VIEW vw_expired_products AS
SELECT 
    p.product_name,
    pd.remaining_quantity,
    pd.expiry_date
FROM products p
JOIN purchase_details pd ON p.product_id = pd.product_id
WHERE pd.expiry_date < SYSDATE + 30;


CREATE OR REPLACE VIEW vw_sales_report AS
SELECT 
    s.sale_id,
    s.sale_date,
    c.customer_name,
    s.total_amount
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id;


CREATE OR REPLACE VIEW vw_sales_details AS
SELECT 
    sd.sale_id,
    p.product_name,
    sd.quantity,
    sd.selling_price
FROM sale_details sd
JOIN products p ON sd.product_id = p.product_id


CREATE OR REPLACE VIEW vw_product_expiry AS
SELECT
    pd.purchase_detail_id AS batch_id,
    pd.product_id,
    p.product_name,
    pd.quantity,
    pd.remaining_quantity,
    pd.expiry_date,
   get_expiry_details(purchase_detail_id) AS days_left
FROM purchase_details pd
JOIN products p
    ON pd.product_id = p.product_id

