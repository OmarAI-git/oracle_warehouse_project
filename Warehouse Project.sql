CREATE OR REPLACE PROCEDURE sell_product(
    p_customer_id NUMBER,
    p_user_id NUMBER,
    p_product_id NUMBER,
    p_quantity NUMBER,
    p_price NUMBER
) IS
    v_remaining NUMBER := p_quantity;
BEGIN
    INSERT INTO sales(customer_id, user_id, sale_date, total_amount)
    VALUES (p_customer_id, p_user_id, SYSDATE, 0);
    
    FOR R IN(SELECT * FROM purchase_details
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
                p_price );
                
            v_remaining := v_remaining - v_take;
            
        END;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Sale completed successfully');
END;
/

            

BEGIN
    sell_product(1, 1, 1, 70, 2.5);
END;
/

CREATE OR REPLACE PROCEDURE return_product (
    p_sale_detail_id NUMBER,
    p_quantity NUMBER
)
IS
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


