CREATE OR REPLACE PACKAGE InvoicePackage AS

    PROCEDURE GenerateInvoice(ClientID IN NUMBER);
    PROCEDURE ShowServices(InvoiceRef IN REF INVOICE);
    FUNCTION getInvoiceById(invId in NUMBER) RETURN REF INVOICE;

END InvoicePackage;
/


CREATE OR REPLACE PACKAGE BODY InvoicePackage AS

    FUNCTION getInvoiceById(invId in NUMBER) RETURN REF INVOICE IS
        invoiceRef REF INVOICE;
    BEGIN
        SELECT REF(i) INTO invoiceRef
        FROM INVOICETABLES i
        WHERE invId = i.INVOICEID;

        RETURN invoiceRef;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20005, 'Invoice does not exist');
    end getInvoiceById;

    PROCEDURE ShowServices(InvoiceRef IN REF INVOICE) IS
        CURSOR c_orders IS
            SELECT DEREF(z.SingleService).Description, DEREF(z.SingleService).Price
            FROM ClientsOrdersTable z
            WHERE DEREF(z.SingleClient).PERSONID = DEREF(DEREF(InvoiceRef).SingleClient).PERSONID
            AND ((deref(InvoiceRef).IssueDate >=OrderDate  AND deref(InvoiceRef).IssueDate <= CLOSEORDERDATE) OR (CLOSEORDERDATE is null AND OrderDate < SYSDATE));

        v_description VARCHAR2(1000);
        v_price NUMBER;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Services:');
        OPEN c_orders;

        LOOP
            FETCH c_orders INTO v_description, v_price;
            EXIT WHEN c_orders%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Description: ' || v_description || ', Price: ' || v_price);
        END LOOP;

        CLOSE c_orders;
    END ShowServices;


    PROCEDURE GenerateInvoice(ClientID IN NUMBER) IS
        newCost NUMBER;
        client_ref REF ClientObj;
    BEGIN

        SELECT SUM(DEREF(z.SingleService).Price) INTO newCost
        FROM ClientsOrdersTable z
        WHERE DEREF(z.SingleClient).PERSONID = ClientID AND z.CLOSEORDERDATE is null AND OrderDate < SYSDATE;

        SELECT REF(c) INTO client_ref FROM ClientsTable c WHERE CLIENTID = c.PERSONID;

        INSERT INTO INVOICETABLES VALUES (INVOICE(INVOICESEQUENCE.nextval, SYSDATE, newCost, client_ref));
        Commit;

        DBMS_OUTPUT.PUT_LINE('Invoice netto price: ' || newCost || ', invoice brutto: ' || newCost*1.23);
    END GenerateInvoice;

END InvoicePackage;
/

