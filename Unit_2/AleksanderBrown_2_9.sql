--Aleksander Brown
--Assignment 2-9

DECLARE
    lv_start_date DATE := SYSDATE;
    lv_mo_pay_amt NUMBER(8,2) := 100;
    lv_no_payments NUMBER(2) := 3;
    lv_pledge_tot NUMBER(8,2) := 0;
    lv_pledge_bal NUMBER(8,2) := 0;
    lv_due_date DATE;
BEGIN
    lv_pledge_tot := lv_mo_pay_amt * lv_no_payments;
    lv_pledge_bal := lv_pledge_tot;
    lv_due_date := lv_start_date;
    DBMS_OUTPUT.PUT_LINE(CONCAT('Total Pledge Amount: ', TO_CHAR(lv_pledge_tot, '$999.99')));
    FOR i IN 1..lv_no_payments LOOP
        lv_pledge_bal := lv_pledge_bal - lv_mo_pay_amt;
        DBMS_OUTPUT.PUT_LINE('Payment Number: ' || i ||' Due Date: ' || TO_CHAR(lv_due_date,'MON DD, YYYY') ||
        ' Payment Amount: ' || TO_CHAR(lv_mo_pay_amt,'$999.99') || ' Amount Remaining: ' || TO_CHAR(lv_pledge_bal,'$999.99'));
        lv_due_date := ADD_MONTHS(lv_due_date, 1);
    END LOOP;
END;