//--------------------------------SERVICE----------------------------------------------------//

CREATE OR REPLACE TYPE Service AS OBJECT
(
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
        SELF.Description := Description;
        SELF.Price := Price;
        RETURN;
    END;
END;

/
