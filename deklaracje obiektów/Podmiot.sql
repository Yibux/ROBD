//------------------------------------PODMIOT------------------------------------------------//





create or replace type Podmiot as object (

  Data_zawarcia_umowy DATE,

  Data_zakonczenia_umowy DATE,

  Adres_zameldowania Adres,

  Numer_telefonu VARCHAR(12),
	Uslugi Lista_uslug,
    Faktury Lista_faktur,

  CONSTRUCTOR FUNCTION Podmiot

    (

         Data_zawarcia_umowy IN DATE,

        Data_zakonczenia_umowy IN DATE,

        Adres_zameldowania IN Adres,

        Numer_telefonu IN VARCHAR2

    ) RETURN SELF AS RESULT,
MEMBER PROCEDURE dodajUsluge (usluga IN Usluga),
    MEMBER PROCEDURE usunUsluge (usluga IN Usluga),
 MEMBER PROCEDURE dodajFakture (faktura IN Faktura),

) instantiable not final;

/



CREATE OR REPLACE TYPE BODY Podmiot AS

    CONSTRUCTOR FUNCTION Podmiot

    (

        Data_zawarcia_umowy IN DATE,

        Data_zakonczenia_umowy IN DATE,

        Adres_zameldowania IN Adres,

        Numer_telefonu IN VARCHAR2

    ) RETURN SELF AS RESULT IS

    BEGIN

        SELF.Data_zawarcia_umowy := Data_zawarcia_umowy;

        SELF.Data_zakonczenia_umowy := Data_zakonczenia_umowy;

        SELF.Adres_zameldowania := Adres_zameldowania;

        SELF.Numer_telefonu := Numer_telefonu;

        RETURN;

    END;

MEMBER PROCEDURE dodajUsluge (usluga IN Usluga) IS
    BEGIN
        FOR i IN 1..SELF.Uslugi.COUNT LOOP
            IF SELF.Uslugi(i).porownajUsluge(usluga) THEN
                RAISE_APPLICATION_ERROR(-20001, 'Usługa już istnieje w liście');
            END IF;
        END LOOP;
        SELF.Uslugi.EXTEND;
        SELF.Uslugi(SELF.Uslugi.COUNT) := usluga;
    END;

    MEMBER PROCEDURE usunUsluge (usluga IN Usluga) IS
    BEGIN
        FOR i IN 1..SELF.Uslugi.COUNT LOOP
            IF SELF.Uslugi(i).porownajUsluge(usluga) THEN
                SELF.Uslugi.DELETE(i);
                RETURN;
            END IF;
        END LOOP;
        RAISE_APPLICATION_ERROR(-20002, 'Usługa nie istnieje w liście');
    END;

    MEMBER PROCEDURE dodajFakture (faktura IN Faktura) IS
  BEGIN
    FOR i IN 1..SELF.Faktury.COUNT LOOP
      IF SELF.Faktury(i).porownajFakture(faktura) THEN
        RAISE_APPLICATION_ERROR(-20003, 'Faktura już istnieje w liście');
      END IF;
    END LOOP;
    SELF.Faktury.EXTEND;
    SELF.Faktury(SELF.Faktury.COUNT) := faktura;
  END;

END;

/