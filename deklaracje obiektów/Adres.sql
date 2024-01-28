//--------------------------------ADRES----------------------------------------------------//


CREATE OR REPLACE TYPE Adres AS OBJECT
(
    Ulica VARCHAR2(40),
    Miasto VARCHAR2(40),
    Wojewodztwo VARCHAR2(40),
    Kod_pocztowy VARCHAR2(7),
    Panstwo VARCHAR2(50),
    CONSTRUCTOR FUNCTION Adres
    (
        Ulica IN VARCHAR2,
        Miasto IN VARCHAR2,
        Wojewodztwo IN VARCHAR2,
        Kod_pocztowy IN VARCHAR2,
        Panstwo IN VARCHAR2
    ) RETURN SELF AS RESULT
);
/

CREATE OR REPLACE TYPE BODY Adres AS
    CONSTRUCTOR FUNCTION Adres
    (
        Ulica IN VARCHAR2,
        Miasto IN VARCHAR2,
        Wojewodztwo IN VARCHAR2,
        Kod_pocztowy IN VARCHAR2,
        Panstwo IN VARCHAR2
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.Ulica := Ulica;
        SELF.Miasto := Miasto;
        SELF.Wojewodztwo := Wojewodztwo;
        SELF.Kod_pocztowy := Kod_pocztowy;
        SELF.Panstwo := Panstwo;
        RETURN;
    END;
END;
/