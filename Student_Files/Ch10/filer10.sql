DECLARE
 fh UTL_FILE.FILE_TYPE;
 vTextOut VARCHAR2(25);
BEGIN
 fh := UTL_FILE.FOPEN('ORA_FILES', 'test.txt', 'r');
 IF UTL_FILE.IS_OPEN(fh) THEN
  DBMS_OUTPUT.PUT_LINE('File read open');
 ELSE
  DBMS_OUTPUT.PUT_LINE('File read not open');
 END IF;
 UTL_FILE.GET_LINE(fh,vTextOut);
 DBMS_OUTPUT.PUT_LINE('Value read: '||vTextOut);
 UTL_FILE.FCLOSE(fh);
END;