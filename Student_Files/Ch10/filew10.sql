DECLARE
fh UTL_FILE.FILE_TYPE;
BEGIN
fh := UTL_FILE.FOPEN('ORA_FILES', 'test.txt', 'w');
UTL_FILE.PUT_LINE(fh, 'Hello World');
UTL_FILE.FCLOSE(fh);
EXCEPTION
  WHEN OTHERS THEN
   dbms_output.put_line(SQLERRM);
END;