CREATE SEQUENCE PersonSequence START WITH 1 INCREMENT BY 1;
/

CREATE OR REPLACE TYPE ClientObj AS OBJECT
(
    PersonId             NUMBER,
    Registration_Address Address,
    Phone_Number         VARCHAR2(12),
    First_Name           VARCHAR2(20),
    Last_Name            VARCHAR2(40),
    NIP                  VARCHAR2(11),
    Pesel                VARCHAR2(11)
);
/

create table ClientsTable Of ClientObj (PRIMARY KEY (PersonId));
/