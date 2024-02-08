drop package InvoicePackage;
/

CREATE OR REPLACE PACKAGE InvoicePackage AS

    PROCEDURE GenerateInvoice(ClientID IN NUMBER);
--     PROCEDURE ShowServices(InvoiceID IN NUMBER);

END InvoicePackage;
/


CREATE OR REPLACE PACKAGE BODY InvoicePackage AS

    PROCEDURE GenerateInvoice(ClientID IN NUMBER) IS
            cost NUMBER;
            client_ref REF ClientObj;
        BEGIN
            SELECT SUM(DEREF(z.SingleService).Price)  into cost
            FROM ClientsOrdersTable z
            WHERE DEREF(z.SingleClient).CLIENTID = ClientID AND CLOSEORDERDATE is null AND OrderDate < SYSDATE;

            SELECT REF(c) INTO client_ref FROM ClientsTable c WHERE CLIENTID = ClientID;

            Insert into INVOICETABLES values(INVOICE(SYSDATE,cost,client_ref));
    END GenerateInvoice;

--         PROCEDURE ShowServices(InvoiceID IN NUMBER) IS
--             CURSOR c_orders IS
--             SELECT DEREF(z.SingleService).Description, DEREF(z.SingleService).Price
--             FROM ClientsOrdersTable z
--             WHERE DEREF(z.SingleClient).CLIENTID = InvoiceID AND CLOSEORDERDATE is null AND OrderDate < SYSDATE;
--
--             v_description VARCHAR2(1000);
--             v_price NUMBER;
--         BEGIN
--             OPEN c_orders;
--
--             LOOP
--                 FETCH c_orders INTO v_description, v_price;
--                 EXIT WHEN c_orders%NOTFOUND;
--                 DBMS_OUTPUT.PUT_LINE('Opis: ' || v_description || ', Cena: ' || v_price);
--             END LOOP;
--
--             CLOSE c_orders;
--     END ShowServices;

END InvoicePackage;
/
