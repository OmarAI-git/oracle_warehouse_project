CREATE OR REPLACE FUNCTION get_stock(
    p_product_id NUMBER
)
RETURN NUMBER IS
    v_stock NUMBER;
BEGIN
    SELECT NVL(SUM(remaining_quantity), 0)
    INTO v_stock
    FROM purchase_details
    WHERE product_id = p_product_id;
    
    RETURN v_stock;
END;
/


CREATE OR REPLACE FUNCTION calculate_profit(
    p_purchase_price NUMBER,
    p_selling_price NUMBER,
    p_quantity NUMBER
)RETURN NUMBER IS
BEGIN
    RETURN (p_selling_price - p_purchase_price) * p_quantity;
END;
/


CREATE OR REPLACE FUNCTION get_expiry_details(
    p_purchase_detail_id NUMBER )
    RETURN NUMBER IS 
        v_expiry_day NUMBER(3);
        v_expiry_date DATE;
BEGIN
    SELECT expiry_date
    INTO v_expiry_date 
    FROM purchase_details
    WHERE purchase_detail_id = p_purchase_detail_id;
    
    v_expiry_day := v_expiry_date - SYSDATE;

    RETURN v_expiry_day;
END;
/


SELECT get_stock(1)
FROM dual;

SELECT * FROM purchase_details;

SELECT calculate_profit(0.50, 0.80, 100)
FROM dual;

SELECT * FROM purchase_details;

SELECT get_expiry_details(5)
FROM dual;

SELECT get_expiry_details(8)
FROM dual;

