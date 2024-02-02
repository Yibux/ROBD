//------------------------------------ENTITY------------------------------------------------//

CREATE OR REPLACE TYPE Entity AS OBJECT
(
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
        SELF.Contract_Start_Date := Contract_Start_Date;
        SELF.Contract_End_Date := Contract_End_Date;
        SELF.Registration_Address := Registration_Address;
        SELF.Phone_Number := Phone_Number;
        SELF.Present_Services := ServiceList(); -- Initialize the nested table
        SELF.Invoices := InvoiceList(); -- Initialize the nested table
        RETURN;
    END;

END;

/
