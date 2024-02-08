CREATE OR REPLACE PACKAGE EmployeePackage AS

    PROCEDURE AddEmployeeToBranch(
        employeeToAdd IN EMPLOYEE,
        idForBranch IN NUMBER
    );

     PROCEDURE CheckIfEmployeeIsCurrentlyWorking(
        employeeToCheck IN EMPLOYEE
    );

    PROCEDURE CheckIfEmployeeWorksInTheBranch(
        employeeToCheck IN EMPLOYEE,
        idForBranch IN NUMBER
    );

END EmployeePackage;
/


CREATE OR REPLACE PACKAGE BODY EmployeePackage AS

    PROCEDURE AddEmployeeToBranch(
        employeeToAdd IN EMPLOYEE,
        idForBranch IN NUMBER
    ) IS
        EMPLOYEE_EXIST_EXCEPTION EXCEPTION;
        emp EMPLOYEE;
    BEGIN
        Begin
            SELECT VALUE(e) INTO emp
            FROM EmployeesTable e
            WHERE e.pesel = employeeToAdd.PESEL and ROWNUM <= 1;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            emp := NULL;
        END;

        IF emp IS NOT NULL THEN
            RAISE EMPLOYEE_EXIST_EXCEPTION;
        end if;

        INSERT INTO EMPLOYEESTABLE VALUES (employeeToAdd);

        UPDATE BranchTable b
        SET b.Employees = b.Employees MULTISET UNION ALL (
            SELECT CAST(MULTISET(
                SELECT employeeToAdd
                FROM dual
            ) AS EmployeeList)
            FROM dual
        )
        WHERE b.BranchId = idForBranch;

        COMMIT;
        DBMS_OUTPUT.PUT_LINE(
                'Employee with ID: ' || employeeToAdd.EMPLOYEEID || ', name: ' || employeeToAdd.FIRST_NAME || ' ' || employeeToAdd.LAST_NAME || 'added successfully'
        );
        EXCEPTION
            WHEN EMPLOYEE_EXIST_EXCEPTION THEN
                RAISE_APPLICATION_ERROR(-20005, 'Employee exists');
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20005, 'Branch does not exist');

    END AddEmployeeToBranch;


    PROCEDURE CheckIfEmployeeIsCurrentlyWorking(
        employeeToCheck IN EMPLOYEE
    ) IS
        currentContractEnd DATE;
    BEGIN
        SELECT Contract_End_Date
        INTO currentContractEnd
        FROM EMPLOYEESTABLE
        WHERE EmployeeId = employeeToCheck.EmployeeId;

        IF currentContractEnd IS NULL THEN
            RAISE_APPLICATION_ERROR(-20005, 'Employee has no active contract.');
        ELSIF currentContractEnd >= SYSDATE THEN
            DBMS_OUTPUT.PUT_LINE('Employee is currently working.');
        ELSE
            RAISE_APPLICATION_ERROR(-20005, 'Employee contract has ended.');
        END IF;
    END CheckIfEmployeeIsCurrentlyWorking;

    PROCEDURE CheckIfEmployeeWorksInTheBranch(
        employeeToCheck IN EMPLOYEE,
        idForBranch IN NUMBER
    ) IS
        isWorking NUMBER;
    BEGIN
         BEGIN
            CheckIfEmployeeIsCurrentlyWorking(employeeToCheck);
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
                RETURN;
        END;

        SELECT COUNT(*)
        INTO isWorking
        FROM BranchTable b
        WHERE b.BranchId = idForBranch AND EXISTS (
            SELECT 1
            FROM TABLE(b.Employees) e
            WHERE e.PESEL = employeeToCheck.PESEL
        );

        IF isWorking > 0 THEN
            DBMS_OUTPUT.PUT_LINE('Employee works in the specified branch.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Employee does not work in the specified branch.');
        END IF;
    END CheckIfEmployeeWorksInTheBranch;

END EmployeePackage;
/
