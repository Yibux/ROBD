//--------------------------------------INVOICE----------------------------------------------//
CREATE SEQUENCE InvoiceSequence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TYPE Invoice AS OBJECT
(
    InvoiceId Number,
    IssueDate DATE,
    Cost NUMBER,
    SingleClient REF ClientObj
    CONSTRUCTOR FUNCTION Invoice
    (
        IssueDate IN DATE,
        Cost IN NUMBER,
        SingleClient in ClientObj
    ) RETURN SELF AS RESULT
);

CREATE OR REPLACE TYPE BODY Invoice AS
    CONSTRUCTOR FUNCTION Invoice
    (
        IssueDate IN DATE,
        Cost IN NUMBER,
        SingleClient in ClientObj
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.InvoiceId := InvoiceSequence.nextval;
        SELF.IssueDate := IssueDate;
        SELF.Cost := Cost;
        SELF.SingleClient := SingleClient;
        RETURN;
    END;
END;

/
