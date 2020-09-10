-- DECLARE
--     lv_state_txt CHAR(2) :='ME';
--     lv_sub_num NUMBER(5,2) := 100;
--     lv_tax_num NUMBER(4,2) := 0;
-- BEGIN
--     CASE lv_state_txt
--         WHEN 'VA' THEN lv_tax_num := lv_sub_num * .06;
--         WHEN 'ME' THEN lv_tax_num := lv_sub_num * .05;
--         WHEN 'NY' THEN lv_tax_num := lv_sub_num * .07;
--         ELSE lv_tax_num := lv_sub_num * .04;
--     END CASE;
--     DBMS_OUTPUT.PUT_LINE(lv_tax_num);
-- END;

DECLARE
    lv_state_txt CHAR(2) :='VA';
    lv)zip_txt CHAR(5) := '23321';
    lv_sub_num NUMBER(5,2) := 100;
    lv_tax_num NUMBER(4,2) := 0;
BEGIN
    CASE
        -- Searched Case Statement
        WHEN lv_zip_txt = '23321' THEN
            lv_tax_num := lv_sub_num * .02;
        WHEN lv_state_txt = 'VA' THEN 
            lv_tax_num := lv_sub_num * .06;
        ELSE lv_tax_num := lv_sub_num * .04;
    END CASE;
    DBMS_OUTPUT.PUT_LINE(lv_tax_num);
END;
