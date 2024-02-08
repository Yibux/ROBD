CREATE OR REPLACE PACKAGE BranchPackage AS

    PROCEDURE addBranch(BranchAddress in ADDRESS);

END BranchPackage;
/

CREATE OR REPLACE PACKAGE BODY BranchPackage AS
    PROCEDURE addBranch(BranchAddress in ADDRESS) IS
        branch_data Branch := Branch(BranchAddress);
    BEGIN
        INSERT INTO BranchTable (BranchId, Branch_address, Employees)
        VALUES (branch_data.BranchId, branch_data.Branch_address, branch_data.Employees);
        Commit;
        DBMS_OUTPUT.PUT_LINE('Branch with id ' || branch_data.BRANCHID || ' has been created.');
    END;
END BranchPackage;
