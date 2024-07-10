CREATE TABLE student (
    sid integer,
    name text,
    PRIMARY KEY (sid)
);

CREATE TABLE course (
    code char(8),
    lic text,
    quota integer,
    numStudents integer DEFAULT 0,
    PRIMARY KEY (code)
);

CREATE TABLE enrolment (
    course char(8),
    sid integer,
    PRIMARY KEY (course, sid),
    FOREIGN KEY (course) REFERENCES Course(code),
    FOREIGN KEY (sid) REFERENCES Student(sid)
);

-- sample data for testing
insert into Course values ('COMP1511', 'Jake Renzella', 1000);
insert into Course values ('COMP1531', 'Hayden Smith' , 1000);
insert into Course values ('COMP3311', 'Yuekang Li'   , 1000);

insert into Student values (0, 'John Smith'   );
insert into Student values (1, 'John Doe'     );
insert into Student values (2, 'Daniel Jacobs');


CREATE OR REPLACE FUNCTION insert_num_students() RETURNS trigger AS $$
BEGIN
    -- Increment course's numStudents
    UPDATE 
        course 
    SET
        numStudents = numStudents + 1 
    WHERE
        code = NEW.course;
    RETURN NEW;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_num_students
    AFTER INSERT 
    ON enrolment
    FOR EACH ROW
    EXECUTE FUNCTION insert_num_students();

-- Define ASSERTION to ensure numStudents in each course = number of enrolments for that course

-- CREATE ASSERTION num_students CHECK (
--     -- Check there doesn't exist a single tuple where numStudents != number of enrolments for that course
--     NOT EXISTS (
--         -- Courses where numStudents != number of enrolments
--         SELECT
--             *
--         FROM
--             course AS c
--         WHERE
--             numStudents != (
--                 -- Number of enrolments for the course
--                 SELECT 
--                     COUNT(*)
--                 FROM
--                     enrolments
--                 WHERE
--                     course = c.code
--             )
--     )
-- )
