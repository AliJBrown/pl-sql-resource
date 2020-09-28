--Aleksander Brown
-- Assignment 3-9

DECLARE
  TYPE type_project IS RECORD(
    projname dd_project.projname%TYPE,
    pledges NUMBER(3),
    pledgeamt NUMBER(8,2),
    averageamt NUMBER(8,2)
  );
  rec_project type_project;
  lv_idproj_number dd_project.projname%TYPE := 501;
BEGIN
  SELECT projname, COUNT(idpledge) "pledges", SUM(pledgeamt) "totalamt", AVG(pledgeamt) "avgamt"
    INTO rec_project
      FROM dd_project JOIN dd_pledge USING (idproj)
      GROUP BY idproj,projname
      HAVING idproj = lv_idproj_number;
  DBMS_OUTPUT.PUT_LINE('project id: ' || lv_idproj_number || ', project name: ' ||
    rec_project.projname || ', Number of Pledges: ' || rec_project.pledges ||
    ', Total Amount Pledged: ' || rec_project.pledgeamt || ', Average Pledge: ' ||
    rec_project.averageamt);
END;
