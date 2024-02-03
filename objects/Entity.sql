//------------------------------------ENTITY------------------------------------------------//

CREATE SEQUENCE PersonSequence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TYPE Entity AS OBJECT
(
    PersonId             Number,
    Contract_Start_Date  DATE,
    Contract_End_Date    DATE,
    Registration_Address Address,
    Phone_Number         VARCHAR(12),
    Present_Services     ServiceList,
    Invoices             InvoiceList,

    CONSTRUCTOR FUNCTION Entity(
        Contract_Start_Date IN DATE,
        Contract_End_Date IN DATE,
        Registration_Address IN Address,
        Phone_Number IN VARCHAR2
    ) RETURN SELF AS RESULT

) INSTANTIABLE NOT FINAL;

/

CREATE OR REPLACE TYPE BODY Entity AS

    CONSTRUCTOR FUNCTION Entity(
        Contract_Start_Date IN DATE,
        Contract_End_Date IN DATE,
        Registration_Address IN Address,
        Phone_Number IN VARCHAR2
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.PersonId := PersonSequence.nextval;
        SELF.Contract_Start_Date := Contract_Start_Date;
        SELF.Contract_End_Date := Contract_End_Date;
        SELF.Registration_Address := Registration_Address;
        SELF.Phone_Number := Phone_Number;
        SELF.Present_Services := ServiceList();
        SELF.Invoices := InvoiceList();
        RETURN;
    END;

END;

/