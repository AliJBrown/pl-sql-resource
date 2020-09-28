--Aleksander Brown
--Assignment 3-13

DECLARE
  rec_project dd_project%ROWTYPE;
  lv_id_num dd_project.idproj%TYPE := 500;
  lv_old_goal_num dd_project.projfundgoal%TYPE;
BEGIN
  SELECT *
    INTO rec_project
    FROM dd_project
    WHERE idproj = lv_id_num;
  lv_old_goal_num := rec_project.projfundgoal;
  rec_project.projfundgoal := lv_old_goal_num * 2;
    UPDATE dd_project SET ROW = rec_project
      WHERE idproj = rec_project.idproj
      RETURNING idproj,projname,projstartdate,projenddate,projfundgoal,projcoord
      INTO rec_project;
  DBMS_OUTPUT.PUT_LINE('project name: ' || rec_project.projname ||
    ', start date: ' || TO_CHAR(rec_project.projstartdate,'mm-dd-yy') ||
    ', Old Goal: ' || TO_CHAR(lv_old_goal_num,'$999999.99') ||
    ', New Goal: ' || TO_CHAR(rec_project.projfundgoal,'$999999.99'));
END;
