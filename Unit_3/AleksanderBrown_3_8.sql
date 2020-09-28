--Aleksander Brown
--Assignment 3-8

--IDBASKET, SUBTOTAL, SHIPPING, TAX, TOTAL from BB_BASKET

DECLARE
  TYPE type_basket IS RECORD(
    subtotal bb_basket.subtotal%TYPE,
    shipping bb_basket.shipping%TYPE,
    tax bb_basket.tax%TYPE,
    total bb_basket.total%type
  );
  rec_basket type_basket;
  lv_id_num bb_basket.idbasket%TYPE := 12;
BEGIN
  SELECT subtotal, shipping, tax, total
    INTO rec_basket
    FROM bb_basket
    WHERE idbasket = lv_id_num;
  DBMS_OUTPUT.PUT_LINE('basket id: ' || lv_id_num);
  DBMS_OUTPUT.PUT_LINE('subtotal: ' || rec_basket.subtotal);
  DBMS_OUTPUT.PUT_LINE('shipping: ' || rec_basket.shipping);
  DBMS_OUTPUT.PUT_LINE('tax: ' || rec_basket.Tax);
  DBMS_OUTPUT.PUT_LINE('total: ' || rec_basket.total);
END;
