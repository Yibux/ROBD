//------------------------------------FIRMA------------------------------------------------//





CREATE OR REPLACE TYPE Firma UNDER Podmiot

(

    Nazwa_firmy VARCHAR2(150),

    NIP VARCHAR2(11),

    Regon VARCHAR2(17)

    CONSTRUCTOR FUNCTION Firma

    (

        Data_zawarcia_umowy IN DATE,

        Data_zakonczenia_umowy IN DATE,

        Adres_zameldowania IN Adres,

        Numer_telefonu IN VARCHAR2,

        Nazwa_firmy IN VARCHAR2,

        NIP IN VARCHAR2,

        Regon IN VARCHAR2,

        Uslugi IN Lista_uslug,

        Faktury IN Lista_faktur

    ) RETURN SELF AS RESULT,
MEMBER FUNCTION porownajFirme ( firma_ IN Firma)RETURN BOOLEAN

);

/



CREATE OR REPLACE TYPE BODY Firma AS

    CONSTRUCTOR FUNCTION Firma

    (

        Data_zawarcia_umowy IN DATE,

        Data_zakonczenia_umowy IN DATE,

        Adres_zameldowania IN Adres,

        Numer_telefonu IN VARCHAR2,

        Nazwa_firmy IN VARCHAR2,

        NIP IN VARCHAR2,

        Regon IN VARCHAR2,

        Uslugi IN Lista_uslug,

        Faktury IN Lista_faktur

    ) RETURN SELF AS RESULT IS

    BEGIN

        -- Inicjalizacja pól dodatkowych specyficznych dla OsobaPrywatna

        SELF.Nazwa_firmy := Nazwa_firmy;

        SELF.NIP := NIP;

        SELF.Regon := Regon;

        SELF.Uslugi := Uslugi;

        SELF.Faktury := Faktury;

        SELF.Data_zawarcia_umowy := Data_zawarcia_umowy;

        SELF.Data_zakonczenia_umowy := Data_zakonczenia_umowy;

        SELF.Adres_zameldowania := Adres_zameldowania;

        SELF.Numer_telefonu := Numer_telefonu;

        RETURN;

    END;

MEMBER FUNCTION porownajFirme ( firma_ IN Firma) RETURN BOOLEAN IS
    BEGIN
        IF SELF.NIP = firma_.NIP AND SELF.Regon = firma_.Regon THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END;

END;

