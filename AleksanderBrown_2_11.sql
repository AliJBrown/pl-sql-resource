--Aleksander Brown
--Assignment 2-11

DECLARE
    lv_start_date DATE := SYSDATE;
    lv_due_date DATE;
    lv_no_payments NUMBER(3):=3;
    lv_pledge_tot NUMBER(8,2):=0;
    lv_pledge_bal NUMBER(8,2):=0;
    lv_mo_pay_amt NUMBER(8,2):=100;
    lv_count_num NUMBER(2):=0;
BEGIN
    lv_pledge_tot := lv_no_payments * lv_mo_pay_amt;
    lv_pledge_bal := lv_pledge_tot;
    DBMS_OUTPUT.PUT_LINE('Pledge Total:' || TO_CHAR(lv_pledge_tot, '$999.99'));
    while LV_COUNT_NUM < lv_no_payments LOOP
        lv_count_num := lv_count_num + 1;
        lv_pledge_bal := lv_pledge_bal - lv_mo_pay_amt;
        DBMS_OUTPUT.PUT_LINE('Payment #:' || lv_COUNT_NUM || ' Due Date:' || TO_CHAR(lv_due_date,'MON DD, YYYY') ||
        ' Amount:'|| TO_CHAR(lv_mo_pay_amt,'$999.00') || ' Balance' || TO_CHAR(lv_pledge_bal,'$999.99'));
        lv_due_date := ADD_MONTHS(lv_due_date,1);
    END LOOP;
END;