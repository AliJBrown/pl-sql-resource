--aleksander brown
--chapter 6 bookwork

--Function

--returns a single value and must deal with the retun statement in the header and the body

-- CREATE OR REPLACE FUNCTION function_name
-- [(parameter1_name [mode] datatype,
-- parameter2_name [mode] datatype,
-- ...)]
-- RETURN return_value datatype
-- IS
--     declaration section
-- BEGIN
--     executable section
--     RETURN variable_name;
-- EXCEPTION
--     exception handlers
-- END;

--function to calculate shipping

-- CREATE OR REPLACE FUNCTION ship_calc_sf
--     (p_qty IN NUMBER)
--     RETURN NUMBER
-- IS
--     lv_ship_num NUMBER(5,2);
-- BEGIN
--     IF p_qty > 10 THEN
--         lv_ship_num := 11.00;
--     ELSIF p_qty >5 THEN
--         lv_ship_num := 8.00;
--     ELSE
--         lv_ship_num := 5.00;
--     END IF;
--     RETURN lv_ship_num;
-- END;

-- /
-- --Calling function in block
-- --called as a part of a statement instead of standalone like a procedure
-- DECLARE
--     lv_cost_num NUMBER(5,2);
-- BEGIN
--     lv_cost_num := ship_calc_sf(12);
--     DBMS_OUTPUT.PUT_LINE(lv_cost_num);
-- END;


--Using function in select

-- SELECT idBasket, shipping actual, ship_calc_sf(quantity) calc,ship_calc_sf(quantity) - shipping diff
--     FROM bb_basket
--     WHERE orderplaced = 1;


--using a function in an aggregate query

-- SELECT SUM(shipping) actual,
--     SUM(ship_calc_sf(quantity)) calc,
--     SUM(ship_calc_sf(quantity)-shipping) diff
-- FROM bb_basket
-- WHERE orderplaced = 1;


--function accepting 3 inputs and returns a formatted string with member id and name

-- CREATE OR REPLACE FUNCTION memfmt1_sf
--     (p_id IN NUMBER,
--     p_first IN VARCHAR2,
--     p_last IN VARCHAR2)
--     RETURN VARCHAR2
-- IS
--     lv_mem_txt VARCHAR2(35);
-- BEGIN
--     lv_mem_txt := 'Member '||p_id||'-'||p_first||' '||p_last;
--     RETURN lv_mem_txt;
-- END;

--Test memfmt1_sf

-- DECLARE
--     lv_name_txt VARCHAR2(50);
--     lv_id_num bb_shopper.idshopper%TYPE := 25;
--     lv_first_txt bb_shopper.firstname%TYPE := 'Scott';
--     lv_last_txt bb_shopper.lastname%TYPE := 'Savid';
-- BEGIN
--     lv_name_txt := memfmt1_sf(lv_id_num,lv_first_txt,lv_last_txt);
--     DBMS_OUTPUT.PUT_LINE(lv_name_txt);
-- END;


--Procedure that uses a function

-- CREATE OR REPLACE PROCEDURE login_sp
--  (p_user IN VARCHAR2,
--   p_pass IN VARCHAR2,
--   p_id OUT NUMBER,
--   p_flag OUT CHAR,
--   p_mem OUT VARCHAR2 )
--  IS
--   lv_first_txt bb_shopper.firstname%TYPE;
--   lv_last_txt bb_shopper.lastname%TYPE;
-- BEGIN
--  SELECT idShopper, firstname, lastname
--   INTO p_id, lv_first_txt, lv_last_txt
--   FROM bb_shopper
--   WHERE username = p_user
--    AND password = p_pass;
--   p_flag := 'Y';
--   p_mem := memfmt1_sf(p_id, lv_first_txt, lv_last_txt);
-- EXCEPTION
--   WHEN NO_DATA_FOUND THEN
--     p_flag := 'N';
-- END;

--Call procedure using function

-- DECLARE
--     lv_user_txt bb_shopper.username%TYPE := 'fdwell';
--     lv_pass_txt bb_shopper.password%TYPE := 'tweak';
--     lv_id_num bb_shopper.idshopper%TYPE;
--     lv_flag_txt CHAR(1);
--     lv_name_txt VARCHAR2(50);
-- BEGIN
--     login_sp(lv_user_txt,lv_pass_txt,lv_id_num,lv_flag_txt,lv_name_txt);
--     DBMS_OUTPUT.PUT_LINE(lv_id_num);
--     DBMS_OUTPUT.PUT_LINE(lv_flag_txt);
--     DBMS_OUTPUT.PUT_LINE(lv_name_txt);
-- END;


-- using an out variable in a function is possible but not best practice, it will not be useable with a sql statement

-- multiple returns are possible when using an if statement like any other language, but not best practice

--Using return in a procedure does not return a value but returns control to the calling statement and moves on.

-- CREATE OR REPLACE PROCEDURE prodname_chg2_sp
--     (p_id IN bb_product.idproduct%TYPE,
--     p_name IN bb_product.productname%TYPE,
--     p_flag CHAR := 'N')
-- IS
-- BEGIN
--     UPDATE bb_product
--         SET productname = p_name
--         WHERE idproduct = p_id;
--     IF SQL%ROWCOUNT = 0 THEN
--         RETURN;
--     END IF;
--     COMMIT;
--     p_flag := 'Y';
--     --additional statements --
-- END;


--In parameters are passed by reference which is faster
--out or in out parameters are passed by value which makes a copy
--this can be overridden using the compiler hint NOCOPY
--passing by reference also updates the variable as the procedure runs not after as with passing values(copies)
-- NOCOPY cannot be passed an actual parameter that has a NOT NULL constraint

-- CREATE OR REPLACE PROCEDURE test_nocopy_sp
--     (p_in IN NUMBER,
--     p_out IN OUT NOCOPY VARCHAR2)
-- IS
-- BEGIN
--     p_out :='N';
--     IF p_in = 1 THEN
--         RAISE NO_DATA_FOUND;
--     END IF;
-- END;

-- -- call procedure
-- /
-- CREATE OR REPLACE PROCEDURE run_nocopy_sp
-- IS
--     lv_test_txt VARCHAR2(5);
-- begin
--     lv_test_txt := 'Y';
--     test_nocopy_sp(1,lv_test_txt);
-- EXCEPTION
--     WHEN OTHERS THEN
--         DBMS_OUTPUT.PUT_LINE('Error - var value = ' || lv_test_txt);
-- end;

--call run

-- BEGIN
--     run_nocopy_sp;
-- END;


--function purity levels affect what the function has permission to do

-- CREATE OR REPLACE FUNCTION fct_test1_sf
--     (p_num IN NUMBER)
--     RETURN NUMBER
-- IS
-- BEGIN
--     UPDATE bb_test1
--         SET col1 = p_num;
--     Return p_num;
-- END;

-- /
-- CREATE OR REPLACE FUNCTION fct_test2_sf
--     (p_num IN NUMBER)
--     RETURN NUMBER
-- IS
-- BEGIN
--     UPDATE bb_test2
--         SET col1 = p_num;
--     RETURN p_num;
-- END;

-- -- error in call below because function can't modify the table it is being called on
-- -- /
-- -- update bb_test1
-- --    set col1=fct_test1_sf(2);

-- --call below does not error as test2 effects a different table
-- /
-- update bb_test1
--    set col1=fct_test2_sf(2);

--SELECT call on function errors because funtion tries to modify db

-- select fct_test2_sf(col1)
--   from bb_test1;
