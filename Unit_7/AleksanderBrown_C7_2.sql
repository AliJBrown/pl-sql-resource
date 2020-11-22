--Aleksander Brown
--Case 7-2

CREATE OR REPLACE PACKAGE mm_rentals_pkg
IS
    FUNCTION mm_qtyck_sf
        (p_movieId IN mm_movie.movie_id%TYPE)
        RETURN VARCHAR2;
    PROCEDURE MOVIE_RENT_SP
        (p_memberid IN mm_rental.member_id%TYPE,
        p_movieid IN mm_rental.movie_id%TYPE,
        p_paymthd IN mm_rental.payment_methods_id%TYPE);
    PROCEDURE MOVIE_RETURN_SP
        (p_memberid IN mm_rental.member_id%TYPE,
        p_movieid IN mm_rental.member_id%TYPE);
END;

/

CREATE OR REPLACE PACKAGE BODY mm_rentals_pkg IS
    FUNCTION mm_qtyck_sf
        (p_movieId IN mm_movie.movie_id%TYPE)
        RETURN VARCHAR2
    IS
        lv_qty_num mm_movie.movie_qty%TYPE;
        lv_title_txt mm_movie.movie_title%TYPE;
        lv_avail_txt VARCHAR2(15);
        lv_txt VARCHAR2(60);
    BEGIN
        SELECT movie_title,movie_qty
            INTO lv_title_txt,lv_qty_num
            FROM mm_movie
            WHERE movie_id = p_movieId;
        IF lv_qty_num = 0 THEN
            lv_avail_txt := 'is NOT Available:';
        ELSE
            lv_avail_txt := 'is Available:';
        END IF;
        lv_txt := lv_title_txt || ' ' || lv_avail_txt || ' ' || TO_CHAR(lv_qty_num) || ' on the shelf.';
        RETURN lv_txt;
    EXCEPTION
        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Other Error');
    END MM_QTYCK_SF;
    PROCEDURE MOVIE_RENT_SP
        (p_memberid IN mm_rental.member_id%TYPE,
        p_movieid IN mm_rental.movie_id%TYPE,
        p_paymthd IN mm_rental.payment_methods_id%TYPE)
    IS
    BEGIN
        INSERT INTO mm_rental
        VALUES(MM_RENTAL_SEQ.NEXTVAL,p_memberid,p_movieid,SYSDATE,null,p_paymthd);
        update mm_movie
        set movie_qty=movie_qty-1
        where movie_id=p_movieid;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Other Error');
    END MOVIE_RENT_SP;
    PROCEDURE MOVIE_RETURN_SP
        (p_memberid IN mm_rental.member_id%TYPE,
        p_movieid IN mm_rental.member_id%TYPE)
    IS
    BEGIN
        update mm_rental
        set checkin_date =SYSDATE
        where member_id = p_memberid
        AND movie_id = p_movieid
        And checkin_date = null;
        update mm_movie
        set movie_qty=movie_qty+1
        where movie_id=p_movieid;
    EXCEPTION
        WHEN no_data_found THEN
            DBMS_OUTPUT.PUT_LINE('No Rental Found');
    END MOVIE_RETURN_SP;
END;

/
DECLARE
  lv_movieID mm_movie.movie_id%type  := 6;
  lv_txt     varchar2(100);
BEGIN
  lv_txt := mm_rentals_pkg.MM_QTYCK_SF(lv_movieID);
  DBMS_OUTPUT.PUT_LINE(lv_txt);
END;
/
DECLARE
  lv_movieID mm_movie.movie_id%type  := 7;
  lv_txt     varchar2(100);
BEGIN
  lv_txt := mm_rentals_pkg.MM_QTYCK_SF(lv_movieID);
  DBMS_OUTPUT.PUT_LINE(lv_txt);
END;