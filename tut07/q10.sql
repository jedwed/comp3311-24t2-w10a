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
