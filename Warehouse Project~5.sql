CREATE OR REPLACE TRIGGER trg_check_expiry
BEFORE INSERT ON sale_details
FOR EACH ROW
DECLARE
    v_expiry DATE;
BEGIN
    SELECT expiry_date
    INTO v_expiry
    FROM purchase_details
    WHERE purchase_detail_id = :NEW.purchase_detail_id;

    IF v_expiry < SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'Cannot sell expired product');
    END IF;
END;
/



CREATE OR REPLACE TRIGGER trg_check_stock
BEFORE UPDATE ON purchase_details
FOR EACH ROW
BEGIN
    IF :NEW.remaining_quantity < 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Stock cannot be negative');
    END IF;
END;
/

-- DROP TRIGGER trg_check_stock;


CREATE OR REPLACE TRIGGER trg_update_total
AFTER INSERT ON sale_details
FOR EACH ROW
BEGIN
    UPDATE sales
    SET total_amount = NVL(total_amount, 0) + (:NEW.quantity * :NEW.selling_price)
    WHERE sale_id = :NEW.sale_id;
END;
/


CREATE OR REPLACE TRIGGER trg_audit_sales
AFTER INSERT ON sales
FOR EACH ROW
BEGIN
    INSERT INTO audit_log(action, table_name)
    VALUES ('INSERT SALE ID ' || :NEW.sale_id, 'SALES');
END;
/

SELECT * FROM audit_log;



