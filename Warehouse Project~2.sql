INSERT INTO categories (category_name, description)
VALUES ('Drinks', 'Beverages'),
       ('Dairy', 'Milk products'),
       ('Snacks', 'Food snacks');


INSERT INTO suppliers (supplier_name, company_name, phone, email, address)
VALUES ('Ahmad', 'ABC Trading', '0790000000', 'ahmad@abc.com', 'Amman'),
       ('Omar', 'XYZ Supply', '0791111111', 'omar@xyz.com', 'Zarqa'),
       ('Mohammad', 'Al Noor Trade', '079200001', 'm@noor.com', 'Amman'),
       ('Fahad', 'East Supply', '079200002', 'f@east.com', 'Zarqa'),
       ('Sami', 'Quick Trade', '0792000003', 's@quick.com', 'Irbid');


INSERT INTO customers (customer_name, phone, address)
VALUES ('Ali', '0792222222', 'Amman'),
       ('Sara', '0793333333', 'Amman'),
       ('Tamer', '0791000001', 'Amman'),
       ('Yara', '0791000002', 'Zarqa'),
       ('Majd', '0791000003', 'Irbid'),
       ('Salem', '0791000004', 'Aqaba'),
       ('Reem', '0791000005', 'Amman'),
       ('Othman', '0791000006', 'Jerash'),
       ('Hani', '0791000007', 'Amman'),
       ('Nour', '0791000008', 'Zarqa');
       

INSERT INTO users_system (username, full_name, password, role)
VALUES ('admin', 'System Admin', '1234', 'ADMIN'),
       ('cashier1', 'Cashier One', '12354', 'CASHIER');


INSERT INTO products (product_name, category_id, barcode, unit, minimum_profit_percent, reorder_level, status, created_at)
VALUES ('Cola Zero', 1, 'COLA-01', 'PCS', 20, 15, 'ACTIVE', SYSDATE),
       ('Pepsi', 1, 'PEPSI-01', 'PCS', 20, 10, 'ACTIVE', SYSDATE),
       ('Sprite', 1, 'SPRITE-01', 'PCS', 20, 10, 'ACTIVE', SYSDATE),
       ('Milk Almarai', 2, 'MILK-01', 'PCS', 15, 20, 'ACTIVE', SYSDATE),
       ('Cheese', 2, 'CHEESE-01', 'PCS', 25, 10, 'ACTIVE', SYSDATE),
       ('Doritos', 3, 'DORITOS-01', 'PCS', 30, 20, 'ACTIVE', SYSDATE),
       ('Lays Chips', 3, 'LAYS-01', 'PCS', 30, 25, 'ACTIVE', SYSDATE);
       

INSERT INTO purchases (supplier_id, user_id, invoice_number)
VALUES (1, 1, 'INV-001');
       
INSERT INTO purchase_details (
    purchase_id,
    product_id,
    quantity,
    remaining_quantity,
    purchase_price,
    selling_price,
    expiry_date
)
VALUES (1, 1, 100, 100, 0.50, 0.80, SYSDATE + 365),
       (1, 1, 50, 50, 0.60, 0.90, SYSDATE + 365);       
       
SELECT * FROM customers;
SELECT * FROM users_system;
SELECT * FROM products;
SELECT * FROM purchase_details;       

INSERT INTO purchases (supplier_id, user_id, invoice_number)
VALUES (1, 2, 'INV-002'),
       (1, 2, 'INV-003'),
       (2, 2, 'INV-004')
  
       
INSERT INTO purchase_details (
    purchase_id,
    product_id,
    quantity,
    remaining_quantity,
    purchase_price,
    selling_price,
    expiry_date
)
VALUES (3, 2, 100, 200, 0.90, 1.0, SYSDATE - 30),
       (4, 3, 180, 50, 0.40, 0.90, SYSDATE - 36);    
       
       
SELECT * FROM SALES;


INSERT INTO sales(customer_id, user_id, total_amount)
VALUES (2, 2, 100),
       (3, 2, 150),
       (2, 1, 200);


SELECT * FROM sales;

SELECT * FROM sale_details;

INSERT INTO sale_details(sale_id, product_id, purchase_detail_id, quantity, selling_price)
VALUES(3, 4, 4, 100, 200),
      (4, 5, 4, 200, 120);
      
      


