//-------------------------------PRACOWNIK----------------------------------------//





CREATE OR REPLACE TYPE Pracownik UNDER OsobaPrywatna

(

    Wynagrodzenie NUMBER,

    TypZatrudnienia VARCHAR2(50),

    CONSTRUCTOR FUNCTION Pracownik

    (

        Data_zawarcia_umowy IN DATE,

        Data_zakonczenia_umowy IN DATE,

        Adres_zameldowania IN Adres,

        Numer_telefonu IN VARCHAR2,

        Imie IN VARCHAR2,

        Nazwisko IN VARCHAR2,

        Pesel IN VARCHAR2,

        Uslugi IN Lista_uslug,

        Faktury IN Lista_faktur,

        Wynagrodzenie IN NUMBER,

        TypZatrudnienia IN VARCHAR2

    ) RETURN SELF AS RESULT,
MEMBER FUNCTION porownajPracownik (p IN Pracownik) RETURN BOOLEAN

) ;

/



CREATE OR REPLACE TYPE BODY Pracownik AS

    CONSTRUCTOR FUNCTION Pracownik

    (

        Data_zawarcia_umowy IN DATE,

        Data_zakonczenia_umowy IN DATE,

        Adres_zameldowania IN Adres,

        Numer_telefonu IN VARCHAR2,

        Imie IN VARCHAR2,

        Nazwisko IN VARCHAR2,

        Pesel IN VARCHAR2,

        Uslugi IN Lista_uslug,

        Faktury IN Lista_faktur,

        Wynagrodzenie IN NUMBER,

        TypZatrudnienia IN VARCHAR2

    ) RETURN SELF AS RESULT IS

    BEGIN

        -- Inicjalizacja pól dodatkowych specyficznych dla Pracownik

        SELF.Wynagrodzenie := Wynagrodzenie;

        SELF.TypZatrudnienia := TypZatrudnienia;

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

MEMBER FUNCTION porownajPracownik (p IN Pracownik) RETURN BOOLEAN IS
  BEGIN
    RETURN SELF.Imie = p.Imie AND
           SELF.Nazwisko = p.Nazwisko AND
           SELF.Pesel = p.Pesel AND
           SELF.Wynagrodzenie = p.Wynagrodzenie AND
           SELF.TypZatrudnienia = p.TypZatrudnienia;
  END;

END;

/