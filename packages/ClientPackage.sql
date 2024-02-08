drop package ClientPackage;
/

CREATE OR REPLACE PACKAGE ClientPackage AS

    PROCEDURE showAllClientsOrders;
--     PROCEDURE addClient();

END ClientPackage;
/

CREATE OR REPLACE PACKAGE BODY ClientPackage AS

    PROCEDURE GetClientByPesel(Pesel IN VARCHAR2) IS
        v_ClientId NUMBER;
    BEGIN
        SELECT ClientId INTO v_ClientId
        FROM ClientsTable
        WHERE Pesel = GetClientByPesel.Pesel;

        DBMS_OUTPUT.PUT_LINE('Client Id: ' || v_ClientId);
    END GetClientByPesel;



END;