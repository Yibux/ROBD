//---------------------------ORDER----------------------------//
drop type CLIENTORDER;
/

CREATE SEQUENCE OrderSequence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TYPE ClientOrder AS OBJECT (
    OrderId NUMBER,
    SingleClient REF ClientObj,
    SingleService REF SERVICE,
    SingleEmployee REF EMPLOYEE,
    OrderDate DATE,
    CloseOrderDate DATE,

    CONSTRUCTOR FUNCTION ClientOrder(
        SingleClient IN REF ClientObj,
        SingleService IN REF SERVICE,
        SingleEmployee IN REF EMPLOYEE,
        OrderDate IN DATE
    ) RETURN SELF AS RESULT,
    MEMBER PROCEDURE CloseOrder
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
        SELF.CLOSEORDERDATE := null;
        RETURN;
    END;

    MEMBER PROCEDURE CloseOrder IS
    BEGIN
        SELF.CloseOrderDate := SYSDATE;
    END;
END;
/

Create table ClientsOrdersTable of CLIENTORDER (OrderId PRIMARY KEY );