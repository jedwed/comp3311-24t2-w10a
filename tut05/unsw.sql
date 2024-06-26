-- Q14
CREATE OR REPLACE FUNCTION unitName(_ouid integer) RETURNS TEXT AS $$
DECLARE
    _otype text;
    _oname text;
BEGIN
    SELECT
        o.longname, ot.name
    INTO
        _oname, _otype
    FROM
        orgunit AS o
    JOIN
        orgunittype AS ot
        ON o.utype = ot.id
    WHERE
        o.id = _ouid; 

    IF NOT found THEN
        RETURN 'Error: oiasdfhasifhod';
    END IF;


    IF _otype = 'University' THEN
        RETURN 'UNSW';
    ELSIF _otype = 'Faculty' THEN
        RETURN _oname;
    ELSIF _otype = 'School' THEN
        RETURN 'School of ' || _oname;
    ELSE
        RETURN null;
    END IF;
        
END
$$ language plpgsql;

-- Q15
CREATE OR REPLACE FUNCTION unitID(partName text) RETURNS integer AS $$
    SELECT 
        o.id
    FROM
        orgunit as o
    WHERE
        o.longname ILIKE '%' || partName || '%';
$$ language sql;


-- Q16
CREATE OR REPLACE FUNCTION facultyOf(_ouid integer) RETURNS integer AS $$
DECLARE
    _parentId integer;
    _oType text;
BEGIN
    -- Base case
    IF _ouid IS NULL THEN
        RETURN NULL;
    END IF;

    SELECT
        ot.name
    INTO
        _oType
    FROM
        orgunittype AS ot
    JOIN
        orgunit AS o
        ON ot.id = o.utype
    WHERE
        o.id = _ouid;

    -- Base case
    IF _oType = 'Faculty' THEN
        RETURN _ouid;
    END IF;

    SELECT 
        owner
    INTO
        _parentId
    FROM
        unitgroups
    WHERE
        member = _ouid;
    
    -- Recursion :O
    RETURN facultyOf(_parentId);
    
END
$$ language plpgsql;
