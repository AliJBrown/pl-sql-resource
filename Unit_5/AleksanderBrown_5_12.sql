--Aleksander Brown
--Assignment 5-12

CREATE OR REPLACE PROCEDURE DDCKPAY_SP
    (p_idpledge_num IN dd_pledge.idpledge%TYPE,
    p_payamt_num IN NUMBER)
IS
    lv_paymonths_num dd_pledge.paymonths%TYPE;
    lv_pledgeAmt_num dd_pledge.pledgeamt%TYPE;
BEGIN
    SELECT pledgeamt, paymonths
        INTO lv_pledgeAmt_num, lv_paymonths_num
        FROM dd_pledge
        WHERE idpledge = p_idpledge_num;
    IF lv_paymonths_num != 0 THEN
        IF p_payamt_num != (lv_pledgeAmt_num/lv_paymonths_num) THEN
        RAISE_APPLICATION_ERROR(-20050,'Incorrect payment amount - planned payment = '
            || (lv_pledgeAmt_num/lv_paymonths_num));
        END IF;
    ELSIf p_payamt_num != lv_pledgeAmt_num THEN
        RAISE_APPLICATION_ERROR(-20050,'Incorrect payment amount - planned payment = '
            || lv_pledgeAmt_num);
    END IF;
    DBMS_OUTPUT.PUT_LINE('Correct payment amount');
EXCEPTION
    WHEN no_data_found THEN
        DBMS_OUTPUT.PUT_LINE('No Payment Information');
END;


/
BEGIN
  ddckpay_sp(104,25);
END;
/
BEGIN
  ddckpay_sp(104,20);
END;
/
BEGIN
  ddckpay_sp(101,50);
END;