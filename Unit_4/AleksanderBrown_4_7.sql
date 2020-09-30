--Aleksander Brown
-- assignment 4-7

DECLARE
  lv_old_num bb_basketitem.idBasket%TYPE := 30;
  lv_new_num bb_basketitem.idBasket%TYPE := 4;
  ex_basket_pk EXCEPTION;
BEGIN
  UPDATE bb_basketitem
   SET idBasket = lv_new_num
   WHERE idBasket = lv_old_num;
 IF SQL%NOTFOUND THEN
   RAISE ex_basket_pk;
  END IF;
EXCEPTION
  WHEN ex_basket_pk THEN
    DBMS_OUTPUT.PUT_LINE('Invalid original basket ID');
END;
