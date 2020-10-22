--Aleksander Brown
--Assignment 6-2

CREATE OR REPLACE FUNCTION total_purch_sf
    (p_shopperId IN bb_basket.idshopper%TYPE)
    RETURN NUMBER
IS
    lv_tot_num bb_basket.total%TYPE;
BEGIN
    SELECT sum(total)
        INTO lv_tot_num
        FROM bb_basket
        WHERE idshopper = p_shopperId;
    RETURN lv_tot_num;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Other Error');
END;

/
SELECT idShopper, TOTAL_PURCH_SF(idShopper) as "Total Purchases"
    INTO lv_id_num, lv_tot_num
    FROM    bb_shopper
    ORDER  by idShopper;