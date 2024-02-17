CREATE SEQUENCE InvoiceSequence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TYPE Invoice AS OBJECT
(
    InvoiceId Number,
    IssueDate DATE,
    Cost NUMBER,
    SingleClient REF ClientObj
);

create table InvoiceTables of INVOICE(InvoiceId PRIMARY KEY);
/