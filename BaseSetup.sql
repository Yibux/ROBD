//--------------------------------ADDRESS----------------------------------------------------//

CREATE OR REPLACE TYPE Address AS OBJECT
(
    Street      VARCHAR2(40),
    City        VARCHAR2(40),
    Province    VARCHAR2(40),
    Postal_Code VARCHAR2(7),
    Country     VARCHAR2(50),
    CONSTRUCTOR FUNCTION Address(
        Street IN VARCHAR2,
        City IN VARCHAR2,
        Province IN VARCHAR2,
        Postal_Code IN VARCHAR2,
        Country IN VARCHAR2
    ) RETURN SELF AS RESULT
);
/

CREATE OR REPLACE TYPE BODY Address AS
    CONSTRUCTOR FUNCTION Address(
        Street IN VARCHAR2,
        City IN VARCHAR2,
        Province IN VARCHAR2,
        Postal_Code IN VARCHAR2,
        Country IN VARCHAR2
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.Street := Street;
        SELF.City := City;
        SELF.Province := Province;
        SELF.Postal_Code := Postal_Code;
        SELF.Country := Country;
        RETURN;
    END;
END;
/

//--------------------------------SERVICE----------------------------------------------------//

CREATE OR REPLACE TYPE Service AS OBJECT
(
    Description VARCHAR2(100),
    Price       NUMBER,
    CONSTRUCTOR FUNCTION Service(
        Description IN VARCHAR2,
        Price IN NUMBER
    ) RETURN SELF AS RESULT
);

/

CREATE OR REPLACE TYPE BODY Service AS
    CONSTRUCTOR FUNCTION Service(
        Description IN VARCHAR2,
        Price IN NUMBER
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.Description := Description;
        SELF.Price := Price;
        RETURN;
    END;
END;

/

-- CREATE OR REPLACE TYPE ServiceList AS VARRAY(10) OF Service;
CREATE OR REPLACE TYPE ServiceList AS TABLE OF Service;
/

//--------------------------------------INVOICE----------------------------------------------//

CREATE OR REPLACE TYPE Invoice AS OBJECT
(
    IssueDate DATE,
    Cost      NUMBER,
    Services  ServiceList,
    CONSTRUCTOR FUNCTION Invoice(
        IssueDate IN DATE,
        Cost IN NUMBER,
        Services IN ServiceList
    ) RETURN SELF AS RESULT
);

CREATE OR REPLACE TYPE BODY Invoice AS
    CONSTRUCTOR FUNCTION Invoice(
        IssueDate IN DATE,
        Cost IN NUMBER,
        Services IN ServiceList
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.IssueDate := IssueDate;
        SELF.Cost := Cost;
        SELF.Services := Services;
        RETURN;
    END;
END;
/

CREATE OR REPLACE TYPE InvoiceList AS VARRAY(12) OF Invoice;
-- CREATE OR REPLACE TYPE InvoiceList AS TABLE OF Invoice;
/

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
/

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

//--------------------------------EMPLOYEE----------------------------------------//


CREATE SEQUENCE EmployeeSequence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TYPE Employee UNDER PrivatePerson(
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
        Salary IN NUMBER,
        EmploymentType IN VARCHAR2
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.PERSONID := EmployeeSequence.nextval;
        SELF.Contract_Start_Date := Contract_Start_Date;
        SELF.Contract_End_Date := Contract_End_Date;
        SELF.Registration_Address := Registration_Address;
        SELF.Phone_number := Phone_number;
        SELF.First_Name := First_Name;
        SELF.Last_Name := Last_Name;
        SELF.Pesel := Pesel;
        SELF.Present_Services := ServiceList();
        SELF.Invoices := InvoiceList();
        SELF.Salary := Salary;
        SELF.EmploymentType := EmploymentType;

        RETURN;
    END;

END;
/

CREATE OR REPLACE TYPE Employee_List AS VARRAY(15) OF Employee;



CREATE TABLE EmployeesTable OF Employee (PRIMARY KEY (PersonId))
nested table Present_Services store as services;

/


//--------------------------------BRANCH----------------------------------------------------//
/

CREATE SEQUENCE BranchSequence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TYPE Branch AS OBJECT (
    BranchId Number,
    Branch_address Address,
    Employees Employee_List,
    MEMBER PROCEDURE AddEmployee(employee2 IN Employee),

    CONSTRUCTOR FUNCTION Branch(
        Branch_address IN Address
    ) RETURN SELF AS RESULT

);

/


CREATE OR REPLACE TYPE BODY Branch AS
    CONSTRUCTOR FUNCTION Branch(
        Branch_address IN Address
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.BranchId := BranchSequence.nextval;
        SELF.Branch_address := Branch_address;
        SELF.Employees := Employee_List();
        RETURN;
    END;

     MEMBER PROCEDURE AddEmployee(employee2 IN Employee) IS
        EMPLOYEE_EXIST_EXCEPTION EXCEPTION;
        emp EMPLOYEE;
    BEGIN
        Begin
            SELECT VALUE(e) INTO emp
            FROM EmployeesTable e
            WHERE e.pesel = employee2.PESEL and ROWNUM <= 1;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            emp := NULL;
        END;

        IF emp IS NOT NULL THEN
            RAISE EMPLOYEE_EXIST_EXCEPTION;
        end if;

        INSERT INTO EMPLOYEESTABLE VALUES (employee2);

        COMMIT;

        SELF.Employees.EXTEND;
        SELF.Employees(SELF.Employees.LAST) := employee2;

        EXCEPTION
        WHEN EMPLOYEE_EXIST_EXCEPTION THEN
            RAISE_APPLICATION_ERROR(-20005, 'Employee exists');
    END;
END;
/

CREATE TABLE BranchTable OF Branch (PRIMARY KEY (BranchId));
/


//-------------------------------------ADDING EMPLOYEES------------------------------------//
-- SET SERVEROUTPUT ON;
/

DECLARE
    branch1 Branch;
    employee1 Employee;
BEGIN
--     SELECT VALUE(e) INTO employee1
--     FROM EmployeesTable e
--     WHERE ROWNUM <= 1;
     employee1 := Employee(
        SYSDATE, -- Contract_Start_Date
        SYSDATE + 365, -- Contract_End_Date
        Address('EmployeeAddress', 'City', 'Country', '123', '123'), -- Registration_Address
        '123-456-7890', -- Phone_number
        'John', -- First_Name
        'Doe', -- Last_Name
        '12345678902', -- Pesel
        5000, -- Salary
        'Full Time' -- EmploymentType
    );


    branch1 := Branch(Address('BranchAddress', 'City', 'Country', '123', '123'));

    branch1.AddEmployee(employee1);
--
    INSERT INTO BranchTable VALUES (branch1);

    COMMIT;
END;
/

declare
    abc Employee_List := Employee_List();
Begin
    SELECT VALUE(e) BULK COLLECT into abc
    FROM BranchTable bt,
         TABLE(bt.Employees) e;


    for i in 1..abc.Count loop
        DBMS_OUTPUT.PUT_LINE(abc(i).PESEL);
    end loop;

end;

--todo: operatorzy, tabela operatorów,


