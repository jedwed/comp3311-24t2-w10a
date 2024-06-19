/*
 * Q12
 * Find the names of suppliers who supply some red part.
 */

SELECT
    DISTINCT s.sname
FROM
    suppliers AS s
JOIN
    catalog AS c
    ON s.sid = c.sid
JOIN
    parts AS p
    ON c.pid = p.pid
WHERE
    p.colour = 'red';
    

/*
 * Q13
 * Find the sids of suppliers who supply some red or green part.
 */

SELECT
    DISTINCT s.sname
FROM
    suppliers AS s
JOIN
    catalog AS c
    ON s.sid = c.sid
JOIN
    parts AS p
    ON c.pid = p.pid
WHERE
    p.colour = 'red' OR p.colour = 'green';

/*
 * Q15
 * Find the sids of suppliers who supply some red part and some green part.
 *
 * NOTE: cannot simply change the above condition to p.colour = 'red' AND p.colour = 'green'
 * since a tuple cannot simultaneously have a colour of red and green. 
 * Must use set operation INTERSECT
 */


SELECT
    s.sname
FROM
    suppliers AS s
JOIN
    catalog AS c
    ON s.sid = c.sid
JOIN
    parts AS p
    ON c.pid = p.pid
WHERE
    p.colour = 'red'
INTERSECT
SELECT
    s.sname
FROM
    suppliers AS s
JOIN
    catalog AS c
    ON s.sid = c.sid
JOIN
    parts AS p
    ON c.pid = p.pid
WHERE
    p.colour = 'green';

/*
 * Q16
 * Find the sids of suppliers who supply every part.
 */

-- Suppliers who supply every part is logically equivalent to:
-- Suppliers for whomst there doesn't exist a part that they haven't supplied

SELECT 
    sid
FROM
    suppliers AS s
WHERE NOT EXISTS (
    -- Subquery for all pids that the current supplier doesn't supply
    SELECT 
        pid 
    FROM 
        parts
    EXCEPT
    SELECT 
        pid 
    FROM 
        catalog 
    WHERE 
        sid = s.sid
)


/*
 * Q22
 * Find the pids of the most expensive part(s) supplied by suppliers named "Yosemite Sham".
 */

-- Method 1:
SELECT 
    pid
FROM
    catalog AS c1
JOIN
    suppliers AS s1
    ON c.sid = s.sid
WHERE
    s.sname = 'Yosemite Sham'
    AND cost = (
        SELECT 
            MAX(cost)
        FROM
            catalog c2
        JOIN
            suppliers s2
            ON c2.sid = s2.sid
        WHERE
            s2.sname = 'Yosemite Sham'
    )

-- The above code is quite messy! I would recommend creating a view here:
-- Method 2:

 -- Finding pids supplied by "Yosemite Sham"
CREATE VIEW yosemiteSupplies (pids, cost) AS
    SELECT 
        c.pid,
        c.cost
    FROM
        catalog AS c
    JOIN
        suppliers AS s
        ON c.sid = s.sid
    WHERE
        s.sname = 'Yosemite Sham';

 -- find the most expensive part out of the above
SELECT 
    pids
FROM 
    yosemiteSupplies
WHERE 
    cost = (
        select max(cost) from YosemiteSupplies
    );

-- NOTE: the method of sorting then limiting below is not recommended
-- ORDER BY cost DESC
-- LIMIT 1
-- If there are multiple parts that are tied for the most expensive,
-- the query will only return one of them.



