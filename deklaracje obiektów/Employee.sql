//--------------------------------EMPLOYEE----------------------------------------//

CREATE OR REPLACE TYPE Employee UNDER PrivatePerson

(
    Salary NUMBER,
    EmploymentType VARCHAR2(50),

    CONSTRUCTOR FUNCTION Employee
    (
        ContractStartDate IN DATE,
        ContractEndDate IN DATE,
        RegistrationAddress IN Address,
        Phone_Number IN VARCHAR2,
        First_Name IN VARCHAR2,
        Last_Name IN VARCHAR2,
        Pesel IN VARCHAR2,
        Services IN ServiceList,
        Invoices IN InvoiceList,
        Salary IN NUMBER,
        EmploymentType IN VARCHAR2
    ) RETURN SELF AS RESULT
);

/

CREATE OR REPLACE TYPE BODY Employee AS

    CONSTRUCTOR FUNCTION Employee
    (
        ContractStartDate IN DATE,
        ContractEndDate IN DATE,
        RegistrationAddress IN Address,
        Phone_Number IN VARCHAR2,
        First_Name IN VARCHAR2,
        Last_Name IN VARCHAR2,
        Pesel IN VARCHAR2,
        Services IN ServiceList,
        Invoices IN InvoiceList,
        Salary IN NUMBER,
        EmploymentType IN VARCHAR2
    ) RETURN SELF AS RESULT IS

    BEGIN
        -- Initialization of additional fields specific to Employee
        SELF.Salary := Salary;
        SELF.EmploymentType := EmploymentType;
        SELF.First_Name := First_Name;
        SELF.Last_Name := Last_Name;
        SELF.Pesel := Pesel;
        SELF.Services := Services;
        SELF.Invoices := Invoices;
        SELF.ContractStartDate := ContractStartDate;
        SELF.ContractEndDate := ContractEndDate;
        SELF.RegistrationAddress := RegistrationAddress;
        SELF.Phone_Number := Phone_Number;

        RETURN;
    END;

END;

/
