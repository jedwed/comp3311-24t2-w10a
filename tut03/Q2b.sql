CREATE TABLE teacher (
    staffNo integer PRIMARY KEY
);

CREATE TABLE subject (
    subjCode char(8),
    PRIMARY KEY (subjCode)
);

CREATE TABLE teaches (
    teacher integer REFERENCES teacher (staffNo),
    subject char(8) REFERENCES subject (subjCode),
    semester char(4),
    PRIMARY KEY (teacher, subject)
);
