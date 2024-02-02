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

CREATE OR REPLACE TYPE InvoiceList AS VARRAY(10) OF Invoice; -- Change the size (10) as needed
/

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
DROP type PrivatePerson;
/
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

drop type Employee;
/

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
drop type Employee_List;
CREATE OR REPLACE TYPE Employee_List AS VARRAY(10) OF Employee;


//--------------------------------BRANCH----------------------------------------------------//
drop type branch;
/

CREATE OR REPLACE TYPE Branch AS OBJECT (

    Branch_address Address,
    Employees Employee_List,
    MEMBER PROCEDURE AddEmployee(Employee IN Employee),

    CONSTRUCTOR FUNCTION Branch(
        Branch_address IN Address,
        Employees IN Employee_List
    ) RETURN SELF AS RESULT

);

/


CREATE OR REPLACE TYPE BODY Branch AS
    CONSTRUCTOR FUNCTION Branch(
        Branch_address IN Address
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.Branch_address := Branch_address;
        SELF.Employees := Employee_List();
        RETURN;
    END;

    MEMBER PROCEDURE AddEmployee(Employee IN Employee) IS
    DECLARE
        isPresent BOOLEAN := FALSE;
    BEGIN
        FOR i IN 1..SELF.Employees.COUNT LOOP
            IF Employee.PESEL = SELF.Employees(i).PESEL THEN
                isPresent := TRUE;
                EXIT;
            END IF;
        END LOOP;
        IF isPresent = FALSE THEN
            SELF.Employees.EXTEND;
            SELF.Employees(SELF.Employees.LAST) := Employee;
        END IF;
    END;
END;
/


/


//-------------------------------------ADDING EMPLOYEES------------------------------------//

DECLARE
    Employee1 Employee := Employee(
        TO_DATE('2022-01-01', 'YYYY-MM-DD'),
        TO_DATE('2022-12-31', 'YYYY-MM-DD'),
        Address('Street1', 'City1', 'Province1', '12345', 'Country1'),
        '12345678901',
        'John',
        'Doe',
        '12345678901',
        null,
        null,
        50000,
        'Full Time'
    );

    Employee2 Employee := Employee(
        TO_DATE('2022-02-01', 'YYYY-MM-DD'),
        TO_DATE('2022-11-30', 'YYYY-MM-DD'),
        Address('Street2', 'City2', 'Province2', '54321', 'Country2'),
        '98765432109',
        'Jane',
        'Smith',
        '98765432109',
        null,
        null,
        60000,
        'Part Time'
    );

    Branch1 Branch := Branch(
        Address('BranchStreet', 'BranchCity', 'BranchProvince', '67890', 'BranchCountry'),
        Employee_List(Employee1)
    );
BEGIN
    Branch1.AddEmployee(Employee2);
END;
/


