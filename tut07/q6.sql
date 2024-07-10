CREATE TABLE R(
    a int, 
    b int, 
    c text
    -- we want primary key (a, b)
);


CREATE OR REPLACE FUNCTION check_primary_key() RETURNS trigger AS $$
BEGIN
    IF NEW.a IS NULL OR NEW.b IS NULL THEN
        RAISE EXCEPTION 'no no null primary key';
    END IF;

    -- Uniqueness

    -- Edge case: if we try to update a tuple without changing the primary key
    IF OLD.a = NEW.a AND OLD.b = NEW.b THEN
        RETURN NEW;
    END IF;

    PERFORM 
        *
    FROM
        R
    WHERE
        a = NEW.a AND b = NEW.b;

    IF found THEN
        RAISE EXCEPTION 'ruh roh primary key already exists';
    END IF; 

    RETURN NEW;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER primary_key_constraint
    BEFORE INSERT OR UPDATE
    ON R
    FOR EACH ROW
    EXECUTE FUNCTION check_primary_key();
