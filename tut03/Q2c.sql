CREATE TABLE teacher (
    staffNo integer PRIMARY KEY
);

CREATE TABLE subject (
    subjCode char(8) PRIMARY KEY,
    teacher integer REFERENCES teacher (staffNo),
    semester char(4)
);
