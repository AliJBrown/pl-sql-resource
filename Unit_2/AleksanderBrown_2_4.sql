-- Aleksander Brown
-- Assignment 2-4

DECLARE
    lv_total_num NUMBER(3);
    lv_rating_txt VARCHAR2(4);
BEGIN
    lv_total_num := 300;
    CASE
        WHEN lv_total_num > 200 THEN
            lv_rating_txt := 'HIGH';
        WHEN lv_total_num > 100 THEN
            lv_rating_txt := 'MID';
        ELSE lv_rating_txt := 'LOW';
    END CASE;
    DBMS_OUTPUT.PUT_LINE(CONCAT('Total of Purchases: ', lv_total_num));
    DBMS_OUTPUT.PUT_LINE(CONCAT('Customer Rating: ', lv_rating_txt));
END;
/
DECLARE
    lv_total_num NUMBER(3);
    lv_rating_txt VARCHAR2(4);
BEGIN
    lv_total_num := 150;
    CASE
        WHEN lv_total_num > 200 THEN
            lv_rating_txt := 'HIGH';
        WHEN lv_total_num > 100 THEN
            lv_rating_txt := 'MID';
        ELSE lv_rating_txt := 'LOW';
    END CASE;
    DBMS_OUTPUT.PUT_LINE(CONCAT('Total of Purchases: ', lv_total_num));
    DBMS_OUTPUT.PUT_LINE(CONCAT('Customer Rating: ', lv_rating_txt));
END;
/
DECLARE
    lv_total_num NUMBER(3);
    lv_rating_txt VARCHAR2(4);
BEGIN
    lv_total_num := 75;
    CASE
        WHEN lv_total_num > 200 THEN
            lv_rating_txt := 'HIGH';
        WHEN lv_total_num > 100 THEN
            lv_rating_txt := 'MID';
        ELSE lv_rating_txt := 'LOW';
    END CASE;
    DBMS_OUTPUT.PUT_LINE(CONCAT('Total of Purchases: ', lv_total_num));
    DBMS_OUTPUT.PUT_LINE(CONCAT('Customer Rating: ', lv_rating_txt));
END;