CREATE OR REPLACE PROCEDURE prodname_chg_sp
  (p_id IN bb_product.idproduct%TYPE,
   p_name IN bb_product.productname%TYPE)
  IS
BEGIN
  UPDATE bb_product
    SET productname = p_name
    WHERE idproduct = p_id;
  COMMIT;
END;
/
