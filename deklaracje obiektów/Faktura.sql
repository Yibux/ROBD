 //--------------------------------------FAKTURA----------------------------------------------//

CREATE OR REPLACE TYPE Faktura AS OBJECT
(
    DataWystawienia DATE,
    Koszt NUMBER,
    Uslugi Lista_uslug,
    CONSTRUCTOR FUNCTION Faktura
    (
        DataWystawienia IN DATE,
        Koszt IN NUMBER,
        Uslugi IN Lista_uslug
    ) RETURN SELF AS RESULT,
    MEMBER FUNCTION pobierzDataWystawienia RETURN DATE,
    MEMBER FUNCTION pobierzKoszt RETURN NUMBER,
    MEMBER FUNCTION pobierzUslugi RETURN Lista_uslug
);

CREATE OR REPLACE TYPE BODY Faktura AS
    CONSTRUCTOR FUNCTION Faktura
    (
        DataWystawienia IN DATE,
        Koszt IN NUMBER,
        Uslugi IN Lista_uslug
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.DataWystawienia := DataWystawienia;
        SELF.Koszt := Koszt;
        SELF.Uslugi := Uslugi;
        RETURN;
    END;

    MEMBER FUNCTION pobierzDataWystawienia RETURN DATE IS
    BEGIN
        RETURN SELF.DataWystawienia;
    END;

    MEMBER FUNCTION pobierzKoszt RETURN NUMBER IS
    BEGIN
        RETURN SELF.Koszt;
    END;

    MEMBER FUNCTION pobierzUslugi RETURN Lista_uslug IS
    BEGIN
        RETURN SELF.Uslugi;
    END;
END;
/