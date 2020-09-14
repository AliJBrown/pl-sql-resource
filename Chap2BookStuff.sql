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

-- DECLARE
--     lv_state_txt CHAR(2) :='VA';
--     lv)zip_txt CHAR(5) := '23321';
--     lv_sub_num NUMBER(5,2) := 100;
--     lv_tax_num NUMBER(4,2) := 0;
-- BEGIN
--     CASE
--         -- Searched Case Statement
--         WHEN lv_zip_txt = '23321' THEN
--             lv_tax_num := lv_sub_num * .02;
--         WHEN lv_state_txt = 'VA' THEN 
--             lv_tax_num := lv_sub_num * .06;
--         ELSE lv_tax_num := lv_sub_num * .04;
--     END CASE;
--     DBMS_OUTPUT.PUT_LINE(lv_tax_num);
-- END;

-- DECLARE
--     lv_state_txt CHAR(2) :='ME';
--     lv_sub_num NUMBER(5,2) := 100;
--     lv_tax_num NUMBER(4,2) := 0;
-- BEGIN
-- -- Case as an expression 
--     lv_tax_num := CASE lv_state_txt
--         WHEN 'VA' THEN lv_sub_num * .06
--         WHEN 'ME' THEN lv_sub_num * .05
--         WHEN 'NY' THEN lv_sub_num * .07
--         ELSE lv_sub_num * .04
--     END;
--     DBMS_OUTPUT.PUT_LINE(lv_tax_num);
-- END;


-- BASIC LOOP
-- DECLARE
--     lv_cnt_num NUMBER(2) := 1;
-- BEGIN
--     LOOP
--         DBMS_OUTPUT.PUT_LINE(lv_cnt_num);
--         EXIT WHEN lv_cnt_num >=5;
--         lv_cnt_num := lv_cnt_num + 1;
--     END LOOP;
-- END;

--BASIC LOOP (runs at least once)
-- DECLARE
--     lv_cnt_num NUMBER(2) :=1;
-- BEGIN
--     LOOP
--         DBMS_OUTPUT.PUT_LINE(lv_cnt_num);
--         lv_cnt_num := lv_cnt_num + 1;
--         EXIT WHEN lv_cnt_num >=5;
--     END LOOP;
-- END;

--LOOP WITH EXIT STATEMENT
-- DECLARE
--     lv_cnt_num NUMBER(2) :=1;
-- BEGIN
--     LOOP
--         DBMS_OUTPUT.PUT_LINE(lv_cnt_num);
--         IF lv_cnt_num >= 5 THEN
--             EXIT;
--         ELSE
--             lv_cnt_num := lv_cnt_num + 1;
--     END LOOP;
-- END;


--WHILE LOOP
-- DECLARE
--     lv_cnt_num NUMBER(2) :=1;
-- BEGIN
--     WHILE lv_cnt_num <= 5 LOOP
--         DBMS_OUTPUT.PUT_LINE(lv_cnt_num);
--         lv_cnt_num := lv_cnt_num + 1;
--     END LOOP;
-- END;


--FOR LOOP
-- BEGIN
--     FOR i IN 1..5 LOOP
--         DBMS_OUTPUT.PUT_LINE(i);
--     END LOOP;
-- END;


--CONTINUE STATEMENT
-- DECLARE
--     lv_cnt_num NUMBER(3) := 0;
-- BEGIN
--     FOR i IN 1..25 LOOP
--         CONTINUE WHEN MOD(i,5) <> 0;
--         DBMS_OUTPUT.PUT_LINE('Loop i value' || i);
--         lv_cnt_num := lv_cnt_num + 1;
--     END LOOP;
--     DBMS_OUTPUT.PUT_LINE('Final execution count: ' || lv_cnt_num);
-- END;


--NESTED LOOP
-- BEGIN
--     FOR oi IN 1..3 LOOP
--         DBMS_OUTPUT.PUT_LINE('Outer Loop');
--         FOR ii IN 1..2 LOOP
--             DBMS_OUTPUT.PUT_LINE("Inner Loop");
--         END LOOP;
--     END LOOP;
-- END;



