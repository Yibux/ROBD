//------------------------------------OSOBA PRYWATNA------------------------------------------------//
CREATE OR REPLACE TYPE OsobaPrywatna UNDER Podmiot
(
    Imie VARCHAR2(20),
    Nazwisko VARCHAR2(50),
    Pesel VARCHAR2(11),
    CONSTRUCTOR FUNCTION OsobaPrywatna
    (
        Data_zawarcia_umowy IN DATE,
        Data_zakonczenia_umowy IN DATE,
        Adres_zameldowania IN Adres,
        Numer_telefonu IN VARCHAR2,
        Imie IN VARCHAR2,
        Nazwisko IN VARCHAR2,
        Pesel IN VARCHAR2,
        Uslugi IN Lista_uslug,
        Faktury IN Lista_faktur
    ) RETURN SELF AS RESULT,
    MEMBER FUNCTION porownajOsobePrywatna (osoba IN OsobaPrywatna) RETURN BOOLEAN
);

CREATE OR REPLACE TYPE BODY OsobaPrywatna AS
    CONSTRUCTOR FUNCTION OsobaPrywatna
    (
        Data_zawarcia_umowy IN DATE,
        Data_zakonczenia_umowy IN DATE,
        Adres_zameldowania IN Adres,
        Numer_telefonu IN VARCHAR2,
        Imie IN VARCHAR2,
        Nazwisko IN VARCHAR2,
        Pesel IN VARCHAR2
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.Imie := Imie;
        SELF.Nazwisko := Nazwisko;
        SELF.Pesel := Pesel;
        SELF.Uslugi := Uslugi;
        SELF.Faktury := Faktury;
        SELF.Data_zawarcia_umowy := Data_zawarcia_umowy;
        SELF.Data_zakonczenia_umowy := Data_zakonczenia_umowy;
        SELF.Adres_zameldowania := Adres_zameldowania;
        SELF.Numer_telefonu := Numer_telefonu;
        RETURN;
    END;

    MEMBER FUNCTION porownajOsobePrywatna (osoba IN OsobaPrywatna) RETURN BOOLEAN IS
    BEGIN
        IF SELF.Imie = osoba.Imie AND SELF.Nazwisko = osoba.Nazwisko AND SELF.Pesel = osoba.Pesel THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END;
END;
/