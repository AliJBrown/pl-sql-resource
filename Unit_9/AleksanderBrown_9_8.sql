--Aleksander Brown
-- Assignment 9-8

CREATE OR REPLACE TRIGGER bb_audit_trg
  AFTER UPDATE OF productname, price, salestart, saleend, saleprice
  ON bb_product
  FOR EACH ROW
BEGIN
  INSERT INTO bb_prodchg_audit
    VALUES (USER, SYSDATE, :OLD.productname, :NEW.productname,
      :OLD.price, :NEW.price, :OLD.salestart, :NEW.salestart,
      :OLD.saleend, :NEW.saleend, :OLD.saleprice, :NEW.saleprice);
END;
