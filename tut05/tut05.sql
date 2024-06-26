-- Q1
CREATE OR REPLACE FUNCTION sqr(num numeric) RETURNS numeric AS $$
BEGIN
    RETURN num * num; 
END
$$ language plpgsql;

-- Q2
CREATE OR REPLACE FUNCTION spread(input text) RETURNS text AS $$
DECLARE
    result text := '';
BEGIN
    -- Iterate through each character of the input
    FOR i IN 1..LENGTH(input) LOOP
        result := result || SUBSTRING(input, i, 1) || ' ';
    END LOOP;
    return result;

END
$$ language plpgsql;

-- Q3
CREATE OR REPLACE FUNCTION seq(n integer) RETURNS setof integer AS $$
BEGIN
    FOR i IN 1..n LOOP
        RETURN NEXT i;
    END LOOP;
END
$$ language plpgsql;
