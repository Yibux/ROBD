DECLARE
    empToAdd EMPLOYEE := EMPLOYEE(123456789, 'John', 'Doe', '01-JAN-1990');
    branchId NUMBER := 123;
BEGIN
    select

    EmployeePackage.AddEmployeeToBranch(empToAdd, branchId);
    DBMS_OUTPUT.PUT_LINE('Employee added successfully');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

select * from BRANCHTABLE;

select * from EMPLOYEESTABLE;

INSERT INTO BranchTable VALUES (
    Branch(
        Address('Street8', 'City8', 'Province8', '33333', 'Country8'),
        EmployeeList(Employee(SYSDATE, SYSDATE + 365, Address('Street9', 'City9', 'Province9', '44444', 'Country9'), '3333333333',
                              'Alice', 'Johnson', '33333333333', 7000, 'Full Time')))
);

INSERT INTO EMPLOYEESTABLE VALUES (
    Employee(SYSDATE, SYSDATE + 365, Address('Street9', 'City9', 'Province9', '44444', 'Country9'), '3323333333',
                              'John', 'Johnson', '33333333333', 7000, 'Full Time'));