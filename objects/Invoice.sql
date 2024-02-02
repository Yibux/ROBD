//--------------------------------------INVOICE----------------------------------------------//

CREATE OR REPLACE TYPE Invoice AS OBJECT
(
    IssueDate DATE,
    Cost NUMBER,
    Services ServiceList,
    CONSTRUCTOR FUNCTION Invoice
    (
        IssueDate IN DATE,
        Cost IN NUMBER,
        Services IN ServiceList
    ) RETURN SELF AS RESULT
);

CREATE OR REPLACE TYPE BODY Invoice AS
    CONSTRUCTOR FUNCTION Invoice
    (
        IssueDate IN DATE,
        Cost IN NUMBER,
        Services IN ServiceList
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.IssueDate := IssueDate;
        SELF.Cost := Cost;
        SELF.Services := Services;
        RETURN;
    END;
END;

/
