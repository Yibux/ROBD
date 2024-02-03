//---------------------------ORDER----------------------------//
CREATE SEQUENCE OrderSequence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TYPE ClientOrder AS OBJECT (
    OrderId NUMBER,
    SingleClient REF ClientObj,
    SingleService REF SERVICE,
    SingleEmployee REF EMPLOYEE,
    OrderDate DATE,

    CONSTRUCTOR FUNCTION ClientOrder(
        SingleClient IN REF ClientObj,
        SingleService IN REF SERVICE,
        SingleEmployee IN REF EMPLOYEE,
        OrderDate IN DATE
    ) RETURN SELF AS RESULT
);
/

CREATE OR REPLACE TYPE BODY ClientOrder AS
    CONSTRUCTOR FUNCTION ClientOrder(
        SingleClient in REF ClientObj,
        SingleService in REF SERVICE,
        SingleEmployee in REF EMPLOYEE,
        OrderDate in Date
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.OrderId := OrderSequence.nextval;
        SELF.SingleClient := SingleClient;
        SELF.SingleService := SingleService;
        SELF.SingleEmployee := SingleEmployee;
        SELF.OrderDate := OrderDate;
        RETURN;
    END;
END;
/

Create table ClientsOrdersTable of CLIENTORDER (OrderId PRIMARY KEY );