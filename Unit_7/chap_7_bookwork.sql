-- Aleksander Brown
-- chapter 7 bookwork

-- create package syntax
CREATE OR REPLACE PACKAGE ordering_pkg
IS
    pv_total_num NUMBER(3,2);
    PROCEDURE order_total_pp
        (p_bsktid IN BB_BASKETITEM.IDBASKET%TYPE,
        p_cnt OUT NUMBER,
        p_sub OUT NUMBER,
        p_ship OUT NUMBER,
        p_total OUT NUMBER);
    FUNCTION ship_calc_pf
    (p_qty IN NUMBER)
    RETURN NUMBER;
END;

/

CREATE OR REPLACE PACKAGE BODY ordering_pkg IS
 FUNCTION ship_calc_pf
    (p_qty IN NUMBER)
    RETURN NUMBER
   IS
    lv_ship_num NUMBER(5,2);
  BEGIN
   IF p_qty > 10 THEN
     lv_ship_num := 11.00;
    ELSIF p_qty > 5 THEN
     lv_ship_num := 8.00;
    ELSE
     lv_ship_num := 5.00;
   END IF;
   RETURN lv_ship_num;
  END ship_calc_pf;
 PROCEDURE ORDER_TOTAL_PP
    (p_bsktid IN bb_basketitem.idbasket%TYPE,
     p_cnt OUT NUMBER,
     p_sub OUT NUMBER,
     p_ship OUT NUMBER,
     p_total OUT NUMBER)
    IS
   BEGIN
    SELECT SUM(quantity),SUM(quantity*price)
	    INTO p_cnt, p_sub
	    FROM bb_basketitem
	    WHERE idbasket = p_bsktid;
    p_ship := ship_calc_pf(p_cnt);
    p_total := NVL(p_sub,0) + NVL(p_ship,0);
   END ORDER_TOTAL_PP;
END;


--call procedure within package
DECLARE
    lv_bask_num BB_BASKETITEM.IDBASKET%TYPE := 12;
    lv_cnt_num NUMBER(3);
    lv_sub_num NUMBER(8,2);
    lv_ship_num NUMBER(8,2);
    lv_total_num NUMBER(8,2);
BEGIN
    ordering_pkg.order_total_pp(lv_bask_num,lv_cnt_num,lv_sub_num,lv_ship_num,lv_total_num);
    DBMS_OUTPUT.PUT_LINE("A"  => 'count ' || TO_CHAR(lv_cnt_num,'$999.99') /*IN VARCHAR2*/);
    DBMS_OUTPUT.PUT_LINE("A"  => lv_sub_num /*IN VARCHAR2*/);
    DBMS_OUTPUT.PUT_LINE("A"  => lv_ship_num /*IN VARCHAR2*/);
    DBMS_OUTPUT.PUT_LINE("A"  => lv_total_num /*IN VARCHAR2*/);
END;


--Call packaged function from outside package
DECLARE
    lv_ship_num NUMBER(8,2);
BEGIN
    lv_ship_num := ordering_pkg.ship_calc_pf(7);
    DBMS_OUTPUT.PUT_LINE("A"  => lv_ship_num /*IN VARCHAR2*/);
END;


--Private scope if a package element is not declared in the spec
--but is created in the body
--following shows privatizing the ship_calc_pf function which can
--no longer be called from outside of the package
CREATE OR REPLACE PACKAGE ordering_pkg
IS
    pv_total_num NUMBER(3,2);
    PROCEDURE order_total_pp
        (p_bsktid IN BB_BASKETITEM.IDBASKET%TYPE,
        p_cnt OUT NUMBER,
        p_sub OUT NUMBER,
        p_ship OUT NUMBER,
        p_total OUT NUMBER);
END;

/

CREATE OR REPLACE PACKAGE BODY ordering_pkg IS
 FUNCTION ship_calc_pf
    (p_qty IN NUMBER)
    RETURN NUMBER
   IS
    lv_ship_num NUMBER(5,2);
  BEGIN
   IF p_qty > 10 THEN
     lv_ship_num := 11.00;
    ELSIF p_qty > 5 THEN
     lv_ship_num := 8.00;
    ELSE
     lv_ship_num := 5.00;
   END IF;
   RETURN lv_ship_num;
  END ship_calc_pf;
 PROCEDURE ORDER_TOTAL_PP
    (p_bsktid IN bb_basketitem.idbasket%TYPE,
     p_cnt OUT NUMBER,
     p_sub OUT NUMBER,
     p_ship OUT NUMBER,
     p_total OUT NUMBER)
    IS
   BEGIN
    SELECT SUM(quantity),SUM(quantity*price)
	    INTO p_cnt, p_sub
	    FROM bb_basketitem
	    WHERE idbasket = p_bsktid;
    p_ship := ship_calc_pf(p_cnt);
    p_total := NVL(p_sub,0) + NVL(p_ship,0);
   END ORDER_TOTAL_PP;
END;


--global variable persistence
CREATE OR REPLACE PACKAGE ordering_pkg
IS
    pv_total_num NUMBER(3,2) := 0;
    PROCEDURE order_total_pp
        (p_bsktid IN BB_BASKETITEM.IDBASKET%TYPE,
        p_cnt OUT NUMBER,
        p_sub OUT NUMBER,
        p_ship OUT NUMBER,
        p_total OUT NUMBER);
END;

/

CREATE OR REPLACE PACKAGE BODY ordering_pkg IS
 FUNCTION ship_calc_pf
    (p_qty IN NUMBER)
    RETURN NUMBER
   IS
    lv_ship_num NUMBER(5,2);
  BEGIN
   IF p_qty > 10 THEN
     lv_ship_num := 11.00;
    ELSIF p_qty > 5 THEN
     lv_ship_num := 8.00;
    ELSE
     lv_ship_num := 5.00;
   END IF;
   RETURN lv_ship_num;
  END ship_calc_pf;
 PROCEDURE ORDER_TOTAL_PP
    (p_bsktid IN bb_basketitem.idbasket%TYPE,
     p_cnt OUT NUMBER,
     p_sub OUT NUMBER,
     p_ship OUT NUMBER,
     p_total OUT NUMBER)
    IS
   BEGIN
    SELECT SUM(quantity),SUM(quantity*price)
	    INTO p_cnt, p_sub
	    FROM bb_basketitem
	    WHERE idbasket = p_bsktid;
    p_ship := ship_calc_pf(p_cnt);
    p_total := NVL(p_sub,0) + NVL(p_ship,0);
   END ORDER_TOTAL_PP;
END;

-- following 3 calls to above package show the value persisted in the var
DECLARE
    lv_pkg_num NUMBER(3);
BEGIN
    lv_pkg_num := ordering_pkg.pv_total_num;
    DBMS_OUTPUT.PUT_LINE("A"  => lv_pkg_num /*IN VARCHAR2*/);
END;

/

DECLARE
    lv_pkg_num NUMBER(3) := 5;
BEGIN
    ordering_pkg.pv_total_num := lv_pkg_num;
    DBMS_OUTPUT.PUT_LINE("A"  => ordering_pkg.pv_total_num /*IN VARCHAR2*/);
END;

/

DECLARE
    lv_pkg_num NUMBER(3);
BEGIN
    lv_pkg_num := ordering_pkg.pv_total_num;
    DBMS_OUTPUT.PUT_LINE("A"  => lv_pkg_num /*IN VARCHAR2*/);
END;


--a package spec can be used to hold often used variables and no body is needed
CREATE OR REPLACE PACKAGE metric_pkg
IS
    cup_to_liter CONSTANT NUMBER := .24;
    pint_to_liter CONSTANT NUMBER := .47;
    qrt_to_liter CONSTANT NUMBER := .95;
END;


--packages can use cursors to increase efficiency by persisting throughout user session
CREATE OR REPLACE PACKAGE budget_pkg
IS
    CURSOR pcur_sales IS
        SELECT p.idproduct, p.price, p.type, SUM(bi.quantity) qty
            FROM bb_product p, bb_basketitem bi, bb_basket b
            WHERE p.idproduct = bi.idproduct
            AND b.idbasket = bi.idbasket
            AND b.orderplaced = 1
            GROUP BY p.idproduct, p.price, p.type;
    PROCEDURE project_sales_pp
        (p_pcte IN OUT NUMBER,
        p_pctc IN OUT NUMBER,
        p_incr OUT NUMBER);
end;

/

CREATE OR REPLACE PACKAGE BODY budget_pkg
IS
    PROCEDURE project_sales_pp
        (p_pcte IN OUT NUMBER,
        p_pctc IN OUT NUMBER,
        p_incr OUT NUMBER)
    IS
        equip NUMBER := 0;
        coff NUMBER := 0;
    begin
      FOR rec_sales IN pcur_sales loop
        IF rec_sales.type = 'E' THEN
            equip := equip + ((rec_sales.price*p_pcte)*rec_sales.qty);
        ELSIF rec_sales.type = 'C' THEN
            coff := coff + ((rec_sales.price*p_pctc)*rec_sales.qty);
        END IF;
      end loop;
        p_incr := equip + coff;
    end;
END;

--set timing for display
SET TIMING ON

--call packaged procedure
DECLARE
    lv_pcte_num NUMBER(3,2) := .03;
    lv_pctc_num NUMBER(3,2) := .07;
    lv_incr_num NUMBER(6,2);
BEGIN
    budget_pkg.project_sales_pp(lv_pcte_num,lv_pctc_num,lv_incr_num);
    DBMS_OUTPUT.PUT_LINE("A"  => lv_incr_num /*IN VARCHAR2*/);
END;


--order matters. a procedure can't call a function not declared that is defined after it

--unless using a Forward Declaration
CREATE OR REPLACE PACKAGE ordering_pkg
IS
    pv_total_num NUMBER(3,2);
    PROCEDURE order_total_pp
        (p_bsktid IN BB_BASKETITEM.IDBASKET%TYPE,
        p_cnt OUT NUMBER,
        p_sub OUT NUMBER,
        p_ship OUT NUMBER,
        p_total OUT NUMBER);
END;

/

CREATE OR REPLACE PACKAGE BODY ordering_pkg IS
    --forward header for function
    FUNCTION ship_calc_pf
        (p_qty IN NUMBER)
        RETURN NUMBER;
    PROCEDURE ORDER_TOTAL_PP
        (p_bsktid IN bb_basketitem.idbasket%TYPE,
        p_cnt OUT NUMBER,
        p_sub OUT NUMBER,
        p_ship OUT NUMBER,
        p_total OUT NUMBER)
        IS
    BEGIN
        SELECT SUM(quantity),SUM(quantity*price)
            INTO p_cnt, p_sub
            FROM bb_basketitem
            WHERE idbasket = p_bsktid;
        p_ship := ship_calc_pf(p_cnt);
        p_total := NVL(p_sub,0) + NVL(p_ship,0);
    END ORDER_TOTAL_PP;
    FUNCTION ship_calc_pf
        (p_qty IN NUMBER)
        RETURN NUMBER
    IS
        lv_ship_num NUMBER(5,2);
    BEGIN
        IF p_qty > 10 THEN
            lv_ship_num := 11.00;
            ELSIF p_qty > 5 THEN
            lv_ship_num := 8.00;
            ELSE
            lv_ship_num := 5.00;
        END IF;
        RETURN lv_ship_num;
    END ship_calc_pf;
END;


--one time procedure runs at first package call for entire session
-- also known as an initialization block
CREATE OR REPLACE PACKAGE ordering_pkg
IS
    pv_bonus_num NUMBER(3,2);
    pv_total_num NUMBER(3,2);
    PROCEDURE order_total_pp
        (p_bsktid IN BB_BASKETITEM.IDBASKET%TYPE,
        p_cnt OUT NUMBER,
        p_sub OUT NUMBER,
        p_ship OUT NUMBER,
        p_total OUT NUMBER);
END;

/

CREATE OR REPLACE PACKAGE BODY ordering_pkg IS
    --forward header for function
    FUNCTION ship_calc_pf
        (p_qty IN NUMBER)
        RETURN NUMBER;
    PROCEDURE ORDER_TOTAL_PP
        (p_bsktid IN bb_basketitem.idbasket%TYPE,
        p_cnt OUT NUMBER,
        p_sub OUT NUMBER,
        p_ship OUT NUMBER,
        p_total OUT NUMBER)
        IS
    BEGIN
        SELECT SUM(quantity),SUM(quantity*price)
            INTO p_cnt, p_sub
            FROM bb_basketitem
            WHERE idbasket = p_bsktid;
        p_sub := p_sub - (p_sub*pv_bonus_num);
        p_ship := ship_calc_pf(p_cnt);
        p_total := NVL(p_sub,0) + NVL(p_ship,0);
    END ORDER_TOTAL_PP;
    FUNCTION ship_calc_pf
        (p_qty IN NUMBER)
        RETURN NUMBER
    IS
        lv_ship_num NUMBER(5,2);
    BEGIN
        IF p_qty > 10 THEN
            lv_ship_num := 11.00;
            ELSIF p_qty > 5 THEN
            lv_ship_num := 8.00;
            ELSE
            lv_ship_num := 5.00;
        END IF;
        RETURN lv_ship_num;
    END ship_calc_pf;
    BEGIN
        SELECT AMOUNT
            INTO pv_bonus_num
            FROM BB_PROMO
            WHERE IDPROMO = 'B';
END;
/
--call above package
DECLARE
    lv_bask_num BB_BASKETITEM.IDBASKET%TYPE := 12;
    lv_cnt_num NUMBER(3);
    lv_sub_num NUMBER(8,2);
    lv_ship_num NUMBER(8,2);
    lv_total_num NUMBER(8,2);
BEGIN
    ordering_pkg.ORDER_TOTAL_PP(lv_bask_num,lv_cnt_num,lv_sub_num,lv_ship_num ,lv_total_num);
    DBMS_OUTPUT.PUT_LINE(lv_cnt_num);
    DBMS_OUTPUT.PUT_LINE(lv_sub_num);
    DBMS_OUTPUT.PUT_LINE(lv_ship_num);
    DBMS_OUTPUT.PUT_LINE(lv_total_num);
END;
/
--verify results
SELECT SUM(QUANTITY) qty, SUM(QUANTITY*PRICE) subtotal,
    SUM(QUANTITY*PRICE)-(SUM(QUANTITY*PRICE)*.05) "new subtotal"
    FROM BB_BASKETITEM
    WHERE IDBASKET = 12;


--Overloading functions or procedures
    --share a name but take different variables
CREATE OR REPLACE PACKAGE product_info_pkg IS
  PROCEDURE prod_search_pp
    (p_id IN bb_product.idproduct%TYPE,
     p_sale OUT bb_product.saleprice%TYPE,
     p_price OUT bb_product.price%TYPE);
  PROCEDURE prod_search_pp
    (p_id IN bb_product.productname%TYPE,
     p_sale OUT bb_product.saleprice%TYPE,
     p_price OUT bb_product.price%TYPE);
END;
/
CREATE OR REPLACE PACKAGE BODY product_info_pkg IS
  PROCEDURE prod_search_pp
    (p_id IN bb_product.idproduct%TYPE,
     p_sale OUT bb_product.saleprice%TYPE,
     p_price OUT bb_product.price%TYPE)
    IS
   BEGIN
   	SELECT saleprice, price
   	 INTO p_sale, p_price
   	 FROM bb_product
   	 WHERE idProduct = p_id;
  END;
  PROCEDURE prod_search_pp
    (p_id IN bb_product.productname%TYPE,
     p_sale OUT bb_product.saleprice%TYPE,
     p_price OUT bb_product.price%TYPE)
     IS
   BEGIN
   	SELECT saleprice, price
   	 INTO p_sale, p_price
   	 FROM bb_product
   	 WHERE productname = p_id;
  END;
END;
/
--call overloaded with a product id
DECLARE
    lv_id_num BB_PRODUCT.IDPRODUCT%TYPE := 6;
    lv_sale_num BB_PRODUCT.SALEPRICE%TYPE;
    lv_pric_num BB_PRODUCT.PRICE%TYPE;
BEGIN
    product_info_pkg.prod_search_pp(lv_id_num,lv_sale_num,lv_pric_num);
    DBMS_OUTPUT.PUT_LINE(lv_sale_num);
    DBMS_OUTPUT.PUT_LINE(lv_pric_num);
END;
/
--call overloaded with product name
DECLARE
    lv_id_num BB_PRODUCT.PRODUCTNAME%TYPE := 'Guatamala';
    lv_sale_num BB_PRODUCT.SALEPRICE%TYPE;
    lv_pric_num BB_PRODUCT.PRICE%TYPE;
BEGIN
    product_info_pkg.prod_search_pp(lv_id_num,lv_sale_num,lv_pric_num);
    DBMS_OUTPUT.PUT_LINE(lv_sale_num);
    DBMS_OUTPUT.PUT_LINE(lv_pric_num);
END;


--purity levels
CREATE OR REPLACE PACKAGE PACK_PURITY_PKG
IS
    FUNCTION tax_calc_pf
        (p_amt IN NUMBER)
        RETURN NUMBER;
    PRAGMA RESTRICT_REFERENCES(tax_calc_pf,WNDS,WNPS);
    END;

--Can also declare a default to include all that don't have their own pragma
--PRAGMA RESTRICT_REFERENCES(DEFAULT,WNDS,WNPS;)

/

--can use trust option for external languages like JAVA
CREATE OR REPLACE PACKAGE java_pkg
AS
FUNCTION phone_fmt_pf
    (p_phone IN VARCHAR2)
    RETURN VARCHAR2
    IS
    LANGUAGE JAVA
    NAME 'EXTERNAL.phone(char[]) return char[]';
    PRAGMA RESTRICT_REFERENCES(phone_fmt_pf,WNDS,TRUST);
END;

/

--Ref cursor parameter in packages
CREATE OR REPLACE PACKAGE demo_pkg
AS
    TYPE genCur IS ref CURSOR;
    PROCEDURE return_set
        (p_id IN NUMBER,
        p_theCursor IN OUT genCur);
END;
/
CREATE OR REPLACE PACKAGE BODY demo_pkg
AS
    PROCEDURE return_set
        (p_id IN NUMBER,
        p_theCursor IN OUT genCur)
    IS
    BEGIN
        OPEN p_theCursor FOR SELECT * FROM bb_basketitem
            WHERE idbasket = p_id;
    END;
END;
/
DECLARE
    bask_cur demo_pkg.genCur;
    rec_bask bb_basketitem%ROWTYPE;
BEGIN
    demo_pkg.return_set(3,bask_cur);
    LOOP
        FETCH bask_cur INTO rec_bask;
        EXIT WHEN bask_cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(rec_bask.idproduct);
    END LOOP;
END;

/
-- Invoker rights are less than Definer rights
--can be forces with AUTHID
--can be used on separate program units by includign it as the last item
    -- in the unit's header
CREATE OR REPLACE PACKAGE pack_purity_pkg
AUTHID CURRENT_USER IS
    FUNCTION tax_calc_pf
        (p_amt IN NUMBER)
        RETURN NUMBER;
END;

/
--view source code
SELECT text
    FROM user_source
    WHERE name = 'PRODUCT_INFO_PKG';

/
--view user objects for validity
SELECT object_name, object_type, status
    FROM user_objects
    WHERE object_type LIKE '%PACKAGE';