-- Aleksander Brown
-- Assignment 2-4

--IDBASKET, SUBTOTAL, SHIPPING, TAX, TOTAL from BB_BASKET

DECLARE
  lv_id_num bb_basket.idbasket%TYPE := 12;
  lv_sub_num bb_basket.subtotal%TYPE;
  lv_shipping_num bb_basket.shipping%TYPE;
  lv_tax_num bb_basket.tax%TYPE;
  lv_tot_num bb_basket.total%TYPE;
BEGIN
  SELECT subtotal, shipping, tax, total
    INTO lv_sub_num, lv_shipping_num, lv_tax_num,lv_tot_num
    FROM bb_basket
    WHERE idbasket = lv_id_num;
  DBMS_OUTPUT.PUT_LINE('basket id: ' || lv_id_num);
  DBMS_OUTPUT.PUT_LINE('subtotal: ' || lv_sub_num);
  DBMS_OUTPUT.PUT_LINE('shipping: ' || lv_shipping_num);
  DBMS_OUTPUT.PUT_LINE('tax: ' || lv_tax_num);
  DBMS_OUTPUT.PUT_LINE('total: ' || lv_tot_num);
END;
