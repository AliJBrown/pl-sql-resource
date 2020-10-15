--Aleksander Brown
--Case 5-2

--MOVIE_RENT_SP
    --new record to MM_RENTAL
    --update movie inventory MOVIE_QTY column of MM_MOVIE
    --accept member ID, movie ID, and payment method
--test 13-12-4

CREATE OR REPLACE PROCEDURE MOVIE_RENT_SP
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
END;

/

--MOVIE_RETURN_SP
    --logs current date in CHECKIN_DATE column and update movie inventory
    --accepts member id, movie id
    --determine rental id
--test 13-12

CREATE OR REPLACE PROCEDURE MOVIE_RETURN_SP
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
END;


/


select * from mm_rental;
select * from mm_movie;
/
BEGIN
 movie_rent_sp(13, 12, 4);
 movie_rent_sp(10, 1, 5);
 movie_rent_sp(14, 3, 2);
END;
/
select * from mm_rental;
select * from mm_movie;
/
select * from mm_rental;
select * from mm_movie;
/
BEGIN
 movie_return_sp(13, 12);
 movie_return_sp(10, 8);
 movie_return_sp(14,7);
END;
/
select * from mm_rental;
select * from mm_movie;