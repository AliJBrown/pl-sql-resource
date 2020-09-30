-- Aleksander Brown
-- bookwork

-- CURSOR ATTRIBUTES
  -- SQL%ROWCOUNT -- number of rows affected
  -- SQL%FOUND -- if any rows are affected, true
  -- SQL%NOTFOUND -- if no rows are affected, true

--IMPLICIT CURSORS - created automatically when a SQL statement is executed

--Using cursor ATTRIBUTES
-- BEGIN
--   UPDATE bb_product
--     SET stock = stock + 25
--     WHERE idProduct = 15;
--     DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
--   IF SQL%NOTFOUND THEN
--     DBMS_OUTPUT.PUT_LINE('Not Found');
--   END IF;
-- END;


-- cursor attributes always reflect information from the most recent SQL statement
-- DECLARE
--   lv_tot_num bb_basket.total%TYPE;
-- BEGIN
--   SELECT total
--     INTO lv_tot_num
--     FROM bb_basket
--     WHERE idbasket = 12;
--   DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
--   UPDATE bb_product
--     SET stock = stock + 25
--     WHERE idProduct = 15;
--   DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
-- END;


--SQL%NOTFOUND does not work after a SELECT statement embedded in a PL/SQL block
-- It returns an error of "no data found" and jumps to exception
--
-- DECLARE
--   lv_tot_num bb_basket.total%TYPE;
-- BEGIN
--   SELECT total
--     INTO lv_tot_num
--     FROM bb_basket
--     WHERE idBasket = 99;
--   IF SQL%NOTFOUND THEN
--     DBMS_OUTPUT.PUT_LINE('Not Found');
--   END IF;
-- END;


--EXPLICIT CURSORS


--Scalar variables can't handle multiple rows
--below sets error for returns more than requested number of rows
-- DECLARE
--   lv_created_date DATE;
--   lv_basket_num NUMBER(3);
--   lv_qty_num NUMBER(3);
--   lv_sub_num NUMBER(5,2);
--   lv_days_num NUMBER(3);
--   lv_shopper_num NUMBER(3) := 26;
-- BEGIN
--   SELECT idBasket, dtcreated, quantity, subtotal
--     INTO lv_basket_num, lv_created_date, lv_qty_num, lv_sub_num
--     FROM bb_basket
--     WHERE idShopper = lv_shopper_num
--       AND orderplaced = 0;
--     lv_days_num := TO_DATE('02/28/12','mm/dd/yy') - lv_created_date;
--     DBMS_OUTPUT.PUT_LINE(lv_basket_num || '*' || lv_created_date ||
--       '*' || lv_qty_num || '*' || lv_sub_num || '*' || lv_days_num);
-- END;


-- STEPS in using an EXPLICIT CURSOR
  -- DECLARE - creates named cursor identified by SELECT statement without INTO Clause
  -- OPEN - Processes the query and creates the active set of rows in the CURSOR
  -- FETCH - retrieves a row from cursor into block variables. consecutive FETCH
            -- retrieves the next row until all have been retrieved
  -- CLOSE - Clears active set of rows and frees memory


-- using explicit cursor to process rows and calculate tax
--
-- DECLARE
--   CURSOR cur_basket IS
--     SELECT bi.idBasket, p.type, bi.price, bi.quantity
--       FROM bb_basketitem bi INNER JOIN bb_product p
--         USING (idProduct)
--         Where bi.idBasket = 6;
--   TYPE type_basket IS RECORD(
--     basket bb_basketitem.idBasket%TYPE,
--     type bb_product.type%TYPE,
--     price bb_basketitem.price%TYPE,
--     qty bb_basketitem.quantity%TYPE
--   );
--   rec_basket type_basket;
--   lv_rate_num NUMBER(2,2);
--   lv_tax_num NUMBER(4,2) := 0;
-- BEGIN
--   OPEN cur_basket;
--   LOOP
--     FETCH cur_basket INTO rec_basket;
--     EXIT WHEN cur_basket%NOTFOUND;
--     IF rec_basket.type = 'E' THEN lv_rate_num := .05;
--     ELSIF rec_basket.type = 'C' THEN lv_rate_num := .03;
--     END IF;
--     lv_tax_num := lv_tax_num + ((rec_basket.price * rec_basket.qty) * lv_rate_num);
--   END LOOP;
--   CLOSE cur_basket;
--   DBMS_OUTPUT.PUT_LINE(lv_tax_num);
-- END;


-- again using a second loop exit for max lv_tax_num
--
-- DECLARE
--    CURSOR cur_basket IS
--      SELECT bi.idBasket, p.type, bi.price, bi.quantity
--        FROM bb_basketitem bi INNER JOIN bb_product p
--          USING (idProduct)
--        WHERE bi.idBasket = 6;
--    TYPE type_basket IS RECORD (
--      basket bb_basketitem.idBasket%TYPE,
--      type bb_product.type%TYPE,
--      price bb_basketitem.price%TYPE,
--      qty bb_basketitem.quantity%TYPE);
--    rec_basket type_basket;
--    lv_rate_num NUMBER(2,2);
--    lv_tax_num NUMBER(4,2) := 0;
-- BEGIN
--    OPEN cur_basket;
--    LOOP
--      FETCH cur_basket INTO rec_basket;
--       EXIT WHEN cur_basket%NOTFOUND;
--       IF rec_basket.type = 'E' THEN lv_rate_num := .05;
--         ELSIF rec_basket.type = 'C' THEN lv_rate_num := .03;
--       END IF;
--       lv_tax_num := lv_tax_num + ((rec_basket.price*rec_basket.qty)*lv_rate_num);
--       IF lv_tax_num >=5 THEN
--        lv_tax_num := 5;
--        EXIT;
--       END IF;
--    END LOOP;
--    DBMS_OUTPUT.PUT_LINE(cur_basket%ROWCOUNT);
--    CLOSE cur_basket;
--    DBMS_OUTPUT.PUT_LINE(lv_tax_num);
-- END;


-- CURSOR FOR LOOP - automates creating record variable, open, loop, CLOSE
--
-- DECLARE
--   CURSOR cur_basket IS
--     SELECT bi.idBasket, p.type, bi.price, bi.quantity
--       FROM bb_basketitem bi INNER JOIN bb_product p
--         USING (idProduct)
--         Where bi.idBasket = 6;
--   --no record type needed
--   lv_rate_num NUMBER(2,2);
--   lv_tax_num NUMBER(4,2) := 0;
-- BEGIN
--   FOR rec_basket IN cur_basket LOOP
--     IF rec_basket.type = 'E' THEN lv_rate_num := .05;
--     ELSIF rec_basket.type = 'C' THEN lv_rate_num := .03;
--     END IF;
--     lv_tax_num := lv_tax_num + ((rec_basket.price * rec_basket.quantity) * lv_rate_num);
--   END LOOP;
--   DBMS_OUTPUT.PUT_LINE(lv_tax_num);
-- END;


--using cursor loop to update rows
--
-- DECLARE
--   CURSOR cur_prod IS
--     SELECT type, price
--     FROM bb_product
--     WHERE active = 1
--   FOR UPDATE NOWAIT; -- marks the cursor to lock current row for changes
--     lv_sale bb_product.saleprice%TYPE;
-- BEGIN
--   FOR rec_prod IN cur_prod LOOP
--     IF rec_prod.type = 'C' THEN lv_sale := rec_prod.price * .9;
--     ELSIF rec_prod.type = 'E' THEN lv_sale := rec_prod.price * .95;
--     END IF;
--     UPDATE bb_product
--       SET saleprice = lv_sale
--     WHERE CURRENT OF cur_prod;
--   END LOOP;
--   COMMIT;
-- END;

-- USING "FOR UPDATE OF <table.field> NOWAIT;" limits number of rows locked


-- Cursor parameters can make cursors dynamic
--
-- DECLARE
--   CURSOR cur_order (p_basket NUMBER) IS
--     SELECT idBasket, idProduct, price, quantity
--       FROM bb_basketitem
--       WHERE idBasket = p_basket;
--   lv_bask1_num bb_basket.idbasket%TYPE := 6;
--   lv_bask2_num bb_basket.idbasket%TYPE := 10;
-- BEGIN
--   FOR rec_order IN cur_order(lv_bask1_num) LOOP
--   DBMS_OUTPUT.PUT_LINE(rec_order.idBasket || ' - ' ||
--     rec_order.idProduct || ' - ' || rec_order.price);
--   END LOOP;
--   FOR rec_order IN cur_order(lv_bask2_num) LOOP
--   DBMS_OUTPUT.PUT_LINE(rec_order.idBasket || ' - ' ||
--     rec_order.idProduct || ' - ' || rec_order.price);
--   END LOOP;
-- END;


-- query with cursor based on input with cursor variables
--
-- DECLARE
--   cv_prod SYS_REFCURSOR;
--   rec_item bb_basketItem%ROWTYPE;
--   rec_status bb_basketstatus%ROWTYPE;
--   lv_input1_num NUMBER(2) := 2;
--   lv_input2_num NUMBER(2) := 2;
-- BEGIN
--   IF lv_input1_num = 1 THEN
--     OPEN cv_prod FOR SELECT * FROM bb_basketItem
--       WHERE idBasket = lv_input2_num;
--     LOOP
--       FETCH cv_prod INTO rec_item;
--       EXIT WHEN cv_prod%NOTFOUND;
--       DBMS_OUTPUT.PUT_LINE(rec_item.idProduct);
--     END LOOP;
--   ELSIF lv_input1_num = 2 THEN
--     OPEN cv_prod FOR SELECT * FROM bb_basketstatus
--       WHERE idBasket = lv_input2_num;
--     LOOP
--       FETCH cv_prod INTO rec_status;
--       EXIT WHEN cv_prod%NOTFOUND;
--       DBMS_OUTPUT.PUT_LINE(rec_status.idstage || ' - ' ||
--         rec_status.dtstage);
--     END LOOP;
--   END IF;
-- END;


-- using Bulk processing in an explicit cursor to better performance
--
-- DECLARE
--   CURSOR cur_item IS
--     SELECT *
--       FROM bb_basketItem;
--   TYPE type_item IS TABLE OF cur_item%ROWTYPE
--     INDEX BY PLS_INTEGER;
--   tbl_item type_item;
-- BEGIN
--   OPEN cur_item;
--   FETCH cur_item
--     BULK COLLECT INTO tbl_item;
--   FOR i IN 1..tbl_item.COUNT LOOP
--     DBMS_OUTPUT.PUT_LINE(tbl_item(i).idbasketitem || ' - '
--       || tbl_item(1).idProduct);
--   END LOOP;
--   CLOSE cur_item;
-- END;


-- limit number of items to improve performance in FETCH
--
-- DECLARE
--   CURSOR cur_item IS
--     SELECT *
--       FROM bb_basketItem;
--   TYPE type_item IS TABLE OF cur_item%ROWTYPE
--     INDEX BY PLS_INTEGER;
--   tbl_item type_item;
-- BEGIN
--   OPEN cur_item;
--   LOOP
--     FETCH cur_item
--       BULK COLLECT INTO tbl_item LIMIT 1000;
--     FOR i IN 1..tbl_item.COUNT LOOP
--       DBMS_OUTPUT.PUT_LINE(tbl_item(i).idbasketitem || ' - '
--         || tbl_item(1).idProduct);
--     END LOOP;
--     EXIT WHEN cur_item%NOTFOUND; -- must be at bottom or last 1000 may not process
--   END LOOP;
--   CLOSE cur_item;
-- END;


-- FORALL bulk processing for DML (ex. update)
--
-- DECLARE
--   TYPE emp_type IS TABLE OF NUMBER
--     INDEX BY BINARY_INTEGER;
--   emp_tbl emp_type;
-- BEGIN
--   SELECT empID
--     BULK COLLECT INTO emp_tbl
--     FROM employees
--     WHERE classtype = '100';
--   FORALL i IN d_emp_tbl.FIRST..emp_tbl.LAST
--     UPDATE employees
--       SET raise = salary * .06
--         WHERE empID = emp_tbl(i);
--   COMMIT;
-- END;


-- EXCEPTION HANDLING


-- predefined exceptions
--
-- DECLARE
--  TYPE type_basket IS RECORD (
--    basket bb_basket.idBasket%TYPE,
--    created bb_basket.dtcreated%TYPE,
--    qty bb_basket.quantity%TYPE,
--    sub bb_basket.subtotal%TYPE);
--  rec_basket type_basket;
--  lv_days_num NUMBER(3);
--  lv_shopper_num NUMBER(3) := 26;
-- BEGIN
--  SELECT idBasket, dtcreated, quantity, subtotal
--   INTO rec_basket
--   FROM bb_basket
--   WHERE idShopper = lv_shopper_num
--     AND orderplaced = 0;
--  lv_days_num := TO_DATE('02/28/12','mm/dd/yy') - rec_basket.created;
--  DBMS_OUTPUT.PUT_LINE(rec_basket.basket);
--  DBMS_OUTPUT.PUT_LINE(rec_basket.created);
--  DBMS_OUTPUT.PUT_LINE(rec_basket.qty);
--  DBMS_OUTPUT.PUT_LINE(rec_basket.sub);
--  DBMS_OUTPUT.PUT_LINE(lv_days_num);
-- EXCEPTION
--  WHEN NO_DATA_FOUND THEN
--    DBMS_OUTPUT.PUT_LINE('You have no saved baskets!');
--   WHEN TOO_MANY_ROWS THEN
--    DBMS_OUTPUT.PUT_LINE('A problem has ocurred in retrieving your saved basket.');
--    DBMS_OUTPUT.PUT_LINE('Tech Support will be notified and contact you via email.');
-- END;


--Undefined Exceptions but be declared
--
-- DECLARE
--   ex_basket_fk EXCEPTION;
--   PRAGMA EXCEPTION_INIT(ex_basket_fk, -2292); --associate an Oracle error number
-- BEGIN
--   DELETE FROM bb_basket
--     WHERE idBasket = 4;
-- EXCEPTION
--   WHEN ex_basket_fk THEN
--     DBMS_OUTPUT.PUT_LINE('Items still in the basket!');
-- END;

-- Testing a statement standalone is a good way to find what errors might need
--associated to an exception handler for a code block


--User defined exception for business rules
--
-- DECLARE
--   ex_prod_update EXCEPTION;
-- BEGIN
--   UPDATE bb_product
--     SET description = 'Mill grinder with 5 grind settings!'
--     Where idProduct = 30;
--   IF SQL%NOTFOUND THEN
--     RAISE ex_prod_update;
--   END IF;
-- EXCEPTION
--   WHEN ex_prod_update THEN
--     DBMS_OUTPUT.PUT_LINE('Invalid product ID entered');
-- END;


--Exception to handle checking qty on hand prior to ordering
--
-- DECLARE
--   lv_ordqty_num NUMBER(2) := 20;
--   lv_stock_num bb_product.stock%TYPE;
--   ex_prod_stk EXCEPTION;
-- BEGIN
--   SELECT stock
--     INTO lv_stock_num
--     FROM bb_product
--     WHERE idProduct = 2;
--   IF lv_ordqty_num > lv_stock_num THEN
--     RAISE ex_prod_stk;
--   END IF;
-- EXCEPTION
--   WHEN ex_prod_stk THEN
--     DBMS_OUTPUT.PUT_LINE('Requested quantity beyond stock level');
--     DBMS_OUTPUT.PUT_LINE('Req qty = ' || lv_ordqty_num || ' Stock qty = '
--         || lv_stock_num);
-- END;


--UNANTICIPATED EXCEPTIONS

--WHEN OTHERS to catch unplanned exceptions
--
-- DECLARE
--  TYPE type_basket IS RECORD (
--    basket bb_basket.idBasket%TYPE,
--    created bb_basket.dtcreated%TYPE,
--    qty bb_basket.quantity%TYPE,
--    sub bb_basket.subtotal%TYPE);
--  rec_basket type_basket;
--  lv_days_num NUMBER(3);
--  lv_shopper_num NUMBER(3) := 26;
-- BEGIN
--  SELECT idBasket, dtcreated, quantity, subtotal
--   INTO rec_basket
--   FROM bb_basket
--   WHERE idShopper = lv_shopper_num
--     AND orderplaced = 0;
--  lv_days_num := TO_DATE('02/28/12','mm/dd/yy') - rec_basket.created;
--  DBMS_OUTPUT.PUT_LINE(rec_basket.basket);
--  DBMS_OUTPUT.PUT_LINE(rec_basket.created);
--  DBMS_OUTPUT.PUT_LINE(rec_basket.qty);
--  DBMS_OUTPUT.PUT_LINE(rec_basket.sub);
--  DBMS_OUTPUT.PUT_LINE(lv_days_num);
-- EXCEPTION
--  WHEN NO_DATA_FOUND THEN
--    DBMS_OUTPUT.PUT_LINE('You have no saved baskets!');
--   WHEN OTHERS THEN
--    DBMS_OUTPUT.PUT_LINE('A problem has ocurred in retrieving your saved basket.');
--    DBMS_OUTPUT.PUT_LINE('Tech Support will be notified and contact you via email.');
-- END;


--Saving error code to transaction log for later review
--
-- DECLARE
--  TYPE type_basket IS RECORD (
--    basket bb_basket.idBasket%TYPE,
--    created bb_basket.dtcreated%TYPE,
--    qty bb_basket.quantity%TYPE,
--    sub bb_basket.subtotal%TYPE);
--  rec_basket type_basket;
--  lv_days_num NUMBER(3);
--  lv_shopper_num NUMBER(3) := 26;
--  lv_errmsg_txt VARCHAR2(80);
--  lv_errnum_txt VARCHAR2(10);
-- BEGIN
--  SELECT idBasket, dtcreated, quantity, subtotal
--   INTO rec_basket
--   FROM bb_basket
--   WHERE idShopper = lv_shopper_num
--     AND orderplaced = 0;
--  lv_days_num := TO_DATE('02/28/12','mm/dd/yy') - rec_basket.created;
--  DBMS_OUTPUT.PUT_LINE(rec_basket.basket);
--  DBMS_OUTPUT.PUT_LINE(rec_basket.created);
--  DBMS_OUTPUT.PUT_LINE(rec_basket.qty);
--  DBMS_OUTPUT.PUT_LINE(rec_basket.sub);
--  DBMS_OUTPUT.PUT_LINE(lv_days_num);
-- EXCEPTION
--  WHEN NO_DATA_FOUND THEN
--    DBMS_OUTPUT.PUT_LINE('You have no saved baskets!');
--   WHEN OTHERS THEN
--   lv_errmsg_txt := SUBSTR(SQLERRM,1,80);
--   lv_errnum_txt := SQLCODE;
--   INSERT INTO bb_trans_log (shopper, appaction, errcode, errmsg)
--     VALUES(lv_shopper_num, 'Get saved basket', lv_errnum_txt,lv_errmsg_txt);
--     --COMMIT; --usually included when not testing to save error log
--    DBMS_OUTPUT.PUT_LINE('A problem has ocurred in retrieving your saved basket.');
--    DBMS_OUTPUT.PUT_LINE('Tech Support will be notified and contact you via email.');
-- END;


-- Nested blocks propegate errors to outer blocks if inner block doesn't handle it
-- If error is in inner block DECLARE section it automatically goes to outer handlers
--
-- DECLARE
--   lv_junk1_num NUMBER(3) := 200;
-- BEGIN
--   DECLARE
--     lv_junk2_num NUMBER(3) := 'cat';
--   BEGIN
--     lv_junk2_num := 300;
--   EXCEPTION
--     WHEN OTHERS THEN
--       DBMS_OUTPUT.PUT_LINE('Handler in nested block');
--   END;
--   lv_junk1_num := 300;
-- EXCEPTION
--   WHEN OTHERS THEN
--     DBMS_OUTPUT.PUT_LINE('Handler in outer block');
-- END;


--If error occurs in nested EXCEPTION block it also goes to outer
--statements before the error occurs in inner handler will still execute

DECLARE
  lv_junk1_num NUMBER(3) := 200;
BEGIN
  DECLARE
    lv_junk2_num NUMBER(3);
  BEGIN
    lv_junk2_num := 'cat';
  EXCEPTION
    WHEN OTHERS THEN
      lv_junk2_num := 'hat';
      DBMS_OUTPUT.PUT_LINE('Handler in nested block');
  END;
  lv_junk1_num := 300;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Handler in outer block');
END;
