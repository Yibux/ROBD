//--------------------------------SERVICE----------------------------------------------------//
CREATE SEQUENCE ServiceSequence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TYPE Service AS OBJECT
(
    ServiceId Number,
    Description VARCHAR2(100),
    Price NUMBER,
    CONSTRUCTOR FUNCTION Service
    (
        Description IN VARCHAR2,
        Price IN NUMBER
    ) RETURN SELF AS RESULT
);

/

CREATE OR REPLACE TYPE BODY Service AS
    CONSTRUCTOR FUNCTION Service
    (
        Description IN VARCHAR2,
        Price IN NUMBER
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.ServiceId := ServiceSequence.nextval;
        SELF.Description := Description;
        SELF.Price := Price;
        RETURN;
    END;
END;

/