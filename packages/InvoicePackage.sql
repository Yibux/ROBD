drop package InvoicePackage;
/

CREATE OR REPLACE PACKAGE InvoicePackage AS

    PROCEDURE GenerateInvoice(OrderId IN NUMBER);

END InvoicePackage;
/


CREATE OR REPLACE PACKAGE BODY InvoicePackage AS

    PROCEDURE GenerateInvoice(OrderId IN NUMBER) IS
        v_ClientId NUMBER;
        v_Cost NUMBER;
    BEGIN
        -- Pobierz klienta i koszt zamówienia
        SELECT DEREF(SingleClient).ClientId, DEREF(SingleService).Price
        INTO v_ClientId, v_Cost
        FROM ClientsOrdersTable
        WHERE OrderId = GenerateInvoice.OrderId;

        -- Wstaw fakturę do tabeli faktur
        INSERT INTO InvoiceTables (InvoiceId, IssueDate, Cost, SingleClient)
        VALUES (InvoiceSequence.nextval, SYSDATE, v_Cost, (SELECT REF(c) FROM ClientsTable c WHERE c.ClientId = v_ClientId));

        COMMIT;
    END GenerateInvoice;

END InvoicePackage;
/
