//--------------------------------SERVICE----------------------------------------------------//
CREATE SEQUENCE ServiceSequence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TYPE Service AS OBJECT
(
    ServiceId Number,
    Description VARCHAR2(100),
    Price NUMBER
);
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
    Registration_Address Address,
    Phone_Number         VARCHAR2(12),
    First_Name           VARCHAR2(20),
    Last_Name            VARCHAR2(40),
    NIP                  VARCHAR2(11),
    Pesel                VARCHAR2(11)
);


create table ClientsTable Of ClientObj (PRIMARY KEY (PersonId));


//--------------------------------------INVOICE----------------------------------------------//
CREATE SEQUENCE InvoiceSequence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TYPE Invoice AS OBJECT
(
    InvoiceId Number,
    IssueDate DATE,
    Cost NUMBER,
    SingleClient REF ClientObj
);

create table InvoiceTables of INVOICE(InvoiceId PRIMARY KEY);
/

//--------------------------------EMPLOYEE----------------------------------------//
CREATE SEQUENCE EmployeeSequence START WITH 1 INCREMENT BY 1;
/
CREATE OR REPLACE TYPE Employee AS OBJECT (
    EmployeeId           Number,
    Contract_Start_Date  DATE,
    Contract_End_Date    DATE,
    Registration_Address Address,
    Phone_Number         VARCHAR(12),
    First_Name           VARCHAR(20),
    Last_Name            VARCHAR(40),
    Pesel                VARCHAR2(11),
    Salary               NUMBER,
    EmploymentType       VARCHAR2(50)
);

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
        newId in Number,
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
        newId in Number,
        SingleClient in REF ClientObj,
        SingleService in REF SERVICE,
        SingleEmployee in REF EMPLOYEE,
        OrderDate in Date
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.OrderId := newId;
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

CREATE SEQUENCE BranchSequence START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE OR REPLACE TYPE Branch AS OBJECT (
    BranchId Number,
    Branch_address Address,
    Employees EmployeeList,
    CONSTRUCTOR FUNCTION Branch(
         NewBranchId IN NUMBER,
        Branch_address IN Address
    ) RETURN SELF AS RESULT
);


CREATE OR REPLACE TYPE BODY Branch AS
    CONSTRUCTOR FUNCTION Branch(
        NewBranchId IN NUMBER,
        Branch_address IN Address

    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.BRANCHID := NewBranchId;
        SELF.Branch_address := Branch_address;
        SELF.Employees := EmployeeList();
        RETURN;
    END;
END;
/
create table BranchTable of Branch (BranchId PRIMARY KEY )
nested table Employees store as EmployeeListTable_nested;
/