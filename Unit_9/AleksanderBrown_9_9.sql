--Aleksander Brown
-- Assignment 9-9




CREATE TABLE dd_paytrack
  (idtrack NUMBER(5),
   ptuser VARCHAR2(30),
   ptdate DATE,
   ptaction VARCHAR2(6),
   ptpayid NUMBER(6),
     CONSTRAINT paytrack_pk PRIMARY KEY(idtrack) );
/
CREATE SEQUENCE dd_ptrack_seq
  NOCACHE;
/
CREATE OR REPLACE TRIGGER dd_ptrack_trg
  AFTER DELETE OR UPDATE OR INSERT ON dd_payment
  FOR EACH ROW
DECLARE
  lv_action_txt VARCHAR2(6);
  lv_id_num NUMBER(6);
BEGIN
  lv_id_num := :NEW.idpay;
  IF UPDATING THEN
    lv_action_txt := 'UPDATE';
  ELSIF DELETING THEN
    lv_action_txt := 'DELETE';
    lv_id_num := :OLD.idpay;
  ELSIF INSERTING THEN
    lv_action_txt := 'INSERT';
  END IF;
  INSERT INTO dd_paytrack
    VALUES(dd_ptrack_seq.NEXTVAL,USER,SYSDATE,lv_action_txt,lv_id_num);
END;