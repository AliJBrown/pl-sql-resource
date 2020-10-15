--Aleksander Brown
--Assignment 5-36

CREATE OR REPLACE PROCEDURE TAX_COST_SP
    (p_state IN OUT bb_tax.state%TYPE,
    p_sub IN NUMBER,
    p_amt OUT bb_tax.taxrate%TYPE)
IS
BEGIN
    p_state := UPPER(p_state);
    SElECT taxrate
        INTO p_amt
        FROM bb_tax
        WHERE state = p_state;
    p_amt := p_amt * p_sub;
    -- DBMS_OUTPUT.PUT_LINE('state ' || p_state || ' amt ' || p_amt);
EXCEPTION
    WHEN no_data_found THEN
        p_amt := 0;
END;


/
DECLARE
    lv_tax_amount NUMBER(6,2);
    lv_state_test1 bb_tax.state%TYPE := 'VA';
    lv_state_test2 bb_tax.state%TYPE := 'va';
    lv_state_test3 bb_tax.state%TYPE := 'IA';
    lv_state_test4 bb_tax.state%TYPE := 'NC';
begin
  TAX_COST_SP(lv_state_test1,100,lv_tax_amount);
  DBMS_OUTPUT.PUT_LINE(TO_CHAR(lv_tax_amount,'$999.99'));
  TAX_COST_SP(lv_state_test2,50,lv_tax_amount);
  DBMS_OUTPUT.PUT_LINE(TO_CHAR(lv_tax_amount,'$999.99'));
  TAX_COST_SP(lv_state_test3,10,lv_tax_amount);
  DBMS_OUTPUT.PUT_LINE(TO_CHAR(lv_tax_amount,'$999.99'));
  TAX_COST_SP(lv_state_test4,100,lv_tax_amount);
  DBMS_OUTPUT.PUT_LINE(TO_CHAR(lv_tax_amount,'$999.99'));
end;