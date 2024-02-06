drop package EmployeePackage;
/

CREATE OR REPLACE PACKAGE EmployeePackage AS

    PROCEDURE AddEmployeeToBranch(
        employeeToAdd IN EMPLOYEE,
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

        COMMIT;

        UPDATE BranchTable b
        SET b.Employees = b.Employees MULTISET UNION ALL (
            SELECT CAST(MULTISET(
                SELECT employeeToAdd
                FROM dual
            ) AS EmployeeList)
            FROM dual
        )
        WHERE b.BranchId = idForBranch;


        EXCEPTION
            WHEN EMPLOYEE_EXIST_EXCEPTION THEN
                RAISE_APPLICATION_ERROR(-20005, 'Employee exists');
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20005, 'Branch does not exist');

    END AddEmployeeToBranch;


END EmployeePackage;
/

select * from dual;
