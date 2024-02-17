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
    EmploymentType       VARCHAR2(50),

    CONSTRUCTOR FUNCTION Employee
    (
        newId in Number,
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
        newId in Number,
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
        SELF.EmployeeId := newId;
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
