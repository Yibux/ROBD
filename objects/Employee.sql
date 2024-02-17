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
/