//------------------------------------PRIVATE PERSON------------------------------------------------//
CREATE OR REPLACE TYPE PrivatePerson UNDER Entity
(
    First_Name VARCHAR2(20),
    Last_Name  VARCHAR2(50),
    Pesel      VARCHAR2(11),
    CONSTRUCTOR FUNCTION PrivatePerson(
        Contract_Start_Date IN DATE,
        Contract_End_Date IN DATE,
        Registration_Address IN Address,
        Phone_number IN VARCHAR2,
        First_Name IN VARCHAR2,
        Last_Name IN VARCHAR2,
        Pesel IN VARCHAR2,
        Present_Services IN ServiceList,
        Invoices IN InvoiceList
    ) RETURN SELF AS RESULT
) INSTANTIABLE NOT FINAL;
/

CREATE OR REPLACE TYPE BODY PrivatePerson AS
    CONSTRUCTOR FUNCTION PrivatePerson(
        Contract_Start_Date IN DATE,
        Contract_End_Date IN DATE,
        Registration_Address IN Address,
        Phone_number IN VARCHAR2,
        First_Name IN VARCHAR2,
        Last_Name IN VARCHAR2,
        Pesel IN VARCHAR2,
        Present_Services IN ServiceList,
        Invoices IN InvoiceList
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.First_Name := First_Name;
        SELF.Last_Name := Last_Name;
        SELF.Pesel := Pesel;
        SELF.Present_Services := Present_Services;
        SELF.Invoices := Invoices;
        SELF.Contract_Start_Date := Contract_Start_Date;
        SELF.Contract_End_Date := Contract_End_Date;
        SELF.Registration_Address := Registration_Address;
        SELF.Phone_number := Phone_number;
        RETURN;
    END;
END;
/
