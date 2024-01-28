//----------------------------PLACÓWKA-------------------------------------------//


CREATE OR REPLACE TYPE Placowka AS OBJECT (

    Adres_placowki Adres,

    Pracownicy Lista_Pracownikow,

    Osoby_Prywatne_klienci Lista_osob_prywatnych,

    Firmy_klienci Lista_firm,



    -- Konstruktor

    CONSTRUCTOR FUNCTION Placowka(

        Adres_placowki IN Adres,

        Pracownicy IN Lista_Pracownikow,

        Osoby_Prywatne_klienci IN Lista_osob_prywatnych,

        Firmy_klienci IN Lista_firm

    ) RETURN SELF AS RESULT,
  MEMBER PROCEDURE dodajPracownik (p IN Pracownik),
    MEMBER PROCEDURE usunPracownik (p IN Pracownik),
    MEMBER PROCEDURE dodajOsobaPrywatna (o IN OsobaPrywatna),
    MEMBER PROCEDURE dodajFirma (f IN Firma),
MEMBER PROCEDURE usunOsobaPrywatna (o IN OsobaPrywatna),
    MEMBER PROCEDURE usunFirma (f IN Firma)

);



-- Implementacja konstruktora dla typu Placowka

CREATE OR REPLACE TYPE BODY Placowka AS

    CONSTRUCTOR FUNCTION Placowka(

        Adres_placowki IN Adres,

        Pracownicy IN Lista_Pracownikow,

        Osoby_Prywatne_klienci IN Lista_osob_prywatnych,

        Firmy_klienci IN Lista_firm

    ) RETURN SELF AS RESULT IS

    BEGIN

        SELF.Adres_placowki := Adres_placowki;

        SELF.Pracownicy := Pracownicy;

        SELF.Osoby_Prywatne_klienci := Osoby_Prywatne_klienci;

        SELF.Firmy_klienci := Firmy_klienci;

        RETURN;

    END;

	MEMBER PROCEDURE dodajPracownik (p IN Pracownik) IS
  BEGIN
    FOR i IN 1..SELF.Pracownicy.COUNT LOOP
      IF SELF.Pracownicy(i).porownajPracownik(p) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Pracownik już istnieje w liście');
      END IF;
    END LOOP;
    SELF.Pracownicy.EXTEND;
    SELF.Pracownicy(SELF.Pracownicy.COUNT) := p;
  END;

  MEMBER PROCEDURE usunPracownik (p IN Pracownik) IS
  BEGIN
    FOR i IN 1..SELF.Pracownicy.COUNT LOOP
      IF SELF.Pracownicy(i).porownajPracownik(p) THEN
        SELF.Pracownicy.DELETE(i);
        RETURN;
      END IF;
    END LOOP;
    RAISE_APPLICATION_ERROR(-20002, 'Pracownik nie istnieje w liście');
  END;

  MEMBER PROCEDURE dodajOsobaPrywatna (o IN OsobaPrywatna) IS
  BEGIN
    FOR i IN 1..SELF.Osoby_Prywatne_klienci.COUNT LOOP
      IF SELF.Osoby_Prywatne_klienci(i).porownajOsobaPrywatna(o) THEN
        RAISE_APPLICATION_ERROR(-20003, 'Osoba prywatna już istnieje w liście');
      END IF;
    END LOOP;
    SELF.Osoby_Prywatne_klienci.EXTEND;
    SELF.Osoby_Prywatne_klienci(SELF.Osoby_Prywatne_klienci.COUNT) := o;
  END;

  MEMBER PROCEDURE dodajFirma (f IN Firma) IS
  BEGIN
    FOR i IN 1..SELF.Firmy_klienci.COUNT LOOP
      IF SELF.Firmy_klienci(i).porownajFirma(f) THEN
        RAISE_APPLICATION_ERROR(-20004, 'Firma już istnieje w liście');
      END IF;
    END LOOP;
    SELF.Firmy_klienci.EXTEND;
    SELF.Firmy_klienci(SELF.Firmy_klienci.COUNT) := f;
  END;
MEMBER PROCEDURE usunOsobaPrywatna (o IN OsobaPrywatna) IS
  BEGIN
    FOR i IN 1..SELF.Osoby_Prywatne_klienci.COUNT LOOP
      IF SELF.Osoby_Prywatne_klienci(i).porownajOsobaPrywatna(o) THEN
        SELF.Osoby_Prywatne_klienci.DELETE(i);
        RETURN;
      END IF;
    END LOOP;
    RAISE_APPLICATION_ERROR(-20005, 'Osoba prywatna nie istnieje w liście');
  END;

  MEMBER PROCEDURE usunFirma (f IN Firma) IS
  BEGIN
    FOR i IN 1..SELF.Firmy_klienci.COUNT LOOP
      IF SELF.Firmy_klienci(i).porownajFirma(f) THEN
        SELF.Firmy_klienci.DELETE(i);
        RETURN;
      END IF;
    END LOOP;
    RAISE_APPLICATION_ERROR(-20006, 'Firma nie istnieje w liście');
  END;

END;
