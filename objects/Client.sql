//------------------------------------Client------------------------------------------------//

CREATE SEQUENCE PersonSequence START WITH 1 INCREMENT BY 1;
/

CREATE OR REPLACE TYPE ClientObj AS OBJECT
(
    PersonId             Number,
    Registration_Address Address,
    Phone_Number         VARCHAR2(12),
    First_Name           VARCHAR2(20),
    Last_Name            VARCHAR2(40),
    NIP                  VARCHAR2(11),
    Pesel                VARCHAR2(11),

    CONSTRUCTOR FUNCTION ClientObj(
        Registration_Address IN Address,
        Phone_Number IN VARCHAR2,
        First_Name IN VARCHAR2,
        Last_Name IN VARCHAR2,
        NIP IN VARCHAR2,
        Pesel IN VARCHAR2
    ) RETURN SELF AS RESULT
);

/

CREATE OR REPLACE TYPE BODY ClientObj AS
    CONSTRUCTOR FUNCTION ClientObj(
        Registration_Address IN Address,
        Phone_Number IN VARCHAR2,
        First_Name IN VARCHAR2,
        Last_Name IN VARCHAR2,
        NIP IN VARCHAR2,
        Pesel IN VARCHAR2
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.PersonId := PersonSequence.nextval;
        SELF.Registration_Address := Registration_Address;
        SELF.Phone_Number := Phone_Number;
        SELF.First_Name := First_Name;
        SELF.Last_Name := Last_Name;
        SELF.NIP := NIP;
        SELF.Pesel := Pesel;
        RETURN;
    END;
END;

/
create table ClientsTable Of ClientObj (PRIMARY KEY (PersonId));