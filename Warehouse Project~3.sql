CREATE OR REPLACE PROCEDURE add_supplier(
    p_supplier_name VARCHAR2,
    p_company_name VARCHAR2,
    p_phone VARCHAR2,
    p_email VARCHAR2,
    p_address VARCHAR2
)
IS
BEGIN
    INSERT INTO suppliers(
        supplier_name,
        company_name,
        phone,
        email,
        address
    )
    VALUES(
        p_supplier_name,
        p_company_name,
        p_phone,
        p_email,
        p_address
    );
    DBMS_OUTPUT.PUT_LINE('Supplier Added Successfully');
END;
/


CREATE OR REPLACE PROCEDURE add_product(
    p_product_name VARCHAR2,
    p_category_id NUMBER,
    p_barcode VARCHAR2,
    p_unit VARCHAR2,
    p_profit NUMBER,
    p_reorder NUMBER
)
IS
BEGIN
    INSERT INTO products(
        product_name,
        category_id,
        barcode,
        unit,
        minimum_profit_percent,
        reorder_level
    )
    VALUES(
        p_product_name,
        p_category_id,
        p_barcode,
        p_unit,
        p_profit,
        p_reorder
    );
    DBMS_OUTPUT.PUT_LINE('Product Added Successfully');
END;
/


CREATE OR REPLACE PROCEDURE add_purchase(
    p_supplier_id NUMBER,
    p_user_id NUMBER,
    p_invoice VARCHAR2
)
IS
BEGIN
    INSERT INTO purchases(
        supplier_id,
        user_id,
        invoice_number
    )
    VALUES(
        p_supplier_id,
        p_user_id,
        p_invoice
    );
    
    DBMS_OUTPUT.PUT_LINE('Purchase Created Successfully');
END;
/


CREATE OR REPLACE PROCEDURE sell_product(
    p_customer_id NUMBER,
    p_user_id NUMBER,
    p_product_id NUMBER,
    p_quantity NUMBER,
    p_price NUMBER
) IS
    v_remaining NUMBER := p_quantity;
    v_total NUMBER := 0;
    v_sale_id NUMBER;
BEGIN
    INSERT INTO sales(customer_id, user_id, sale_date, total_amount)
    VALUES (p_customer_id, p_user_id, SYSDATE, 0);
    
    FOR r IN(SELECT * FROM purchase_details
            WHERE product_id = p_product_id AND remaining_quantity > 0 ORDER BY purchase_detail_id) LOOP 
            EXIT WHEN v_remaining = 0;
            
        DECLARE
            v_take NUMBER;
        BEGIN
            v_take := LEAST(r.remaining_quantity, v_remaining);
            
            UPDATE purchase_details
            SET remaining_quantity = remaining_quantity - v_take
            WHERE purchase_detail_id = r.purchase_detail_id;
            
            INSERT INTO sale_details(
                sale_id,
                product_id,
                purchase_detail_id,
                quantity, 
                selling_price )
            values (
                (SELECT MAX(sale_id) FROM sales),
                p_product_id,
                r.purchase_detail_id,
                v_take,
                p_price ) RETURNING sale_id INTO v_sale_id;
                
            v_remaining := v_remaining - v_take;
            -- v_total := v_total + (v_take * p_price);
            
        END;
    END LOOP;
    
--    UPDATE sales
--    SET total_amount = v_total
--    WHERE sale_id = v_sale_id;
    
    DBMS_OUTPUT.PUT_LINE('Sale completed successfully');
END;
/


BEGIN
    sell_product(2, 2, 3, 100, 250);
END;
/


CREATE OR REPLACE PROCEDURE return_product (
    p_sale_detail_id NUMBER,
    p_quantity NUMBER
) IS
    v_purchase_detail_id NUMBER;
BEGIN
    SELECT purchase_detail_id
    INTO v_purchase_detail_id
    FROM sale_details
    WHERE sale_detail_id = p_sale_detail_id;
    
    UPDATE purchase_details
    SET remaining_quantity = remaining_quantity + p_quantity
    WHERE purchase_detail_id = v_purchase_detail_id;
    
    DBMS_OUTPUT.PUT_LINE('Product returned successfully');
END;
/

BEGIN
    return_product(2, 30);
END;

SELECT * FROM sale_details;

SELECT * FROM purchase_details;

SELECT * FROM sales;


