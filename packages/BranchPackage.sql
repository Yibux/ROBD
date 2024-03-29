CREATE OR REPLACE PACKAGE BranchPackage AS

    PROCEDURE addBranch(BranchAddress in ADDRESS);

    PROCEDURE addService(
       descriptinOfService IN VARCHAR2,
       ServicePrice IN NUMBER
   );
    FUNCTION getServiceById(servId in NUMBER) RETURN REF SERVICE;

END BranchPackage;
/

CREATE OR REPLACE PACKAGE BODY BranchPackage AS
    PROCEDURE addBranch(BranchAddress in ADDRESS) IS
    BEGIN
        INSERT INTO BranchTable
        VALUES (BRANCH(BRANCHSEQUENCE.nextval, BranchAddress));
        Commit;
        DBMS_OUTPUT.PUT_LINE('Branch with id ' || BRANCHSEQUENCE.currval || ' has been created.');
    END addBranch;

    PROCEDURE addService(
        descriptinOfService IN VARCHAR2,
        ServicePrice IN NUMBER
    ) IS
    BEGIN
        INSERT INTO SERVICETABLE VALUES (SERVICE(SERVICESEQUENCE.nextval ,descriptinOfService, ServicePrice));
        Commit;
        DBMS_OUTPUT.PUT_LINE('Service with description: ' || descriptinOfService || ' and price: ' ||
                             ServicePrice || ' added!');
    END addService;


    FUNCTION getServiceById(servId in NUMBER) RETURN REF SERVICE IS
        v_ServiceRef REF SERVICE;
    BEGIN
        SELECT REF(s) INTO v_ServiceRef
        FROM SERVICETABLE s
        WHERE servId = s.SERVICEID;

        RETURN v_ServiceRef;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20005, 'Client does not exist');
    END getServiceById;
END BranchPackage;
