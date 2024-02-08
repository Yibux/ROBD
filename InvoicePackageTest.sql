insert into SYSTEM.CLIENTSTABLE
    values ClientObj(SYSDATE, SYSDATE + 365,
    Address('Street7', 'City7', 'Province7', '22222', 'Country7'),
    '2222222222', 'Jan', 'Kowalski', null, '80122838428');

insert into SYSTEM.CLIENTSTABLE
    values ClientObj(SYSDATE, SYSDATE + 365,
    Address('Street7', 'City7', 'Province7', '22222', 'Country7'),
    '2222222222', 'Jan', 'Kowalski', null, '91111795378');

DECLARE
    userID NUMBER;
    setDate Date;
    InvoiceIDD NUMBER := 25;
BEGIN

    SELECT ISSUEDATE INTO setDate FROM INVOICETABLES WHERE INVOICEID = InvoiceIDD;
    SELECT DEREF(i.SINGLECLIENT).CLIENTID INTO userID FROM INVOICETABLES i WHERE INVOICEID = InvoiceIDD;

    SELECT DEREF(z.SingleService)
      FROM ClientsOrdersTable z
      WHERE DEREF(z.SingleClient).CLIENTID = 29  AND (OrderDate >= setDate AND setDate<=CLOSEORDERDATE);

END;




select * from INVOICETABLES;





/

