drop package ClientPackage;
/

CREATE OR REPLACE PACKAGE ClientPackage AS

   PROCEDURE GetClientByPesel(Pesel IN VARCHAR2);
   PROCEDURE GetActiveServices(p_PersonID IN NUMBER);

END ClientPackage;
/

CREATE OR REPLACE PACKAGE BODY ClientPackage AS

    PROCEDURE GetClientByPesel(Pesel IN VARCHAR2) IS
        v_ClientId NUMBER;
    BEGIN
        SELECT PersonID INTO v_ClientId
        FROM ClientsTable
        WHERE Pesel = GetClientByPesel.Pesel;

        DBMS_OUTPUT.PUT_LINE('Client Id: ' || v_ClientId);
    END GetClientByPesel;




    PROCEDURE GetActiveServices(p_PersonID IN NUMBER) IS
    CURSOR orderCursor IS
        SELECT DEREF(c.SINGLESERVICE).DESCRIPTION AS service_description,
               DEREF(c.SINGLESERVICE).PRICE AS service_price
        FROM CLIENTSORDERSTABLE c
        WHERE DEREF(c.SINGLECLIENT).PersonID = p_PersonID
        AND CLOSEORDERDATE IS NULL;

    v_service_description VARCHAR2(100);
    v_service_price NUMBER;
BEGIN
    OPEN orderCursor;

    LOOP
        FETCH orderCursor INTO v_service_description, v_service_price;
        EXIT WHEN orderCursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Description: ' || v_service_description || ' Price: ' || v_service_price);
    END LOOP;

    CLOSE orderCursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END GetActiveServices;

END;