--Aleksander Brown
--Assignment 5-5

CREATE OR REPLACE PROCEDURE STATUS_SHIP_SP
    (p_basket bb_basketstatus.idbasket%TYPE,
    p_ship_date bb_basketstatus.dtstage%TYPE,
    p_shipper bb_basketstatus.shipper%TYPE,
    p_tracking_num bb_basketstatus.shippingnum%TYPE)
IS

BEGIN
    INSERT INTO bb_basketstatus
    VALUES (BB_STATUS_SEQ.NEXTVAL,p_basket,3,p_ship_date,null,p_shipper,p_tracking_num);

END;


/
DECLARE
    lv_basket_num bb_basketstatus.idbasket%TYPE := 3;
    lv_ship_date bb_basketstatus.dtstage%TYPE := '20-FEB-12';
    lv_shipper_txt bb_basketstatus.shipper%TYPE := 'UPS';
    lv_tracking_txt bb_basketstatus.shippingnum%TYPE := 'ZW2384YXK4957';
BEGIN
    STATUS_SHIP_SP(lv_basket_num,lv_ship_date,lv_shipper_txt,lv_tracking_txt);
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Other Error');
END;