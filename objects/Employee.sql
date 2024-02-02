//--------------------------------EMPLOYEE----------------------------------------//

CREATE OR REPLACE TYPE Employee UNDER PrivatePerson

(
    Salary NUMBER,
    EmploymentType VARCHAR2(50),

    CONSTRUCTOR FUNCTION Employee
    (
        Contract_Start_Date IN DATE,
        Contract_End_Date IN DATE,
        Registration_Address IN Address,
        Phone_number IN VARCHAR2,
        First_Name IN VARCHAR2,
        Last_Name IN VARCHAR2,
        Pesel IN VARCHAR2,
        Present_Services IN ServiceList,
        Invoices IN InvoiceList,
        Salary IN NUMBER,
        EmploymentType IN VARCHAR2
    ) RETURN SELF AS RESULT
);

/
CREATE OR REPLACE TYPE BODY Employee AS

    CONSTRUCTOR FUNCTION Employee
    (
        Contract_Start_Date IN DATE,
        Contract_End_Date IN DATE,
        Registration_Address IN Address,
        Phone_number IN VARCHAR2,
        First_Name IN VARCHAR2,
        Last_Name IN VARCHAR2,
        Pesel IN VARCHAR2,
        Present_Services IN ServiceList,
        Invoices IN InvoiceList,
        Salary IN NUMBER,
        EmploymentType IN VARCHAR2
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.Contract_Start_Date := Contract_Start_Date;
        SELF.Contract_End_Date := Contract_End_Date;
        SELF.Registration_Address := Registration_Address;
        SELF.Phone_number := Phone_number;
        SELF.First_Name := First_Name;
        SELF.Last_Name := Last_Name;
        SELF.Pesel := Pesel;
        SELF.Present_Services := Present_Services;
        SELF.Invoices := Invoices;
        SELF.Salary := Salary;
        SELF.EmploymentType := EmploymentType;

        RETURN;
    END;

END;
/

