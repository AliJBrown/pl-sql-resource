--Aleksander Brown
--Assignment 6-4

CREATE OR REPLACE FUNCTION day_ord_sf
    (p_order_date bb_basket.dtcreated%TYPE)
    RETURN VARCHAR2
IS
    lv_day_txt VARCHAR2(10);
BEGIN
    lv_day_txt := TO_CHAR(p_order_date,'DAY');
    RETURN lv_day_txt;
END;

-- /
-- SELECT DAY_ORD_SF(dtcreated) DAY, COUNT(idBasket) COUNT
-- FROM bb_basket
-- GROUP BY DAY_ORD_SF(dtcreated)
-- ORDER BY COUNT DESC;