//------------------------------ADD BRANCH------------------------//
DECLARE
    addresstToAdd ADDRESS := Address('Street9', 'City9', 'Province9', '44444', 'Country9');
    addresstToAdd2 ADDRESS := Address('Street2', 'City2', 'Province2', '44444', 'Country2');
BEGIN
    BranchPackage.ADDBRANCH(addresstToAdd);
    BranchPackage.ADDBRANCH(addresstToAdd2);
END;
/

select * from BRANCHTABLE;
SELECT BRANCHSEQUENCE.nextval FROM dual;



//-------------------------------------ADDING EMPLOYEE-----------------------------------------//
DECLARE
    Contract_Start_Date DATE := SYSDATE;
    Contract_End_Date DATE := SYSDATE + 365;
    Registration_Address Address := Address('Street9', 'City9', 'Province9', '44444', 'Country9');
    Phone_number VARCHAR2(255) := '3323333333';
    First_Name VARCHAR2(20) := 'John';
    Last_Name VARCHAR2(40) := 'Johnson';
    Pesel VARCHAR2(11) := '13333333873';
    Salary NUMBER := 7000;
    EmploymentType VARCHAR2(20) := 'Full Time';
    takenBranchId NUMBER;
BEGIN
    SELECT BranchId
    INTO takenBranchId
    FROM BRANCHTABLE
    WHERE ROWNUM <= 1;
    EmployeePackage.AddEmployeeToBranch(
        Contract_Start_Date,
        Contract_End_Date,
        Registration_Address,
        Phone_number,
        First_Name,
        Last_Name,
        Pesel,
        Salary,
        EmploymentType,
        takenBranchId
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/

//-------------------------------------ERROR EMPLOYEE EXISTS-----------------------------------------//
DECLARE
    Contract_Start_Date DATE := SYSDATE;
    Contract_End_Date DATE := SYSDATE + 365;
    Registration_Address Address := Address('Street9', 'City9', 'Province9', '44444', 'Country9');
    Phone_number VARCHAR2(255) := '3323333333';
    First_Name VARCHAR2(20) := 'John';
    Last_Name VARCHAR2(40) := 'Johnson';
    Pesel VARCHAR2(11) := '13333333873';
    Salary NUMBER := 7000;
    EmploymentType VARCHAR2(20) := 'Full Time';
    takenBranchId NUMBER;
BEGIN
    SELECT BranchId
    INTO takenBranchId
    FROM BRANCHTABLE
    WHERE ROWNUM <= 1;

    EmployeePackage.AddEmployeeToBranch(
        Contract_Start_Date,
        Contract_End_Date,
        Registration_Address,
        Phone_number,
        First_Name,
        Last_Name,
        Pesel,
        Salary,
        EmploymentType,
        takenBranchId
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/



//-------------------------------------CHECK IF EMPLOYEE KEEPS WORKING-----------------------------------------//
DECLARE
    emp EMPLOYEE;
BEGIN
    SELECT VALUE(e) INTO emp
    FROM EmployeesTable e
    WHERE ROWNUM <= 1;
    EmployeePackage.CheckIfEmployeeIsCurrentlyWorking(emp);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

//-------------------------------------EMPLOYEE DOES NOT WORK-----------------------------------------//
DECLARE
    emp EMPLOYEE;
BEGIN
    SELECT VALUE(e) INTO emp
    FROM EmployeesTable e
    WHERE ROWNUM <= 1;

    UPDATE EMPLOYEESTABLE
    SET CONTRACT_END_DATE = SYSDATE - 1000
    WHERE EMPLOYEEID = emp.EMPLOYEEID;

    EmployeePackage.CheckIfEmployeeIsCurrentlyWorking(emp);

    ROLLBACK;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

//------------------------------------EMPLOYEE WORKS IN A BRANCH-------------------------------------//

DECLARE
    takenBranchId NUMBER;
    emp EMPLOYEE;
BEGIN
    SELECT BranchId
    INTO takenBranchId
    FROM BRANCHTABLE
    WHERE ROWNUM <= 1;

    SELECT VALUE(e) INTO emp
    FROM EmployeesTable e
    WHERE ROWNUM <= 1;
    EmployeePackage.CheckIfEmployeeWorksInTheBranch(emp, takenBranchId);

    emp.PESEL := 9999999999;

    EmployeePackage.CheckIfEmployeeWorksInTheBranch(emp, takenBranchId);

    UPDATE EMPLOYEESTABLE
    SET CONTRACT_END_DATE = SYSDATE - 1000
    WHERE EMPLOYEEID = emp.EMPLOYEEID;

    EmployeePackage.CheckIfEmployeeWorksInTheBranch(emp, takenBranchId);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

//------------------------------------TEST TRIGGERA EMPLOYEE DATY-----------------------------------//
DECLARE
    empToAdd EMPLOYEE := Employee(SYSDATE + 367, SYSDATE + 365, Address('Street9', 'City9', 'Province9', '44444', 'Country9'), '3323333333',
                 'John', 'Johnson', '12333335173', 7000, 'Full Time');
    takenBranchId NUMBER;
BEGIN
    SELECT BranchId
    INTO takenBranchId
    FROM BRANCHTABLE
    WHERE ROWNUM <= 1;
    EmployeePackage.AddEmployeeToBranch(empToAdd, takenBranchId);


EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

//------------------------------------TEST ADDING CLIENTS-----------------------------------//
DECLARE
    cliToAdd CLIENTOBJ := CLIENTOBJ(SYSDATE, SYSDATE + 365,
        Address('Street9', 'City9', 'Province9', '44444', 'Country9'), '3323333333',
        'Pani', 'Halina', null, '53021148691');

    companyToAdd CLIENTOBJ := CLIENTOBJ(SYSDATE, SYSDATE + 365,
        Address('Street9', 'City9', 'Province9', '44444', 'Country9'), '3323333333',
        'KARTOFEL', 'SP. Z O. O.', '5302114691', null);
BEGIN
--     CLIENTPACKAGE.ADDPERSONCLIENT(cliToAdd);

    CLIENTPACKAGE.ADDCOMPANYCLIENT(companyToAdd);


EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

//------------------------------------Client trigger-----------------------------------//
DECLARE
    cliToAdd CLIENTOBJ := CLIENTOBJ(SYSDATE, SYSDATE + 365,
        Address('Street9', 'City9', 'Province9', '44444', 'Country9'), '3323333333',
        'Pani', 'Halina', null, null);

    companyToAdd CLIENTOBJ := CLIENTOBJ(SYSDATE, SYSDATE + 365,
        Address('Street9', 'City9', 'Province9', '44444', 'Country9'), '3323333333',
        'KARTOFEL', 'SP. Z O. O.', '5302114691', '53021146912');
BEGIN
--     CLIENTPACKAGE.ADDPERSONCLIENT(cliToAdd);

    CLIENTPACKAGE.ADDCOMPANYCLIENT(companyToAdd);


EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

//----------------------------ADD SERVICE------------------------//
DECLARE
    description Varchar2(100) := 'Polaczenia i sms bez limitu + Internet 7GB';
    price Number := 30;
BEGIN

    BRANCHPACKAGE.ADDSERVICE(description, price);

    description := 'Polaczenia i sms bez limitu + Internet 12GB';
    price := 50;

    BRANCHPACKAGE.ADDSERVICE(description, price);

END;
/

select * from SERVICETABLE;
select * from EMPLOYEESTABLE;
select * from CLIENTSTABLE;
select * from CLIENTSORDERSTABLE;

//----------------------------ADD ORDER------------------------//
DECLARE
    client_ref REF ClientObj;
    service_ref REF SERVICE;
    employee_ref REF EMPLOYEE;
BEGIN
    client_ref := CLIENTPACKAGE.GETCLIENTBYPESEL('53021148691');
    service_ref := BRANCHPACKAGE.GETSERVICEBYID(1);
    employee_ref := EMPLOYEEPACKAGE.GETEMPLOYEEBYPESEL('12333333873');

    ORDERPACKAGE.CREATEORDER(client_ref, service_ref, employee_ref);

END;
/

//------------------------Generate invoice--------------------------//
DECLARE
    ClientID NUMBER := 1;
    invRef REF INVOICE;
BEGIN
    INVOICEPACKAGE.GENERATEINVOICE(ClientID);

    invRef := INVOICEPACKAGE.GETINVOICEBYID(1);

    INVOICEPACKAGE.ShowServices(invRef);


END;
/
