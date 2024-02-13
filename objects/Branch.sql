//--------------------------------BRANCH----------------------------------------------------//
Create type EmployeeList as table of Employee;

CREATE SEQUENCE BranchSequence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TYPE Branch AS OBJECT (
    BranchId Number,
    Branch_address Address,
    Employees EmployeeList,
    CONSTRUCTOR FUNCTION Branch(
        Branch_address IN Address
    ) RETURN SELF AS RESULT
);


CREATE OR REPLACE TYPE BODY Branch AS
    CONSTRUCTOR FUNCTION Branch(

        Branch_address IN Address

    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.BRANCHID := BranchSequence.nextval;
        SELF.Branch_address := Branch_address;
        SELF.Employees := EmployeeList();
        RETURN;
    END;
END;
/

create table BranchTable of Branch (BranchId PRIMARY KEY )
nested table Employees store as EmployeeListTable_nested;
/