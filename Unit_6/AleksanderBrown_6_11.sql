--Aleksander Brown
--Assignment 6-11

CREATE OR REPLACE FUNCTION dd_plstat_sf
    (p_statusId IN dd_status.idstatus%TYPE)
    RETURN dd_status.statusdesc%TYPE
IS
    lv_desc_txt dd_status.statusdesc%TYPE;
BEGIN
    SELECT statusdesc
        INTO lv_desc_txt
        FROM dd_status
        Where idstatus = p_statusId;
    RETURN lv_desc_txt;
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Other Error');
END;
