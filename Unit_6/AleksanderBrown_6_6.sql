--Aleksander Brown
--Assignment 6-6

CREATE OR REPLACE FUNCTION status_desc_sf
    (p_stage_num IN bb_basketstatus.idstatus%TYPE)
    return VARCHAR2
IS
    lv_desc_txt VARCHAR2(40);
BEGIN
    case p_stage_num
      when 1 then lv_desc_txt := 'Order Submitted';
      when 2 then lv_desc_txt := 'Accepted, sent to shipping';
      when 3 then lv_desc_txt := 'Back-ordered';
      when 4 then lv_desc_txt := 'Cancelled';
      when 5 then lv_desc_txt := 'Shipped';
      else lv_desc_txt := 'Unknown';
    end case;
    RETURN lv_desc_txt;
EXCEPTION
    WHEN OTHERS then
    DBMS_OUTPUT.PUT_LINE('Other Error');
END;
