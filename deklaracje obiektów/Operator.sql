//--------------------------------OPEARATOR----------------------------------------------------//

CREATE OR REPLACE TYPE Operator AS OBJECT
(
    Data_zalozenia DATE,
    Wlasciciel VARCHAR2(100),
    Uslugi Lista_uslug,
    CONSTRUCTOR FUNCTION Operator
    (
        Data_zalozenia IN DATE,
        Wlasciciel IN VARCHAR2,
        Uslugi IN Lista_uslug
    ) RETURN SELF AS RESULT,
    MEMBER PROCEDURE dodajUsluge (usluga IN Usluga),
    MEMBER FUNCTION porownajOperatora (operator IN Operator) RETURN BOOLEAN
);

CREATE OR REPLACE TYPE BODY Operator AS
    CONSTRUCTOR FUNCTION Operator
    (
        Data_zalozenia IN DATE,
        Wlasciciel IN VARCHAR2,
        Uslugi IN Lista_uslug
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.Data_zalozenia := Data_zalozenia;
        SELF.Wlasciciel := Wlasciciel;
        SELF.Uslugi := Uslugi;
        RETURN;
    END;

    MEMBER PROCEDURE dodajUsluge (usluga IN Usluga) IS
    BEGIN
        SELF.Uslugi.EXTEND;
        SELF.Uslugi(SELF.Uslugi.COUNT) := usluga;
    END;

    MEMBER FUNCTION porownajOperatora (operator IN Operator) RETURN BOOLEAN IS
    BEGIN
        IF SELF.Data_zalozenia = operator.Data_zalozenia AND SELF.Wlasciciel = operator.Wlasciciel THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END;
END;
/