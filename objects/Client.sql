//------------------------------------Client------------------------------------------------//

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
    Pesel                VARCHAR2(11),

    CONSTRUCTOR FUNCTION ClientObj(
        newId in Number,
        Registration_Address in Address,
        Phone_Number in VARCHAR2,
        First_Name VARCHAR2,
        Last_Name VARCHAR2,
        NIP VARCHAR2,
        Pesel VARCHAR2
    ) RETURN SELF AS RESULT
);

/

CREATE OR REPLACE TYPE BODY ClientObj AS
    CONSTRUCTOR FUNCTION ClientObj(
        newId in Number,
        Registration_Address in Address,
        Phone_Number in VARCHAR2,
        First_Name VARCHAR2,
        Last_Name VARCHAR2,
        NIP VARCHAR2,
        Pesel VARCHAR2
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.PersonId := newId;
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