--Aleksander Brown
-- Assignment 4-9

DECLARE
  CURSOR cur_pledge (d_id NUMBER) IS
    SELECT idpledge, pl.pledgeamt, pl.paymonths, pa.paydate, pa.payamt
      FROM dd_pledge pl INNER JOIN dd_payment pa
        USING (idpledge)
        Where pl.iddonor = d_id
        ORDER BY idpledge ASC, pa.paydate ASC;
  TYPE type_payment IS RECORD(
    idpledge dd_pledge.idpledge%TYPE,
    pledgeamt dd_pledge.pledgeamt%TYPE,
    paymonths dd_pledge.paymonths%TYPE,
    paydate dd_payment.paydate%TYPE,
    payamt dd_payment.payamt%TYPE
  );
  rec_payment type_payment;
  lv_donor_num dd_pledge.iddonor%TYPE := 309;
  lv_current_num dd_pledge.idpledge%TYPE := -1;
BEGIN
  OPEN cur_pledge(lv_donor_num);
  LOOP
    FETCH cur_pledge INTO rec_payment;
    EXIT WHEN cur_pledge%NOTFOUND;
    DBMS_OUTPUT.put(rec_payment.idpledge || ' - ' ||
      TO_CHAR(rec_payment.pledgeamt,'$999.99') || ' - ' ||
      rec_payment.paymonths || ' - ' || TO_CHAR(rec_payment.paydate,'dd-mon-yy')
      || ' - ' || TO_CHAR(rec_payment.payamt,'$999.99'));
    IF rec_payment.idpledge != lv_current_num then
      DBMS_OUTPUT.PUT_LINE('- First Payment');
      lv_current_num := rec_payment.idpledge;
    ELSE
      DBMS_OUTPUT.PUT_LINE('');
    END IF;
  END LOOP;
  CLOSE cur_pledge;
END;

/*
Create a block to retrieve and display pledge and payment information for
specific donor. For each pledge payment from the donor display the

- pledge id
- pledge amount
- number of monthly payments
- payment DATE
- payment amount

Sorted by pledge id then payment DATE

for first payment made for each pledge display "first payment" on the output row
*/
