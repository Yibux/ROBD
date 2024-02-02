//------------------------------------ENTITY------------------------------------------------//

CREATE OR REPLACE TYPE Entity AS OBJECT
(
    Contract_Start_Date  DATE,
    Contract_End_Date    DATE,
    Registration_Address Address,
    Phone_Number         VARCHAR(12),
    Services             ServiceList,
    Invoices             InvoiceList,

    CONSTRUCTOR FUNCTION Entity(
        Contract_Start_Date IN DATE,
        Contract_End_Date IN DATE,
        Registration_Address IN Address,
        Phone_Number IN VARCHAR2
    ) RETURN SELF AS RESULT,

    MEMBER PROCEDURE addService(service IN Service),
    MEMBER PROCEDURE removeService(service IN Service),
    MEMBER PROCEDURE addInvoice(invoice IN Invoice)
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
        RETURN;
    END;

    MEMBER PROCEDURE addService(service IN Service) IS
    BEGIN
        FOR i IN 1..SELF.Services.COUNT
            LOOP
                IF SELF.Services(i).compareService(service) THEN
                    RAISE_APPLICATION_ERROR(-20001, 'Service already exists in the list');
                END IF;
            END LOOP;
        SELF.Services.EXTEND;
        SELF.Services(SELF.Services.COUNT) := service;
    END;

    MEMBER PROCEDURE removeService(service IN Service) IS
    BEGIN
        FOR i IN 1..SELF.Services.COUNT
            LOOP
                IF SELF.Services(i).compareService(service) THEN
                    SELF.Services.DELETE(i);
                    RETURN;
                END IF;
            END LOOP;
        RAISE_APPLICATION_ERROR(-20002, 'Service does not exist in the list');
    END;

    MEMBER PROCEDURE addInvoice(invoice IN Invoice) IS
    BEGIN
        FOR i IN 1..SELF.Invoices.COUNT
            LOOP
                IF SELF.Invoices(i).compareInvoice(invoice) THEN
                    RAISE_APPLICATION_ERROR(-20003, 'Invoice already exists in the list');
                END IF;
            END LOOP;
        SELF.Invoices.EXTEND;
        SELF.Invoices(SELF.Invoices.COUNT) := invoice;
    END;

END;

/
