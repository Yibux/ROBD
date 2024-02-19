CREATE OR REPLACE PACKAGE EmployeePackage AS

    PROCEDURE AddEmployeeToBranch(
        Contract_Start_Date IN DATE,
        Contract_End_Date IN DATE,
        Registration_Address IN Address,
        Phone_number IN VARCHAR2,
        First_Name IN VARCHAR2,
        Last_Name IN VARCHAR2,
        PeselToAdd IN VARCHAR2,
        Salary IN NUMBER,
        EmploymentType IN VARCHAR2,
        idForBranch IN NUMBER
    );

     PROCEDURE CheckIfEmployeeIsCurrentlyWorking(
        employeeToCheck IN EMPLOYEE
    );

    PROCEDURE CheckIfEmployeeWorksInTheBranch(
        employeeToCheck IN EMPLOYEE,
        idForBranch IN NUMBER
    );

    FUNCTION getEmployeeByPesel(empPesel in VARCHAR2) RETURN REF EMPLOYEE;

END EmployeePackage;
/


CREATE OR REPLACE PACKAGE BODY EmployeePackage AS

    PROCEDURE AddEmployeeToBranch(
        Contract_Start_Date IN DATE,
        Contract_End_Date IN DATE,
        Registration_Address IN Address,
        Phone_number IN VARCHAR2,
        First_Name IN VARCHAR2,
        Last_Name IN VARCHAR2,
        PeselToAdd IN VARCHAR2,
        Salary IN NUMBER,
        EmploymentType IN VARCHAR2,
        idForBranch IN NUMBER
    ) IS
        EMPLOYEE_EXIST_EXCEPTION EXCEPTION;
        emp EMPLOYEE;
        employeeToAdd EMPLOYEE;
    BEGIN

        Begin
            SELECT VALUE(e) INTO emp
            FROM EmployeesTable e
            WHERE e.pesel = PeselToAdd and ROWNUM <= 1;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
                emp := NULL;
        END;

        IF emp IS NOT NULL THEN
            RAISE EMPLOYEE_EXIST_EXCEPTION;
        end if;

        employeeToAdd := Employee(EmployeeSequence.nextval, Contract_Start_Date, Contract_End_Date, Registration_Address, Phone_number, First_Name, Last_Name, PeselToAdd, Salary, EmploymentType);

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
                'Employee with ID: ' || employeeToAdd.EMPLOYEEID || ', name: ' || employeeToAdd.FIRST_NAME || ' ' || employeeToAdd.LAST_NAME || ' added successfully'
        );
        EXCEPTION
            WHEN EMPLOYEE_EXIST_EXCEPTION THEN
                RAISE_APPLICATION_ERROR(-20005, 'Employee exists');
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20005, 'Branch does not exist');

    END;



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
            RAISE_APPLICATION_ERROR(-20005, 'Employee with ID: ' || employeeToCheck.EMPLOYEEID || ', name: ' || employeeToCheck.FIRST_NAME || ' ' || employeeToCheck.LAST_NAME || ' has no active contract.');
        ELSIF currentContractEnd >= SYSDATE THEN
            DBMS_OUTPUT.PUT_LINE('Employee with ID: ' || employeeToCheck.EMPLOYEEID || ', name: ' || employeeToCheck.FIRST_NAME || ' ' || employeeToCheck.LAST_NAME || ' is currently working.');
        ELSE
            RAISE_APPLICATION_ERROR(-20005, 'Employee with ID: ' || employeeToCheck.EMPLOYEEID || ', name: ' || employeeToCheck.FIRST_NAME || ' ' || employeeToCheck.LAST_NAME || ' contract has ended.');
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

    FUNCTION getEmployeeByPesel(empPesel in VARCHAR2) RETURN REF EMPLOYEE IS
    v_empRef REF EMPLOYEE;
    BEGIN
        SELECT REF(e) INTO v_empRef
        FROM EMPLOYEESTABLE e
        WHERE empPesel = e.PESEL;

        RETURN v_empRef;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20005, 'Client does not exist');
    END getEmployeeByPesel;

END EmployeePackage;
/
