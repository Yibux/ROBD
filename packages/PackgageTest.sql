//------------------------------ADD BRANCH------------------------//
DECLARE
    addresstToAdd ADDRESS := Address('Street9', 'City9', 'Province9', '44444', 'Country9');
BEGIN
    BranchPackage.ADDBRANCH(addresstToAdd);
END;
/

select * from BRANCHTABLE;



//-------------------------------------ADDING EMPLOYEE-----------------------------------------//
DECLARE
    empToAdd EMPLOYEE := Employee(SYSDATE, SYSDATE + 365, Address('Street9', 'City9', 'Province9', '44444', 'Country9'), '3323333333',
                 'John', 'Johnson', '12333333873', 7000, 'Full Time');
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

//-------------------------------------ERROR EMPLOYEE EXISTS-----------------------------------------//
DECLARE
    empToAdd EMPLOYEE := Employee(SYSDATE, SYSDATE + 365, Address('Street9', 'City9', 'Province9', '44444', 'Country9'), '3323333333',
                 'John', 'Johnson', '12333333873', 7000, 'Full Time');
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

//------------------------------------TEST TRIGGERA-----------------------------------//
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


select *
from BRANCHTABLE;

select *
from EMPLOYEESTABLE;
