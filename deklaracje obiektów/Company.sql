//------------------------------------COMPANY------------------------------------------------//


CREATE OR REPLACE TYPE Company UNDER Entity

    (

    Company_name VARCHAR2(150),

    Tax_identification_number VARCHAR2(11),

    National_business_registry_number VARCHAR2(17) CONSTRUCTOR FUNCTION Company

    (

        Agreement_start_date IN DATE,
        Agreement_end_date IN DATE,
        Mailing_address IN Address,
        Phone_number IN VARCHAR2,
        Company_name IN VARCHAR2,
        Tax_identification_number IN VARCHAR2,
        National_business_registry_number IN VARCHAR2,
        Services IN Service_List,
        Invoices IN Invoice_List
    ) RETURN SELF AS RESULT

/



CREATE OR REPLACE TYPE BODY Company AS

    CONSTRUCTOR FUNCTION Company(
        Agreement_start_date IN DATE,
        Agreement_end_date IN DATE,
        Mailing_address IN Address,
        Phone_number IN VARCHAR2,
        Company_name IN VARCHAR2,
        Tax_identification_number IN VARCHAR2,
        National_business_registry_number IN VARCHAR2,
        Services IN Service_List,
        Invoices IN Invoice_List
    ) RETURN SELF AS RESULT IS

    BEGIN
        SELF.Company_name := Company_name;
        SELF.Tax_identification_number := Tax_identification_number;
        SELF.National_business_registry_number := National_business_registry_number;
        SELF.Services := Services;
        SELF.Invoices := Invoices;
        SELF.Agreement_start_date := Agreement_start_date;
        SELF.Agreement_end_date := Agreement_end_date;
        SELF.Mailing_address := Mailing_address;
        SELF.Phone_number := Phone_number;
        RETURN;

    END;


END;
