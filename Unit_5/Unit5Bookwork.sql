--Aleksander brown
--chapter 5 book work

--Sample procedure syntax

CREATE [OR REPLACE] PROCEDURE
  PROCEDURE_NAME
    [(parameter1_name[mode] data type,
      parameter2_name[mode] data type,
    ...)]
    IS|AS
      declaration section
    BEGIN
      executable section
    EXCEPTION
      exception handlers
    END;


--Sample header

CREATE OR REPLACE PROCEDURE total_calc_sp
  (p_basket IN bb_basket.idbasket%TYPE,
  p_total OUT bb_basket.total%TYPE := 0)
  IS
    --PL/SQL block coded here


--procedure for calc ship cost

CREATE OR REPLACE
PROCEDURE SHIP_COST_SP
    (p_qty IN NUMBER,
    p_ship OUT NUMBER)
AS
BEGIN
    IF p_qty >  10 THEN
        p_ship := 11.00;
    ELSIF p_qty > 5 THEN
        p_ship := 8.00;
    ELSE
        p_ship := 5.00;
    END IF;
END SHIP_COST_SP;


--Call to procedure using positional method

DECLARE
  lv_ship_num NUMBER(6,2);
begin
    SHIP_COST_SP(7,lv_ship_num); --7 in & lv_ship_num holds out based on procedure declaration
    DBMS_OUTPUT.PUT_LINE('Ship Cost = ' || lv_ship_num);
end;


--Call to procedure using named association

DECLARE
  lv_ship_num NUMBER(6,2);
BEGIN
  SHIP_COST_SP(p_ship => lv_ship_num,
    p_qty => 7);
  DBMS_OUTPUT.PUT_LINE('Ship Cost = ' || lv_ship_num);
END;


--procedure using IN OUT

CREATE OR REPLACE PROCEDURE phone_fmt_sp
   (p_phone IN OUT VARCHAR2)
  IS
BEGIN
  p_phone := '(' || SUBSTR(p_phone,1,3) || ')' ||
                    SUBSTR(p_phone,4,3) || '-' ||
                    SUBSTR(p_phone,7,4);
END;


--Call to procedure using IN OUT params

DECLARE
  lv_phone_txt VARCHAR2(13) := '1112223333';
BEGIN
  phone_fmt_sp(lv_phone_txt);
  DBMS_OUTPUT.PUT_LINE(lv_phone_txt);
END;


--procedure calling a procedure

CREATE OR REPLACE PROCEDURE ORDER_TOTAL_SP
    (p_bsktid IN bb_basketitem.idbasket%TYPE,
    p_cnt OUT NUMBER,
    p_sub OUT NUMBER,
    p_ship OUT NUMBER,
    p_total OUT NUMBER)
  IS
begin
  DBMS_OUTPUT.PUT_LINE('order total proc called');
  SELECT SUM(quantity), SUM(quantity*price)
    into p_cnt, p_sub
    from bb_basketitem
    where idbasket = p_bsktid;
  SHIP_COST_SP(p_cnt,p_ship);
  p_total := NVL(p_sub,0) + NVL(p_ship,0);
  DBMS_OUTPUT.PUT_LINE('order total proc ended');
end ORDER_TOTAL_SP;


--Running multiple procedures with a single call

DECLARE
  lv_bask_num bb_basketitem.idbasket%TYPE := 12;
  lv_cnt_num NUMBER(3);
  lv_sub_num NUMBER(8,2);
  lv_ship_num NUMBER(8,2);
  lv_total_num NUMBER(8,2);
BEGIN
  DBMS_OUTPUT.PUT_LINE('Anonymous block started');
  ORDER_TOTAL_SP(lv_bask_num,lv_cnt_num,lv_sub_num,
      lv_ship_num,lv_total_num);
  DBMS_OUTPUT.PUT_LINE(lv_cnt_num);
  DBMS_OUTPUT.PUT_LINE(lv_sub_num);
  DBMS_OUTPUT.PUT_LINE(lv_ship_num);
  DBMS_OUTPUT.PUT_LINE(lv_total_num);
  DBMS_OUTPUT.PUT_LINE('Anonymous block ended');
END;


--can DESCRIBE procedures just like tables

DESCRIBE ORDER_TOTAL_SP;


--PROMO_TEST_SP code

CREATE OR REPLACE PROCEDURE promo_test_sp
  (p_mth IN CHAR,
   p_year IN CHAR)
 IS
 CURSOR cur_purch IS
   SELECT idshopper, SUM(Subtotal) sub
   FROM bb_basket
   WHERE TO_CHAR(dtCreated,'MON') = p_mth
       AND TO_CHAR(dtCreated,'YYYY') = p_year
       AND orderplaced = 1
   GROUP BY idshopper;
 promo_flag CHAR(1);
BEGIN
 FOR rec_purch IN cur_purch LOOP
 	If rec_purch.sub > 50 THEN
 		   promo_flag := 'A';
 	ELSIF rec_purch.sub > 25 THEN
 		   promo_flag := 'B';
 	END IF;
   DBMS_OUTPUT.PUT_LINE(rec_purch.idshopper || ' has sub ' ||
    rec_purch.sub || ' and flag = ' || promo_flag);
 	IF promo_flag IS NOT NULL THEN
    DBMS_OUTPUT.PUT_LINE('Insert processed for shopper ' ||
      rec_purch.idshopper);
 	  INSERT INTO bb_promolist
 	    VALUES (rec_purch.idshopper, p_mth, p_year, promo_flag, NULL);
 	END IF;
 	promo_flag := '';
 END LOOP;
 COMMIT;
END;


--call flagging procedure

BEGIN
  promo_test_sp('FEB','2012');
END;


--check if that set flags ^^

select * FROM bb_promolist;


--check totals to ensure flagging was correct

SELECT idshopper, SUM(Subtotal) Sub
  FROM bb_basket
  WHERE TO_CHAR(dtCreated,'MON') = 'FEB'
    AND TO_CHAR(dtCreated,'yyyy') = '2012'
    AND orderplaced = 1
  GROUP BY idshopper
  ORDER BY idshopper;


--subprograms are procedures declared in another procedure
--subprograms are scoped to their enclosing procedure
--other variables used in the procedure must be declared BEFORE the subprogram

create or replace PROCEDURE ORDER_TOTAL_SP2
    (p_bsktid IN bb_basketitem.idbasket%TYPE,
    p_cnt OUT NUMBER,
    p_sub OUT NUMBER,
    p_ship OUT NUMBER,
    p_total OUT NUMBER)
  IS
    PROCEDURE SHIP_COST_SP
      (p_qty IN NUMBER,
      p_ship OUT NUMBER)
    AS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('ship cost proc called');
        IF p_qty >  10 THEN
            p_ship := 11.00;
        ELSIF p_qty > 5 THEN
            p_ship := 8.00;
        ELSE

        END IF;
        DBMS_OUTPUT.PUT_LINE('ship cost proc ended');
    END SHIP_COST_SP;
begin
  DBMS_OUTPUT.PUT_LINE('order total proc called');
  SELECT SUM(quantity), SUM(quantity*price)
    into p_cnt, p_sub
    from bb_basketitem
    where idbasket = p_bsktid;
  SHIP_COST_SP(p_cnt,p_ship);
  p_total := NVL(p_sub,0) + NVL(p_ship,0);
  DBMS_OUTPUT.PUT_LINE('order total proc ended');
end ORDER_TOTAL_SP2;


--scope (inner blocks check themselves for vars before checking the outer block)
-- inner blocks can look to outer but outer cannot look to inner variables

DECLARE
  lv_one_num NUMBER(2) := 10;
  lv_two_num NUMBER(2) := 20;
BEGIN
  DECLARE
    lv_one_num NUMBER(2) := 30;
    lv_three_num NUMBER(2) := 40;
  BEGIN
    lv_one_num := lv_one_num + 10;
    lv_two_num := lv_two_num + 10;
    DBMS_OUTPUT.PUT_LINE('Nested one = ' || lv_one_num);
    DBMS_OUTPUT.PUT_LINE('Nested two = ' || lv_two_num);
    DBMS_OUTPUT.PUT_LINE('Nested three = ' || lv_three_num);
  END;
  lv_one_num := lv_one_num + 10;
  lv_two_num := lv_two_num + 10;
  -- lv_three_num := lv_three_num + 10;
  DBMS_OUTPUT.PUT_LINE('Enclosing one = ' || lv_one_num);
  DBMS_OUTPUT.PUT_LINE('Enclosing two = ' || lv_two_num);
  -- DBMS_OUTPUT.PUT_LINE('Enclosing three = ' || lv_three_num);
END;


--If you want an exception handled in a nested block to still propegate to the enclosing block

--(nested)
EXCEPTION
  DBMS_OUTPUT.PUT_LINE(error);
  RAISE;


--Pragma to designate what commit effects when blocks are nested
  -- AUTONOMOUS_TRANSACTION makes the nested transaction not apply its commit to enclosing transactions
CREATE OR REPLACE PROCEDURE tc_test_sp2 IS
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
	INSERT INTO bb_test1
	 VALUES (2);
  commit;
END;

/

CREATE OR REPLACE PROCEDURE tc_test_sp1 IS
BEGIN
	INSERT INTO bb_test1
	 VALUES (1);
	tc_test_sp2();
END;


--RAISE_APPLICATION_ERROR lets you create your own exception messages
--([error number between -20000 & -20999],[error message up to 512 char])

CREATE OR REPLACE PROCEDURE STOCK_CK_SP
    (p_qty IN NUMBER,
    p_prod IN NUMBER)
  IS
    lv_stock_num bb_product.idProduct%TYPE;
  BEGIN
    SELECT stock
      INTO lv_stock_num
      FROM bb_product
      WHERE idProduct = p_prod;
    IF p_qty > lv_stock_num THEN
      RAISE_APPLICATION_ERROR(-20000, 'Not enough in stock. ' ||
        'Request = ' || p_qty || ' / Stock level = ' || lv_stock_num);
    END IF;
  exception
    when no_data_found then
      DBMS_OUTPUT.PUT_LINE('No Stock found.');
  END;


  -- can remove any procedure with
  DROP PROCEDURE procedure_name;