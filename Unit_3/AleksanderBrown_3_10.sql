--Aleksander Brown
--Assignment 3-10

CREATE SEQUENCE DD_PROJID_SEQ
MINVALUE 0
START WITH 530
INCREMENT BY 1
NOCACHE;
/
DECLARE
  rec_project dd_project%ROWTYPE;
BEGIN
  rec_project.idproj := DD_PROJID_SEQ.NEXTVAL;
  rec_project.projname := 'HK Animal Shelter Extension';
  rec_project.projstartdate := '01-JAN-13';
  rec_project.projenddate := '31-MAY-13';
  rec_project.projfundgoal := 65000;
  INSERT INTO dd_project
    VALUES rec_project;
END;
