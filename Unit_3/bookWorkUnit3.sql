--block containing select statement

-- DECLARE
--   lv_qty_num NUMBER(3);
-- BEGIN
--   SELECT SUM (quantity)
--     INTO lv_qty_num
--     FROM bb_basketitem
--     WHERE idBasket = 9;
--   DBMS_OUTPUT.PUT_LINE(lv_qty_num);
-- END;


--multiple scalar values from query
--
-- DECLARE
--   lv_created_date DATE;
--   lv_basket_num NUMBER(3);
--   lv_qty_num NUMBER(3);
--   lv_sub_num NUMBER(5,2);
--   lv_days_num NUMBER(3);
--   lv_shopper_num NUMBER(3) := 25;
-- BEGIN
--   SELECT idBasket, dtcreated, quantity, subtotal
--     INTO lv_basket_num, lv_created_date, lv_qty_num,lv_sub_num
--     FROM bb_basket
--     WHERE idShopper = lv_shopper_num
--       AND orderplaced = 0;
--     lv_days_num := TO_DATE('02/28/12','mm/dd/yy') - lv_created_date;
--     DBMS_OUTPUT.PUT_LINE(lv_basket_num || ' * ' || lv_created_date || ' * ' ||
--       lv_qty_num || ' * ' || lv_sub_num || ' * ' || lv_days_num);
-- END;


--Challenge 1
--
-- DECLARE
--   lv_card#_txt VARCHAR(20);
--   lv_card_type CHAR(1);
-- BEGIN
--   SELECT cardnumber, cardtype
--     INTO lv_card#_txt, lv_card_type
--     FROM bb_basket
--     WHERE idbasket = 10;
--   DBMS_OUTPUT.PUT_LINE(lv_card#_txt || ' * ' || lv_card_type);
-- END;


--anchored data type (%type) pulls from database data type instead of declaring it
--
-- DECLARE
--   lv_basket_num bb_basket.idBasSELECT idproj, projname, COUNT(idpledge) "pledges", SUM(pledgeamt) "totalamt", AVG(pledgeamt) "avgamt"
    FROM dd_project JOIN dd_pledge USING (idproj)
    GROUP BY idproj,projname
    HAVING idproj = 501;ket%TYPE;
--   lv_created_date bb_basket.dtcreated%TYPE;
--   lv_qty_num bb_basket.quantity%TYPE;
--   lv_sub_num bb_basket.subtotal%TYPE;
--   lv_days_num NUMBER(3);
-- BEGIN
--   SELECT idBasket, dtcreated, quantity, subtotal
--     INTO lv_basket_num, lv_created_date, lv_qty_num, lv_sub_num
--     FROM bb_basket
--     WHERE idShopper = 25
--       AND orderplaced = 0;
--     lv_days_num := TO_DATE('02/28/12','mm//dd/yy') - lv_created_date;
--     DBMS_OUTPUT.PUT_LINE(lv_basket_num || ' * ' || lv_created_date || ' * ' ||
--     lv_qty_num || ' * ' || lv_sub_num || ' * ' || lv_days_num);
-- END;


-- Decision Structure with query
--
-- DECLARE
--   lv_state_txt bb_basket.shipstate%TYPE;
--   lv_sub_num bb_basket.subtotal%TYPE;
--   lv_tax_num NUMBER(4,2) := 0;
-- BEGIN
--   SELECT subtotal, shipstate
--     INTO lv_sub_num, lv_state_txt
--     FROM bb_basket
--       WHERE idbasket = 6;
--     IF lv_state_txt = 'VA' THEN
--       lv_tax_num := lv_sub_num * .06;
--     END IF;
--   DBMS_OUTPUT.PUT_LINE('ST: ' || lv_state_txt || ' Sub: ' || lv_sub_num ||
--     ' Tax: ' || lv_tax_num);
--   END;


-- Complex Decision with query
-- DECLARE
--   lv_state_txt bb_basket.shipstate%TYPE;
--   lv_sub_num bb_basket.subtotal%TYPE;
--   lv_tax_num NUMBER(4,2) := 0;
-- BEGIN
--   SELECT subtotal, shipstate
--     INTO lv_sub_num, lv_state_txt
--     FROM bb_basket
--       WHERE idbasket = 4;
--   IF lv_state_txt = 'VA' THEN
--     lv_tax_num := lv_sub_num * .06;
--   ELSIF lv_state_txt = 'ME' THEN
--     lv_tax_num := lv_sub_num * .05;
--   ELSIF lv_state_txt = 'NY' THEN
--     lv_tax_num := lv_sub_num * .07;
--   ELSE
--     lv_tax_num := lv_sub_num * .04;
--   END IF;
--     DBMS_OUTPUT.PUT_LINE('ST: ' || lv_state_txt || ' Sub: ' || lv_sub_num ||
--       ' Tax: ' || lv_tax_num);
-- END;


-- CASE with query
--
-- DECLARE
--   lv_state_txt bb_basket.shipstate%TYPE;
--   lv_sub_num bb_basket.subtotal%TYPE;
--   lv_tax_num NUMBER(4,2) := 0;
-- BEGIN
--   SELECT subtotal, shipstate
--     INTO lv_sub_num, lv_state_txt
--     FROM bb_basket
--       WHERE idbasket = 4;
--   CASE lv_state_txt
--     WHEN 'VA' THEN lv_tax_num := lv_sub_num * .06;
--     WHEN 'ME' THEN lv_tax_num := lv_sub_num * .05;
--     WHEN 'NY' THEN lv_tax_num := lv_sub_num * .07;
--     ELSE lv_tax_num := lv_sub_num * .04;
--   END CASE;
--     DBMS_OUTPUT.PUT_LINE('ST: ' || lv_state_txt || ' Sub: ' || lv_sub_num ||
--       ' Tax: ' -- DECLARE
--   lv_created_date DATE;
--   lv_basket_num NUMBER(3);
--   lv_qty_num NUMBER(3);
--   lv_sub_num NUMBER(5,2);
--   lv_days_num NUMBER(3);
--   lv_shopper_num NUMBER(3) := 25;
-- BEGIN
--   SELECT idBasket, dtcreated, quantity, subtotal
--     INTO lv_basket_num, lv_created_date, lv_qty_num,lv_sub_num
--     FROM bb_basket
--     WHERE idShopper = lv_shopper_num
--       AND orderplaced = 0;
--     lv_days_num := TO_DATE('02/28/12','mm/dd/yy') - lv_created_date;
--     DBMS_OUTPUT.PUT_LINE(lv_basket_num || ' * ' || lv_created_date || ' * ' ||
--       lv_qty_num || ' * ' || lv_sub_num || ' * ' || lv_days_num);
-- END;|| lv_tax_num);
-- END;


-- INSERT in code block
--
-- DECLARE
--   lv_first_txt bb_shopper.firstname%TYPE := 'Jeffrey';
--   lv_last_txt bb_shopper.lastname%TYPE := 'Brand';
--   lv_email_txt bb_shopper.email%TYPE := 'jbrand@site.com';
-- BEGIN
--   INSERT INTO bb_shopper (idShopper, firstname, lastname, email)
--     VALUES (bb_shopper_seq.NEXTVAL, lv_first_txt, lv_last_txt, lv_email_txt);
--   COMMIT;
-- END;


-- UPDATE in code block
-- SELECT idbasket, orderplaced
--   FROM bb_basket
--   WHERE idbasket = 14;
-- --^^check value
-- --VV UPDATE
-- DECLARE
--   lv_basket_num bb_basket.idBasket%TYPE := 14;
-- BEGIN
--   UPDATE bb_basket
--     SET orderplaced = 1
--     WHERE idbasket = lv_basket_num;
--   COMMIT;
-- END;
-- / --symbol lets script continue after code block
-- --VVcheck value
-- SELECT idbasket, orderplaced
--   FROM bb_basket
--   WHERE idbasket = 14;


-- record data type must construct your own data TYPE
--
-- DECLARE
--   TYPE type_basket IS RECORD(
--     basket bb_basket.idBasket%TYPE,
--     created bb_basket.dtcreated%TYPE,
--     qty bb_basket.quantity%TYPE,
--     sub bb_basket.subtotal%TYPE
--   );
--   rec_basket type_basket; --declare variable of new type
--   lv_days_num NUMBER(3);
--   lv_shopper_num NUMBER(3) := 25;
-- BEGIN
--   SELECT idBasket, dtcreated, quantity, subtotal
--     INTO rec_basket
--     FROM bb_basket
--     WHERE idShopper = lv_shopper_num
--       AND orderplaced = 0;
--     lv_days_num := TO_DATE('02/28/12','mm/dd/yy') - rec_basket.created;
--     DBMS_OUTPUT.PUT_LINE(rec_basket.basket || ' * ' || rec_basket.created || ' * ' ||
--       rec_basket.qty || ' * ' || rec_basket.sub || ' * ' || lv_days_num);
-- END;


-- %ROWTYPE to create record variables to hold entire columns
--pulls types and column names to use as the record variable's fields
--
-- DECLARE
--   rec_shopper bb_shopper%ROWTYPE;
-- BEGIN
--   SELECT *
--     INTO rec_shopper
--     FROM bb_shopper
--     WHERE idshopper = 25;
--   DBMS_OUTPUT.PUT_LINE(rec_shopper.lastname);
--   DBMS_OUTPUT.PUT_LINE(rec_shopper.address);
--   DBMS_OUTPUT.PUT_LINE(rec_shopper.email);
-- END;



--following examples shhould have a COMMIT; statement in production



--Insert statement with record variables
--
-- DECLARE
--   rec_dept bb_department%ROWTYPE;
-- BEGIN
--   rec_dept.iddepartment :=4;
--   rec_dept.deptname := 'Teas';
--   rec_dept.deptdesc := 'Premium teas';
--   INSERT INTO bb_department
--     VALUES rec_dept;
-- END;


--UPDATE statement with record variables
--if you leave out a value when updating by record it nulls the values left out
--
-- DECLARE
--   rec_dept bb_department%ROWTYPE;
-- BEGIN
--   rec_dept.iddepartment :=4;
--   rec_dept.deptdesc := 'Premium teas from around the world';
--   rec_dept.deptimage := 'tea.gif';
--   UPDATE bb_department SET ROW = rec_dept
--     WHERE iddepartment = rec_dept.iddepartment;
-- END;


-- RETURNING clause eliminates the need to run a SELECT after an UPDATE
--
-- DECLARE
--   rec_dept bb_department%ROWTYPE;
-- BEGIN
--   UPDATE bb_department
--     SET deptname = 'Teas'
--     WHERE iddepartment = 4
--     RETURNING iddepartment, deptname, deptdesc, deptimage
--       INTO rec_dept;
--   DBMS_OUTPUT.PUT_LINE(rec_dept.iddepartment);
--   DBMS_OUTPUT.PUT_LINE(rec_dept.deptname);
--   DBMS_OUTPUT.PUT_LINE(rec_dept.deptdesc);
--   DBMS_OUTPUT.PUT_LINE(rec_dept.deptimage);
-- END;


--Collections (associative array) (many rows but one field)
--
-- DECLARE
--   TYPE type_roast is TABLE OF NUMBER
--   INDEX BY BINARY_INTEGER; --declare array (table is not a physical table)
--   --can also INDEX BY VARCHAR(2) for string values
--   tbl_roast type_roast;
--   lv_tot_num NUMBER := 0;
--   lv_cnt_num NUMBER := 0;
--   lv_avg_num NUMBER;
--   lv_samp1_num NUMBER(5,2) := 6.22;
--   lv_samp2_num NUMBER(5,2) := 6.13;
--   lv_samp3_num NUMBER(5,2) := 6.27;
--   lv_samp4_num NUMBER(5,2) := 6.16;
--   lv_samp5_num NUMBER(5,2);
-- BEGIN
--   tbl_roast(1) := lv_samp1_num;
--   tbl_roast(2) := lv_samp2_num;
--   tbl_roast(3) := lv_samp3_num;
--   tbl_roast(4) := lv_samp4_num;
--   tbl_roast(5) := lv_samp5_num;
--   FOR i IN 1..tbl_roast.COUNT LOOP
--     IF tbl_roast(i) IS NOT NULL THEN
--       lv_tot_num := lv_tot_num + tbl_roast(i);
--       lv_cnt_num := lv_cnt_num + 1;
--     END IF;
--   END LOOP;
--   lv_avg_num := lv_tot_num / lv_cnt_num;
--   DBMS_OUTPUT.PUT_LINE(lv_tot_num);
--   DBMS_OUTPUT.PUT_LINE(lv_cnt_num);
--   DBMS_OUTPUT.PUT_LINE(tbl_roast.COUNT);
--   DBMS_OUTPUT.PUT_LINE(lv_avg_num);
-- END;


--Collections (table of records) (many rows many fields)
--pg.112
-- DECLARE
--   TYPE type_basketitems is TABLE of bb_basketitem%ROWTYPE
--   INDEX BY BINARY_INTEGER;
--   tbl_items type_basketitems;
--   lv_ind_num NUMBER(3) := 1;
--   lv_id_num bb_basketitem.idproduct%TYPE := 7;
--   lv_price_num bb_basketitem.price%TYPE := 10.80;
--   lv_qty_num bb_basketitem.quantity%TYPE := 2;
--   lv_opt1_num bb_basketitem.option1%TYPE := 2;
--   lv_opt2_num bb_basketitem.option2%TYPE := 3;
-- BEGIN
--   tbl_items(lv_ind_num).idproduct := lv_id_num;
--   tbl_items(lv_ind_num).price := lv_price_num;
--   tbl_items(lv_ind_num).quantity := lv_qty_num;
--   tbl_items(lv_ind_num).option1 := lv_opt1_num;
--   tbl_items(lv_ind_num).option2 := lv_opt2_num;
--   DBMS_OUTPUT.PUT_LINE(lv_ind_num);
--   DBMS_OUTPUT.PUT_LINE(tbl_items(lv_ind_num).idproduct);
--   DBMS_OUTPUT.PUT_LINE(tbl_items(lv_ind_num).price);
-- END;


--BULK Collections reduce number of engine switches and can place
--a set of rows into a table of records variables
--
-- DECLARE
--   TYPE type_product IS TABLE OF bb_product%ROWTYPE
--     INDEX BY PLS_INTEGER;
--   tbl_prod type_product;
-- BEGIN
--   SELECT * BULK COLLECT INTO tbl_prod
--     FROM bb_product
--     WHERE type = 'E';
--   FOR i IN 1..tbl_prod.COUNT LOOP
--     DBMS_OUTPUT.PUT_LINE(tbl_prod(i).productname);
--   END LOOP;
-- END;


--GOTO statements skip executable code and go to a specified label
--labels <<example_1>>
--statement GOTO example_1
--
-- BEGIN
--   IF lv_rows_num = 0 THEN
--     GOTO insert_row;
--   END IF;
--   ...
--   ...
--   <<insert_row>>
--   INSERT INTO bb_basket(idBasket)
--     VALUES(bb_basket_seq.NEXTVAL);
--   ...
--   ...
-- END;
