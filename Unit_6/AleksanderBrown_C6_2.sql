--Aleksander brown
--Case 6-2

CREATE OR REPLACE FUNCTION mm_qtyck_sf
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
END;
