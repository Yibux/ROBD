//--------------------------------BRANCH----------------------------------------------------//
Create type EmployeeList as table of Employee;

CREATE SEQUENCE BranchSequence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TYPE Branch AS OBJECT (
    BranchId Number,
    Branch_address Address,
    Employees EmployeeList,
    MEMBER PROCEDURE AddEmployee(employee2 IN Employee),
    CONSTRUCTOR FUNCTION Branch(
        Branch_address IN Address,
        Employees IN EmployeeList
    ) RETURN SELF AS RESULT
);


CREATE OR REPLACE TYPE BODY Branch AS
    CONSTRUCTOR FUNCTION Branch(

        Branch_address IN Address,
        Employees IN EmployeeList

    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.BRANCHID = BranchSequence.nextval;
        SELF.Branch_address := Branch_address;
        SELF.Employees := Employees;
        RETURN;
    END;

--     MEMBER PROCEDURE AddEmployee(employee2 IN Employee) IS
--         EMPLOYEE_EXIST_EXCEPTION EXCEPTION;
--         emp EMPLOYEE;
--     BEGIN
--         Begin
--             SELECT VALUE(e) INTO emp
--             FROM EmployeesTable e
--             WHERE e.pesel = employee2.PESEL and ROWNUM <= 1;
--         EXCEPTION
--         WHEN NO_DATA_FOUND THEN
--             emp := NULL;
--         END;
--
--         IF emp IS NOT NULL THEN
--             RAISE EMPLOYEE_EXIST_EXCEPTION;
--         end if;
--
--         INSERT INTO EMPLOYEESTABLE VALUES (employee2);
--
--         COMMIT;
--
--         SELF.Employees.EXTEND;
--         SELF.Employees(SELF.Employees.LAST) := employee2;
--
--         EXCEPTION
--         WHEN EMPLOYEE_EXIST_EXCEPTION THEN
--             RAISE_APPLICATION_ERROR(-20005, 'Employee exists');
--     END;
END;
