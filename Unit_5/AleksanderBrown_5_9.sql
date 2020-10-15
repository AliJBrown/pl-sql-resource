--Aleksander Brown
--Assignment 5-9

CREATE OR REPLACE PROCEDURE MEMBER_CK_SP
    (p_username_txt IN bb_shopper.username%TYPE,
    p_pwd_txt IN OUT VARCHAR2,
    p_check OUT VARCHAR2,
    p_cookie OUT bb_shopper.cookie%TYPE)
IS
BEGIN
    p_check := 'valid';
    -- DBMS_OUTPUT.PUT_LINE('in proc: '||p_username_txt||p_pwd_txt||p_check||p_cookie);
    SELECT (firstname || ' ' || lastname),cookie
        INTO p_pwd_txt, p_cookie
        FROM bb_shopper
        WHERE upper(username) = upper(p_username_txt)
        AND password = p_pwd_txt;
-- DBMS_OUTPUT.PUT_LINE('in proc select done: '||p_username_txt||p_pwd_txt||p_check||p_cookie);
EXCEPTION
    WHEN no_data_found THEN
        DBMS_OUTPUT.PUT_LINE('Invalid Username or Password');
        p_check := 'invalid';
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Other Error');
        p_check := 'invalid';
END;


/
DECLARE
    lv_username_txt bb_shopper.username%TYPE := 'rat55';
    lv_pwd_txt VARCHAR2(30) := 'kile';
    lv_check_txt VARCHAR(7);
    lv_cookie bb_shopper.cookie%TYPE;
BEGIN
    -- DBMS_OUTPUT.PUT_LINE(lv_username_txt || lv_pwd_txt || lv_check_txt || lv_cookie);
    MEMBER_CK_SP(lv_username_txt,lv_pwd_txt,lv_check_txt,lv_cookie);
    -- DBMS_OUTPUT.PUT_LINE(lv_username_txt || lv_pwd_txt || lv_check_txt || lv_cookie);
    IF lv_check_txt = 'invalid' THEN
        RAISE_APPLICATION_ERROR(-20000,'Invalid username or password');
    END IF;
    DBMS_OUTPUT.PUT_LINE('Name: ' || lv_pwd_txt);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Other Error');
END;