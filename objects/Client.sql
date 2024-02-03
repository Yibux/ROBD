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
    Invoices             InvoiceList,

    CONSTRUCTOR FUNCTION ClientObj(
        p_PersonId NUMBER,
        p_Contract_Start_Date DATE,
        p_Contract_End_Date DATE,
        p_Registration_Address Address,
        p_Phone_Number VARCHAR(12),
        p_First_Name VARCHAR(20),
        p_Last_Name VARCHAR(40),
        p_NIP VARCHAR(11),
        p_Invoices InvoiceList
    ) RETURN SELF AS RESULT
);

/

CREATE OR REPLACE TYPE BODY ClientObj AS
    CONSTRUCTOR FUNCTION ClientObj(
        p_Contract_Start_Date DATE,
        p_Contract_End_Date DATE,
        p_Registration_Address Address,
        p_Phone_Number VARCHAR(12),
        p_First_Name VARCHAR(20),
        p_Last_Name VARCHAR(40),
        p_NIP VARCHAR(11),
        p_Invoices InvoiceList
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.PersonId := PersonSequence.nextval;
        SELF.Contract_Start_Date := p_Contract_Start_Date;
        SELF.Contract_End_Date := p_Contract_End_Date;
        SELF.Registration_Address := p_Registration_Address;
        SELF.Phone_Number := p_Phone_Number;
        SELF.First_Name := p_First_Name;
        SELF.Last_Name := p_Last_Name;
        SELF.NIP := p_NIP;
        SELF.Invoices := p_Invoices;
        RETURN;
    END;
END;

/