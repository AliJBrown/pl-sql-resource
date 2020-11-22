--chap 9 bookwork

--Database trigger syntax and options

/*
CREATE OR REPLACE TRIGGER TRIGGER_NAME
    [BEFORE,AFTER] -- define timing of trigger firing
    [INSERT, DELETE, UPDATE] -- Event causing trigger to fire
    [OF column_name] -- Event causing trigger to fire
ON table or view name -- Event causing trigger to fire
    [REFERENCING OLD as name| NEW as name] -- Indicates reference calue names in the DML statement
    [FOR EACH ROW] -- define timing of trigger firing
    [WHEN condition] -- define timing of trigger firing
    Trigger body; -- PL/SQL block

*/

/*
CREATE OR REPLACE TRIGGER product_inventory_trg
    AFTER UPDATE OF orderplaced ON BB_BASKET
    FOR EACH ROW
    WHEN (OLD.orderplaced<>1 AND NEW.orderplaced = 1)
DECLARE
    CURSOR basketitem_cur IS
    SELECT idproduct, quantity, OPTION1
        FROM BB_BASKETITEM
        WHERE IDBASKET = :NEW.idbasket;
        lv_chg_num NUMBER(3,1);
BEGIN
    FOR basketitem_rec IN basketitem_cur LOOP
        IF basketitem_rec.option1 = 1 THEN
            lv_chg_num := (.5*basketitem_rec.quantity);
        ELSE
            lv_chg_num := basketitem_rec.quantity;
        END IF;
    UPDATE BB_PRODUCT
    SET stock = stock - lv_chg_num
        WHERE idproduct = basketitem_rec.idproduct;
    END LOOP;
END;
*/