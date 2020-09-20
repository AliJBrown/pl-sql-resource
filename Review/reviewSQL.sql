--Aleksander Brown
--Chapter 1 walkthrough

--Traditional Join
/*
SELECT p.productname, p.active, d.deptname
    FROM bb_product p, bb_department d
    WHERE p.iddepartment = d.iddepartment;
*/


--ANSI Join
/*
SELECT p.productname, p.active, d.deptname
    FROM bb_product p INNER JOIN bb_department d
        USING(iddepartment);
*/


--Aggreggate Function
/*
SELECT deptname, COUNT(idproduct)
    FROM bb_product p INNER JOIN bb_department d
        USING(iddepartment)
    GROUP BY deptname;
*/


--Basic Where
/*
SELECT AVG(price)
    FROM bb_product
    WHERE type = 'C';
*/


--Create table including primary key constraint (auto_id_pk is the constraint name, referenced if errors occur)
/*
CREATE TABLE autos
    (auto_id NUMBER(5),
    acquire_date DATE,
    color VARCHAR2(15),
    CONSTRAINT auto_id_pk PRIMARY KEY (auto_id));
*/


--Query table structure
/*
DESC autos;
*/


--DML REVIEW
--commit saves permanently
--Insert
/*
INSERT INTO autos (auto_id, acquire_date, color)
    VALUES (45321, '05-MAY-2012', 'gray');
INSERT INTO autos (auto_id, acquire_date, color)
    VALUES (81433, '12-OCT-2012', 'red');
COMMIT;
SELECT * FROM autos;
*/

--Update to modify existing
/*
UPDATE autos
    SET color = 'silver'
    WHERE auto_id = 45321;
SELECT *
    FROM autos;
*/

--Last action was not saved because 'commit' was not called
--Rollback will undo the update if commit was not called
/*
ROLLBACK;
SELECT * FROM autos;
*/


--Delete to remove a row
/*
DELETE FROM autos
    WHERE auto_id = 45321;
SELECT *
    FROM autos;
*/

--Drop table
/*
DROP TABLE autos;
SELECT *
    FROM autos;
*/

commit;