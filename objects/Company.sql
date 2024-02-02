//------------------------------------COMPANY------------------------------------------------//


CREATE OR REPLACE TYPE Company UNDER Entity
(
    Company_name                      VARCHAR2(150),
    Tax_identification_number         VARCHAR2(11),
    National_business_registry_number VARCHAR2(17),
    CONSTRUCTOR FUNCTION Company(
        Contract_Start_Date IN DATE,
        Contract_End_Date IN DATE,
        Registration_Address IN Address,
        Phone_number IN VARCHAR2,
        Company_name IN VARCHAR2,
        Tax_identification_number IN VARCHAR2,
        National_business_registry_number IN VARCHAR2,
        Present_Services IN ServiceList,
        Invoices IN InvoiceList
    ) RETURN SELF AS RESULT
);

/



CREATE OR REPLACE TYPE BODY Company AS

    CONSTRUCTOR FUNCTION Company(
        Contract_Start_Date IN DATE,
        Contract_End_Date IN DATE,
        Registration_Address IN Address,
        Phone_number IN VARCHAR2,
        Company_name IN VARCHAR2,
        Tax_identification_number IN VARCHAR2,
        National_business_registry_number IN VARCHAR2,
        Present_Services IN ServiceList,
        Invoices IN InvoiceList
    ) RETURN SELF AS RESULT IS

    BEGIN
        SELF.Company_name := Company_name;
        SELF.Tax_identification_number := Tax_identification_number;
        SELF.National_business_registry_number := National_business_registry_number;
        SELF.Present_Services := Present_Services;
        SELF.Invoices := Invoices;
        SELF.Contract_Start_Date := Contract_Start_Date;
        SELF.Contract_End_Date := Contract_End_Date;
        SELF.Registration_Address := Registration_Address;
        SELF.Phone_number := Phone_number;
        RETURN;

    END;


END;
