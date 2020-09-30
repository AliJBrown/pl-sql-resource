--Aleksander Brown
--Assignment 4-5

DECLARE
 rec_shopper bb_shopper%ROWTYPE;
 lv_shopper_num bb_shopper.idShopper%TYPE := 99;
BEGIN
 SELECT *
  INTO rec_shopper
  FROM bb_shopper
  WHERE idShopper = lv_shopper_num;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Invalid shopper ID');
END;
