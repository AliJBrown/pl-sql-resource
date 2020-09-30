--Aleksander Brown
--Assignment 4-13

DECLARE
  lv_old_num dd_donor.iddonor%TYPE := 301;
  lv_new_num dd_donor.iddonor%TYPE := 305;
  ex_donor_pk EXCEPTION;
  PRAGMA EXCEPTION_INIT(ex_donor_pk, -0001);
BEGIN
  UPDATE dd_donor
   SET iddonor = lv_new_num
   WHERE iddonor = lv_old_num;
EXCEPTION
  WHEN ex_donor_pk THEN
    DBMS_OUTPUT.PUT_LINE('This ID is already assigned');
END;
