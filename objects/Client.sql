//------------------------------------Client------------------------------------------------//

CREATE SEQUENCE PersonSequence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TYPE ClientObj AS OBJECT
(
    PersonId             Number,
    Contract_Start_Date  DATE,
    Contract_End_Date    DATE,
    Registration_Address Address,
    Phone_Number         VARCHAR(12),
    First_Name           VARCHAR(20),
    Last_Name            VARCHAR(40),
    NIP                  VARCHAR(11),
    Pesel                VARCHAR2(11),

    CONSTRUCTOR FUNCTION ClientObj(
        PersonId NUMBER,
        Contract_Start_Date DATE,
        Contract_End_Date DATE,
        Registration_Address Address,
        Phone_Number VARCHAR(12),
        First_Name VARCHAR(20),
        Last_Name VARCHAR(40),
        NIP VARCHAR(11),
        Pesel VARCHAR2(11)
    ) RETURN SELF AS RESULT
);

/

CREATE OR REPLACE TYPE BODY ClientObj AS
    CONSTRUCTOR FUNCTION ClientObj(
        Contract_Start_Date DATE,
        Contract_End_Date DATE,
        Registration_Address Address,
        Phone_Number VARCHAR(12),
        First_Name VARCHAR(20),
        Last_Name VARCHAR(40),
        NIP VARCHAR(11),
        Pesel VARCHAR2(11)
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.PersonId := PersonSequence.nextval;
        SELF.Contract_Start_Date := Contract_Start_Date;
        SELF.Contract_End_Date := Contract_End_Date;
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