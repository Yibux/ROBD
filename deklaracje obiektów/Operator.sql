//--------------------------------OPERATOR----------------------------------------------------//

CREATE OR REPLACE TYPE Operator AS OBJECT
(
    Establishment_date DATE,
    Owner VARCHAR2(100),
    Services Service_List,
    CONSTRUCTOR FUNCTION Operator
    (
        Establishment_date IN DATE,
        Owner IN VARCHAR2,
        Services IN Service_List
    ) RETURN SELF AS RESULT,
    MEMBER PROCEDURE addService (service IN Service)
);

CREATE OR REPLACE TYPE BODY Operator AS
    CONSTRUCTOR FUNCTION Operator
    (
        Establishment_date IN DATE,
        Owner IN VARCHAR2,
        Services IN Service_List
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.Establishment_date := Establishment_date;
        SELF.Owner := Owner;
        SELF.Services := Services;
        RETURN;
    END;

    MEMBER PROCEDURE addService (service IN Service) IS
    BEGIN
        SELF.Services.EXTEND;
        SELF.Services(SELF.Services.COUNT) := service;
    END;
END;
/
