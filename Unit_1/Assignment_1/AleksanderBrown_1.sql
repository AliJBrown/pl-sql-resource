--Aleksander Brown
--CIS338
--Unit 1

--1.
    --Psuedo
        --select
            -- first name, last name, pledge date, pledge amount
        --Join
            -- dd-donors, dd_pledge
        --Where    
            --made pledge and single lump sum payment
        
SELECT d.firstname, d.lastname, p.pledgedate, p.pledgeamt
    FROM dd_donor d JOIN dd_pledge p
    ON d.iddonor = p.iddonor
    WHERE p.paymonths = 0;
    
    
--2
    --Psuedo
        --select
            --first name, last name, pledge date, pledge amount
            --calculated monthly amount
        --Join
            -- dd_donors, dd_pledge
        --Where
            --Payments over 12 mo

SELECT d.firstname, d.lastname, p.pledgedate, p.pledgeamt, p.pledgeamt / p.paymonths AS "MONTHLYPMT"
    FROM dd_donor d JOIN dd_pledge p
    ON d.iddonor = p.iddonor
    WHERE p.paymonths = 12;
    
    
--3
    --Psuedo
        --Select
            -- project id, project name
        --Join
            --dd_project, dd_pledge
        -- Where
            -- Pledge !null

SELECT DISTINCT pr.idproj, pr.projname
    FROM dd_project pr join dd_pledge pl
    ON pr.idproj = pl.idproj;
    
    
--4
    --Psuedo
        --Select
            -- donor id, first name, last name
            --calculated number of pledges
        --Join
            --dd_donor, dd_pledge

            
SELECT dd_donor.iddonor, dd_donor.firstname, dd_donor.lastname, p."pledges"
    FROM dd_donor 
    INNER JOIN(SELECT DISTINCT iddonor, COUNT(idpledge) AS "pledges" FROM dd_pledge GROUP BY iddonor) p
    ON dd_donor.iddonor = p.iddonor;


--5
    --Psuedo
        --Select
            -- All from pledge
        --FROM
            --pledge
        --WHERE
            -- date < 03-08-2012

SELECT *
    FROM dd_pledge
    WHERE pledgedate < '08-mar-12';