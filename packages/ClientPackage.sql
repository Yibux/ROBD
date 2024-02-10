drop package ClientPackage;
/

CREATE OR REPLACE PACKAGE ClientPackage AS

   PROCEDURE addPersonClient(clientToAdd in CLIENTOBJ);
   PROCEDURE addCompanyClient(clientToAdd in CLIENTOBJ);
   FUNCTION GetClientByPesel(clientPesel IN VARCHAR2) RETURN REF CLIENTOBJ;
   PROCEDURE GetActiveServices(p_PersonID IN NUMBER);

END ClientPackage;
/

CREATE OR REPLACE PACKAGE BODY ClientPackage AS

    PROCEDURE addPersonClient(clientToAdd in CLIENTOBJ) IS
        CLIENT_EXISTS_EXCEPTION EXCEPTION;
        cli CLIENTOBJ;
    Begin
        Begin
            SELECT VALUE(c) INTO cli
            FROM CLIENTSTABLE c
            WHERE c.pesel = clientToAdd.PESEL and ROWNUM <= 1;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            cli := NULL;
        END;

        IF cli IS NOT NULL THEN
            RAISE CLIENT_EXISTS_EXCEPTION;
        end if;

        INSERT INTO CLIENTSTABLE VALUES clientToAdd;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE(
                'Client with ID: ' || clientToAdd.PERSONID || ', name: ' || clientToAdd.FIRST_NAME || ' ' || clientToAdd.LAST_NAME || 'added successfully'
        );
        EXCEPTION
            WHEN CLIENT_EXISTS_EXCEPTION THEN
                RAISE_APPLICATION_ERROR(-20005, 'Person exists');
    End addPersonClient;


    PROCEDURE addCompanyClient(clientToAdd in CLIENTOBJ) IS
        CLIENT_EXISTS_EXCEPTION EXCEPTION;
        cli CLIENTOBJ;
    Begin
        Begin
            SELECT VALUE(c) INTO cli
            FROM CLIENTSTABLE c
            WHERE c.NIP = clientToAdd.NIP and ROWNUM <= 1;

            DBMS_OUTPUT.PUT_LINE(cli.NIP);

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            cli := NULL;
        END;

        IF cli IS NOT NULL THEN
            RAISE CLIENT_EXISTS_EXCEPTION;
        end if;

        INSERT INTO CLIENTSTABLE VALUES clientToAdd;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE(
                'Client with ID: ' || clientToAdd.PERSONID || ', name: ' || clientToAdd.FIRST_NAME || ' ' || clientToAdd.LAST_NAME || 'added successfully'
        );
    End addCompanyClient;


    FUNCTION GetClientByPesel(clientPesel IN VARCHAR2) RETURN REF CLIENTOBJ IS
        v_ClientRef REF CLIENTOBJ;
    BEGIN
        SELECT REF(c) INTO v_ClientRef
        FROM clientsTable c
        WHERE clientPesel = c.PESEL;

        RETURN v_ClientRef;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20005, 'Client does not exist');
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