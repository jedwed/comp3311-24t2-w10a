/*
 * Q2 
 * A new government initiative to get more young people into work 
 * cuts the salary levels of all workers under 25 by 20%. 
 * Write an SQL statement to implement this policy change.
 */

 -- Cut salary levels of all workers under 25 by 20%

UPDATE 
    employees
SET
    salary = 0.8 * salary
WHERE 
    age < 25;

/*
 * Q3
 * The company has several years of growth and high profits, 
 * and considers that the Sales department is primarily responsible for this. 
 * Write an SQL statement to give all employees in the Sales department a 10% pay rise.
 */

/*
 * Two different methods using two different views
 * Using views is not strictly necessary, but highly recommended
 * as they create useful abstractions which make it easier to
 * read and write queries without the eyesore of multiple joins
 */

-- Method 1:
CREATE VIEW salesEmployees (id) AS
    SELECT
        worksIn.eid
    FROM 
        worksIn
    JOIN
        departments
        ON worksIn.did = departments.did
    WHERE
        departments.dname = 'Sales';

UPDATE
    employees
SET
    salary = 1.2 * salary
WHERE
    eid in (
        SELECT id FROM salesEmployees
    );

-- Method 2

CREATE VIEW employeeDepartments (id, department) AS
    SELECT
        worksIn.eid, departments.name
    FROM 
        worksIn
    JOIN
        departments
        ON worksIn.did = departments.did

UPDATE
    employees
SET
    salary = 1.2 * salary
WHERE
    eid in (
        SELECT id FROM employeeDepartments WHERE department = 'Sales'
    );

-- subquery to get eids in the sales departments
--
-- SELECT
--     employees.eid
-- FROM 
--     employees
-- JOIN
--     worksIn
--     ON employees.eid = worksIn.eid;
-- JOIN
--     departments
--     ON worksIn.did = departments.did
-- WHERE
--     departments.dname = 'Sales'
--
--     
--
--
