--Aleksander Brown
-- Assignment 9-2

CREATE OR REPLACE TRIGGER bb_reqfill_trg
  AFTER UPDATE OF dtRecd ON bb_product_request
  FOR EACH ROW
BEGIN
  IF :OLD.dtRecd IS NULL THEN
    UPDATE bb_product
      SET stock = stock + :NEW.qty
      WHERE idProduct = :NEW.idProduct;
  END IF;
END;