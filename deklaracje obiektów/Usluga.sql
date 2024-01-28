//--------------------------------USŁUGA----------------------------------------------------//
CREATE OR REPLACE TYPE Usluga AS OBJECT
(
    Opis VARCHAR2(100),
    Cena NUMBER,
    CONSTRUCTOR FUNCTION Usluga
    (
        Opis IN VARCHAR2,
        Cena IN NUMBER
    ) RETURN SELF AS RESULT,
    MEMBER FUNCTION pobierzOpis RETURN VARCHAR2,
    MEMBER FUNCTION pobierzCene RETURN NUMBER,
    MEMBER FUNCTION porownajUsluge (usluga IN Usluga) RETURN BOOLEAN
);

/

CREATE OR REPLACE TYPE BODY Usluga AS
    CONSTRUCTOR FUNCTION Usluga
    (
        Opis IN VARCHAR2,
        Cena IN NUMBER
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.Opis := Opis;
        SELF.Cena := Cena;
        RETURN;
    END;

    MEMBER FUNCTION pobierzOpis RETURN VARCHAR2 IS
    BEGIN
        RETURN SELF.Opis;
    END;

    MEMBER FUNCTION pobierzCene RETURN NUMBER IS
    BEGIN
        RETURN SELF.Cena;
    END;

    MEMBER FUNCTION porownajUsluge (usluga IN Usluga) RETURN BOOLEAN IS
    BEGIN
        IF SELF.ID = usluga.ID AND SELF.Opis = usluga.Opis AND SELF.Cena = usluga.Cena THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END;
END;

/