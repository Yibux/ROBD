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

CREATE SEQUENCE PersonSequence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TYPE ClientObj AS OBJECT
(
    PersonId             NUMBER,
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
        SELF.PersonId := PeronSequence.nextval;
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


SELECT * FROM ServiceTable;
SELECT * FROM ClientsTable;



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
    CloseOrderDate DATE,

    CONSTRUCTOR FUNCTION ClientOrder(
        SingleClient IN REF ClientObj,
        SingleService IN REF SERVICE,
        SingleEmployee IN REF EMPLOYEE,
        OrderDate IN DATE
    ) RETURN SELF AS RESULT,
    MEMBER PROCEDURE CloseOrder
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
        SELF.CLOSEORDERDATE := null;
        RETURN;
    END;

    MEMBER PROCEDURE CloseOrder IS
    BEGIN
        SELF.CloseOrderDate := SYSDATE;
    END;
END;
/

Create table ClientsOrdersTable of CLIENTORDER (OrderId PRIMARY KEY );

//--------------------------------BRANCH----------------------------------------------------//
Create type EmployeeList as table of Employee;

CREATE SEQUENCE BranchSequence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TYPE Branch AS OBJECT (
    BranchId Number,
    Branch_address Address,
    Employees EmployeeList,
    CONSTRUCTOR FUNCTION Branch(
        Branch_address IN Address
    ) RETURN SELF AS RESULT
);


CREATE OR REPLACE TYPE BODY Branch AS
    CONSTRUCTOR FUNCTION Branch(

        Branch_address IN Address

    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.BRANCHID := BranchSequence.nextval;
        SELF.Branch_address := Branch_address;
        SELF.Employees := EmployeeList();
        RETURN;
    END;
END;
/
create table BranchTable of Branch (BranchId PRIMARY KEY )
nested table Employees store as EmployeeListTable_nested;
/
--
INSERT INTO EmployeesTable VALUES (Employee(SYSDATE, SYSDATE + 365, Address('Street6', 'City6', 'Province6', '11111', 'Country6'), '1111111111', 'John', 'Smith', '11111111111', 5000, 'Full Time'));
INSERT INTO EmployeesTable VALUES (Employee(SYSDATE, SYSDATE + 365, Address('Street7', 'City7', 'Province7', '22222', 'Country7'), '2222222222', 'Jane', 'Doe', '22222222222', 6000, 'Part Time'));

INSERT INTO BranchTable VALUES (
    Branch(
        Address('Street8', 'City8', 'Province8', '33333', 'Country8'),
        EmployeeList(Employee(SYSDATE, SYSDATE + 365, Address('Street9', 'City9', 'Province9', '44444', 'Country9'), '3333333333', 'Alice', 'Johnson', '33333333333', 7000, 'Full Time')))
);
--
INSERT INTO BranchTable VALUES (
    Branch(
        Address('Street10', 'City10', 'Province10', '55555', 'Country10'),
        EmployeeList(Employee(SYSDATE, SYSDATE + 365, Address('Street11', 'City11', 'Province11', '66666', 'Country11'), '4444444444', 'Bob', 'Miller', '44444444444', 8000, 'Part Time'))
    )
);

--
INSERT INTO ClientsOrdersTable VALUES (
    ClientOrder(
        (SELECT REF(c) FROM ClientsTable c WHERE ROWNUM = 1),
        (SELECT REF(s) FROM ServiceTable s WHERE ROWNUM = 1),
        (SELECT REF(e) FROM EmployeesTable e WHERE ROWNUM = 1),
        SYSDATE
    )
);

SELECT * FROM ServiceTable;
SELECT * FROM ClientsTable;
SELECT * FROM InvoiceTables;
SELECT * FROM EmployeesTable;
SELECT * FROM ClientsOrdersTable;

DECLARE
    client_ref REF ClientObj;
    service_ref REF SERVICE;
    employee_ref REF EMPLOYEE;
    client_id NUMBER := 83;
    invoice_ref REF Invoice;
    order_ref REF ClientOrder;
    order_obj ClientOrder;
    order_date DATE;
BEGIN

--     SELECT REF(c) INTO client_ref FROM ClientsTable c WHERE PERSONID = client_id;
--     SELECT REF(s) INTO service_ref FROM ServiceTable s WHERE SERVICEID = 16;
--     SELECT REF(e) INTO employee_ref FROM EmployeesTable e WHERE EMPLOYEEID = 47;
--     order_date := SYSDATE;
-- --
--     ORDERPACKAGE.CREATEORDER(client_ref,service_ref,employee_ref);

--     ORDERPACKAGE.SHOWORDERSBYCLIENT(client_id);
--     ORDERPACKAGE.SHOWORDERSBYEMPLOYEE(47);

--        INVOICEPACKAGE.GENERATEINVOICE(client_id);

        SELECT REF(c) INTO invoice_ref FROM INVOICETABLES c WHERE INVOICEID = 81;
       INVOICEPACKAGE.SHOWSERVICES(invoice_ref);
-- -- --
-- -- --
--         CLIENTPACKAGE.GETACTIVESERVICES(client_id);
--
       SELECT VALUE(e) INTO order_obj FROM ClientsOrdersTable e WHERE orderid = 145;
        order_obj.CLOSEORDER();
        UPDATE ClientsOrdersTable e SET e = order_obj WHERE orderid = 145;


        DBMS_OUTPUT.PUT_LINE('---------------------------------');

        CLIENTPACKAGE.GETACTIVESERVICES(client_id);


        INVOICEPACKAGE.SHOWSERVICES(invoice_ref);

END;



--todo: package, generowanie faktur, dodawanie pracowników, show ordersbyemp/client, getclientbypesel

