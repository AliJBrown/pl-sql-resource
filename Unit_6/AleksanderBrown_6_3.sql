--Aleksander Brown
--Assignment 6-3

CREATE OR REPLACE FUNCTION num_purch_sf
    (p_idShopper IN bb_basket.idshopper%TYPE)
    RETURN NUMBER
IS
    lv_ord_num NUMBER(3);
BEGIN
    SELECT sum(orderplaced)
        INTO lv_ord_num
        FROM bb_basket
        WHERE idshopper = p_idShopper;
    RETURN lv_ord_num;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Other Error');
END;

-- /
-- SELECT idShopper, NUM_PURCH_SF(idShopper) as "Total Purchases"
-- FROM    bb_shopper
-- WHERE idShopper = 23;