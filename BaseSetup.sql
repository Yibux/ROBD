//--------------------------------SERVICE----------------------------------------------------//
CREATE SEQUENCE ServiceSequence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TYPE Service AS OBJECT
(
    ServiceId Number,
    Description VARCHAR2(100),
    Price NUMBER,
    CONSTRUCTOR FUNCTION Service
    (
        Description IN VARCHAR2,
        Price IN NUMBER
    ) RETURN SELF AS RESULT
);

/

CREATE OR REPLACE TYPE BODY Service AS
    CONSTRUCTOR FUNCTION Service
    (
        Description IN VARCHAR2,
        Price IN NUMBER
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.ServiceId := ServiceSequence.nextval;
        SELF.Description := Description;
        SELF.Price := Price;
        RETURN;
    END;
END;

/

create table ServiceTable of Service (PRIMARY KEY (ServiceId));

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


//------------------------------------Client------------------------------------------------//

CREATE SEQUENCE ClientSequence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TYPE ClientObj AS OBJECT
(
    ClientId             NUMBER,
    Contract_Start_Date  DATE,
    Contract_End_Date    DATE,
    Registration_Address Address,
    Phone_Number         VARCHAR2(12),
    First_Name           VARCHAR2(20),
    Last_Name            VARCHAR2(40),
    NIP                  VARCHAR2(11),
    Pesel                VARCHAR2(11),

    CONSTRUCTOR FUNCTION ClientObj(
        Contract_Start_Date in DATE,
        Contract_End_Date in DATE,
        Registration_Address in Address,
        Phone_Number in VARCHAR2,
        First_Name VARCHAR2,
        Last_Name VARCHAR2,
        NIP VARCHAR2,
        Pesel VARCHAR2
    ) RETURN SELF AS RESULT
);

/

CREATE OR REPLACE TYPE BODY ClientObj AS
    CONSTRUCTOR FUNCTION ClientObj(
        Contract_Start_Date in DATE,
        Contract_End_Date in DATE,
        Registration_Address in Address,
        Phone_Number in VARCHAR2,
        First_Name VARCHAR2,
        Last_Name VARCHAR2,
        NIP VARCHAR2,
        Pesel VARCHAR2
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.ClientId := ClientSequence.nextval;
        SELF.Contract_Start_Date := Contract_Start_Date;
        SELF.Contract_End_Date := Contract_End_Date;
        SELF.Registration_Address := Registration_Address;
        SELF.Phone_Number := Phone_Number;
        SELF.First_Name := First_Name;
        SELF.Last_Name := Last_Name;
        SELF.NIP := NIP;
        SELF.Pesel := Pesel;
        RETURN;
    END;
END;

/

create table ClientsTable Of ClientObj (PRIMARY KEY (PersonId));


//--------------------------------------INVOICE----------------------------------------------//
CREATE SEQUENCE InvoiceSequence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TYPE Invoice AS OBJECT
(
    InvoiceId Number,
    IssueDate DATE,
    Cost NUMBER,
    SingleClient REF ClientObj,
    CONSTRUCTOR FUNCTION Invoice
    (
        IssueDate IN DATE,
        Cost IN NUMBER,
        SingleClient in ref ClientObj
    ) RETURN SELF AS RESULT
);

CREATE OR REPLACE TYPE BODY Invoice AS
    CONSTRUCTOR FUNCTION Invoice
    (
        IssueDate IN DATE,
        Cost IN NUMBER,
        SingleClient in ref ClientObj
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.InvoiceId := InvoiceSequence.nextval;
        SELF.IssueDate := IssueDate;
        SELF.Cost := Cost;
        SELF.SingleClient := SingleClient;
        RETURN;
    END;
END;
/

create table InvoiceTables of INVOICE(InvoiceId PRIMARY KEY);
/

INSERT INTO ServiceTable VALUES (Service('Service1', 50));
INSERT INTO ServiceTable VALUES (Service('Service2', 75));
INSERT INTO ServiceTable VALUES (Service('Service3', 100));

INSERT INTO ClientsTable VALUES (ClientObj(SYSDATE, SYSDATE + 365, Address('Street4', 'City4', 'Province4', '98765', 'Country4'), '1234567890', 'John', 'Doe', '12345678901', '98765432101'));
INSERT INTO ClientsTable VALUES (ClientObj(SYSDATE, SYSDATE + 365, Address('Street5', 'City5', 'Province5', '54321', 'Country5'), '0987654321', 'Jane', 'Smith', '98765432102', '12345678902'));

INSERT INTO InvoiceTables VALUES (Invoice(SYSDATE, 200, (SELECT REF(c) FROM ClientsTable c WHERE c.ClientId = 1)));
INSERT INTO InvoiceTables VALUES (Invoice(SYSDATE, 150, (SELECT REF(c) FROM ClientsTable c WHERE c.ClientId = 15)));

SELECT * FROM ServiceTable;
SELECT * FROM ClientsTable;
SELECT * FROM InvoiceTables;


SELECT i.InvoiceId, i.IssueDate, i.Cost,
       DEREF(i.SingleClient).ClientId as ClientId,
       DEREF(i.SingleClient).First_Name as Client_First_Name,
       DEREF(i.SingleClient).Last_Name as Client_Last_Name
FROM InvoiceTables i;


//--------------------------------EMPLOYEE----------------------------------------//
CREATE SEQUENCE EmployeeSequence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TYPE Employee as OBJECT (
    EmployeeId           Number,
    Contract_Start_Date  DATE,
    Contract_End_Date    DATE,
    Registration_Address Address,
    Phone_Number         VARCHAR2(12),
    First_Name           VARCHAR2(20),
    Last_Name            VARCHAR2(40),
    Pesel                VARCHAR2(11),
    Salary               NUMBER,
    EmploymentType       VARCHAR2(50),

    CONSTRUCTOR FUNCTION Employee (
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

    CONSTRUCTOR FUNCTION Employee(
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
        SELF.EMPLOYEEID := EMPLOYEESEQUENCE.nextval;
        SELF.Contract_Start_Date := Contract_Start_Date;
        SELF.Contract_End_Date := Contract_End_Date;
        SELF.Registration_Address := Registration_Address;
        SELF.Phone_number := Phone_number;
        SELF.First_Name := First_Name;
        SELF.Last_Name := Last_Name;
        SELF.Pesel := Pesel;
        SELF.Salary := Salary;
        SELF.EmploymentType := EmploymentType;

        RETURN;
    END;

END;
/

create table EmployeesTable of Employee (EmployeeId PRIMARY KEY );


//---------------------------ORDER----------------------------//
CREATE SEQUENCE OrderSequence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TYPE ClientOrder AS OBJECT (
    OrderId NUMBER,
    SingleClient REF ClientObj,
    SingleService REF SERVICE,
    SingleEmployee REF EMPLOYEE,
    OrderDate DATE,

    CONSTRUCTOR FUNCTION ClientOrder(
        SingleClient IN REF ClientObj,
        SingleService IN REF SERVICE,
        SingleEmployee IN REF EMPLOYEE,
        OrderDate IN DATE
    ) RETURN SELF AS RESULT
);
/

CREATE OR REPLACE TYPE BODY ClientOrder AS
    CONSTRUCTOR FUNCTION ClientOrder(
        SingleClient in REF ClientObj,
        SingleService in REF SERVICE,
        SingleEmployee in REF EMPLOYEE,
        OrderDate in Date
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.OrderId := OrderSequence.nextval;
        SELF.SingleClient := SingleClient;
        SELF.SingleService := SingleService;
        SELF.SingleEmployee := SingleEmployee;
        SELF.OrderDate := OrderDate;
        RETURN;
    END;
END;
/

Create table ClientsOrdersTable of CLIENTORDER (OrderId PRIMARY KEY );
/

//--------------------------------BRANCH----------------------------------------------------//
Create type EmployeeList as table of Employee;
/
CREATE SEQUENCE BranchSequence START WITH 1 INCREMENT BY 1;
/
CREATE OR REPLACE TYPE Branch AS OBJECT (
    BranchId Number,
    Branch_address Address,
    Employees EmployeeList,
    MEMBER PROCEDURE AddEmployee(employee2 IN Employee),
    CONSTRUCTOR FUNCTION Branch(
        Branch_address IN Address,
        Employees IN EmployeeList
    ) RETURN SELF AS RESULT
);
/

CREATE OR REPLACE TYPE BODY Branch AS
    CONSTRUCTOR FUNCTION Branch(

        Branch_address IN Address,
        Employees IN EmployeeList

    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.BRANCHID := BranchSequence.nextval;
        SELF.Branch_address := Branch_address;
        SELF.Employees := Employees;
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

create table BranchTable of Branch (BranchId PRIMARY KEY )
nested table Employees store as EmployeeListTable_nested;
/

INSERT INTO EmployeesTable VALUES (Employee(SYSDATE, SYSDATE + 365, Address('Street6', 'City6', 'Province6', '11111', 'Country6'), '1111111111', 'John', 'Smith', '11111111111', 5000, 'Full Time'));
INSERT INTO EmployeesTable VALUES (Employee(SYSDATE, SYSDATE + 365, Address('Street7', 'City7', 'Province7', '22222', 'Country7'), '2222222222', 'Jane', 'Doe', '22222222222', 6000, 'Part Time'));

INSERT INTO BranchTable VALUES (
    Branch(
        Address('Street8', 'City8', 'Province8', '33333', 'Country8'),
        EmployeeList(Employee(SYSDATE, SYSDATE + 365, Address('Street9', 'City9', 'Province9', '44444', 'Country9'), '3333333333', 'Alice', 'Johnson', '33333333333', 7000, 'Full Time')))
);

INSERT INTO BranchTable VALUES (
    Branch(
        Address('Street10', 'City10', 'Province10', '55555', 'Country10'),
        EmployeeList(Employee(SYSDATE, SYSDATE + 365, Address('Street11', 'City11', 'Province11', '66666', 'Country11'), '4444444444', 'Bob', 'Miller', '44444444444', 8000, 'Part Time'))
    )
);




-- Dodaj kilka zamówień
INSERT INTO ClientsOrdersTable VALUES (
    ClientOrder(
        (SELECT REF(c) FROM ClientsTable c WHERE c.ClientId = 29),
        (SELECT REF(s) FROM ServiceTable s WHERE s.ServiceId = 1),
        (SELECT REF(e) FROM EmployeesTable e WHERE e.EmployeeId = 1),
        SYSDATE
    )
);

INSERT INTO ClientsOrdersTable VALUES (
    ClientOrder(
        (SELECT REF(c) FROM ClientsTable c WHERE c.ClientId = 2),
        (SELECT REF(s) FROM ServiceTable s WHERE s.ServiceId = 2),
        (SELECT REF(e) FROM EmployeesTable e WHERE e.EmployeeId = 2),
        SYSDATE + 1
    )
);

SELECT * FROM ServiceTable;
SELECT * FROM ClientsTable;
SELECT * FROM InvoiceTables;
SELECT * FROM EmployeesTable;
SELECT * FROM ClientsOrdersTable;

SELECT
    o.OrderId,
    DEREF(o.SingleClient).ClientId AS ClientId,
    DEREF(o.SingleClient).Contract_Start_Date AS Client_Contract_Start_Date,
    DEREF(o.SingleClient).Contract_End_Date AS Client_Contract_End_Date,
    DEREF(o.SingleClient).Registration_Address.Street AS Client_Street,
    DEREF(o.SingleClient).Registration_Address.City AS Client_City,
    DEREF(o.SingleClient).Registration_Address.Province AS Client_Province,
    DEREF(o.SingleClient).Registration_Address.Postal_Code AS Client_Postal_Code,
    DEREF(o.SingleClient).Registration_Address.Country AS Client_Country,
    DEREF(o.SingleClient).Phone_Number AS Client_Phone_Number,
    DEREF(o.SingleClient).First_Name AS Client_First_Name,
    DEREF(o.SingleClient).Last_Name AS Client_Last_Name,
    DEREF(o.SingleClient).NIP AS Client_NIP,
    DEREF(o.SingleClient).Pesel AS Client_Pesel,
    o.SingleService.ServiceId AS ServiceId,
    o.SingleService.Description AS Service_Description,
    o.SingleService.Price AS Service_Price,
    DEREF(o.SingleEmployee).EmployeeId AS EmployeeId,
    DEREF(o.SingleEmployee).Contract_Start_Date AS Employee_Contract_Start_Date,
    DEREF(o.SingleEmployee).Contract_End_Date AS Employee_Contract_End_Date,
    DEREF(o.SingleEmployee).Registration_Address.Street AS Employee_Street,
    DEREF(o.SingleEmployee).Registration_Address.City AS Employee_City,
    DEREF(o.SingleEmployee).Registration_Address.Province AS Employee_Province,
    DEREF(o.SingleEmployee).Registration_Address.Postal_Code AS Employee_Postal_Code,
    DEREF(o.SingleEmployee).Registration_Address.Country AS Employee_Country,
    DEREF(o.SingleEmployee).Phone_Number AS Employee_Phone_Number,
    DEREF(o.SingleEmployee).First_Name AS Employee_First_Name,
    DEREF(o.SingleEmployee).Last_Name AS Employee_Last_Name,
    DEREF(o.SingleEmployee).Pesel AS Employee_Pesel,
    DEREF(o.SingleEmployee).Salary AS Employee_Salary,
    DEREF(o.SingleEmployee).EmploymentType AS Employee_EmploymentType,
    o.OrderDate
FROM ClientsOrdersTable o;


SELECT * FROM BranchTable;

--todo: package, generowanie faktur, dodawanie pracowników, show ordersbyemp/client, getclientbypesel
