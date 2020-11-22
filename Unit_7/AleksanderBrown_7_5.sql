--Aleksander Brown
--Assignment 7-5

CREATE OR REPLACE PACKAGE shop_query_pkg
IS
    PROCEDURE shop_lookup_pp
        (p_idshopper IN BB_SHOPPER.IDSHOPPER%TYPE,
        p_name OUT BB_SHOPPER.LASTNAME%TYPE,
        p_city OUT BB_SHOPPER.CITY%TYPE,
        p_state OUT BB_SHOPPER.STATE%TYPE,
        p_phone OUT BB_SHOPPER.PHONE%TYPE,
        p_email OUT BB_SHOPPER.EMAIL%TYPE);
    PROCEDURE shop_lookup_pp
        (p_lastname IN BB_SHOPPER.LASTNAME%TYPE,
        p_name OUT BB_SHOPPER.LASTNAME%TYPE,
        p_city OUT BB_SHOPPER.CITY%TYPE,
        p_state OUT BB_SHOPPER.STATE%TYPE,
        p_phone OUT BB_SHOPPER.PHONE%TYPE,
        p_email OUT BB_SHOPPER.EMAIL%TYPE);
END;
/
CREATE OR REPLACE PACKAGE BODY shop_query_pkg
IS
    PROCEDURE shop_lookup_pp
        (p_idshopper IN BB_SHOPPER.IDSHOPPER%TYPE,
        p_name OUT BB_SHOPPER.LASTNAME%TYPE,
        p_city OUT BB_SHOPPER.CITY%TYPE,
        p_state OUT BB_SHOPPER.STATE%TYPE,
        p_phone OUT BB_SHOPPER.PHONE%TYPE,
        p_email OUT BB_SHOPPER.EMAIL%TYPE)
    IS
    BEGIN
        SELECT firstname || ' ' || lastname , city, state, phone, EMAIL
            INTO p_name, p_city, p_state, p_phone, p_email
            FROM BB_SHOPPER
            WHERE IDSHOPPER = p_idshopper;
    END shop_lookup_pp;
    PROCEDURE shop_lookup_pp
        (p_lastname IN BB_SHOPPER.LASTNAME%TYPE,
        p_name OUT BB_SHOPPER.LASTNAME%TYPE,
        p_city OUT BB_SHOPPER.CITY%TYPE,
        p_state OUT BB_SHOPPER.STATE%TYPE,
        p_phone OUT BB_SHOPPER.PHONE%TYPE,
        p_email OUT BB_SHOPPER.EMAIL%TYPE)
    IS
    BEGIN
        SELECT firstname || ' ' || lastname , city, state, phone, EMAIL
            INTO p_name, p_city, p_state, p_phone, p_email
            FROM BB_SHOPPER
            WHERE LASTNAME = p_lastname;
    END shop_lookup_pp;
END;