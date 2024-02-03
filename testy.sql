//-------------------TEST----------------//
drop table mamdosc;
/
drop table aaaa;
/
drop table yy;
/
drop type tesBIG;
/
drop type tes_list;
/
drop type MOPSIK;
/


CREATE OR REPLACE TYPE MOPSIK AS OBJECT
(
    adr_ref REF ADDRESS,
    adr_serv REF Service,

    CONSTRUCTOR FUNCTION MOPSIK(
        adr_ref_param REF ADDRESS,
        adr_serv_param REF Service
    ) RETURN SELF AS RESULT
)
NOT FINAL;
/

CREATE OR REPLACE TYPE BODY MOPSIK AS
    CONSTRUCTOR FUNCTION MOPSIK(
        adr_ref_param REF ADDRESS,
        adr_serv_param REF Service)
        RETURN SELF AS RESULT IS
    BEGIN
        adr_ref := adr_ref_param;
        adr_serv := adr_serv_param;
        RETURN;
    END;
END;
/

-- Definicja typu tes_list
CREATE OR REPLACE TYPE tes_list AS VARRAY(10) OF MOPSIK;



-- Specyfikacja obiektu tesBIG
CREATE OR REPLACE TYPE tesBIG AS OBJECT
(
    lista tes_list,
    CONSTRUCTOR FUNCTION tesBIG(
        lista tes_list
    ) RETURN SELF AS RESULT
)
NOT FINAL;
/

-- Ciało obiektu tesBIG
CREATE OR REPLACE TYPE BODY tesBIG AS
    CONSTRUCTOR FUNCTION tesBIG(
        lista tes_list
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.lista := lista; -- Przypisanie przekazanej listy do pola lista
        RETURN;
    END;
END;
/

drop table mamdosc;
drop table aaaa;
drop table yy;

CREATE TABLE mamdosc OF tesBIG;
create table aaaa of Service;
create table yy of Address;

-- Sample data for Address and Service tables
INSERT INTO yy VALUES (Address('Address1', 'City1', 'Country1', '111', '111'));
INSERT INTO aaaa VALUES (Service('Service1', 5));

-- Create an instance of MOPSIK
DECLARE
    adr_ref_ref REF ADDRESS;
    adr_serv_ref REF Service;
    asd MOPSIK;
BEGIN
    SELECT REF(a) INTO adr_ref_ref FROM yy a WHERE ROWNUM = 1;
    SELECT REF(s) INTO adr_serv_ref FROM aaaa s WHERE ROWNUM = 1;

--     asd := MOPSIK(adr_ref_ref, adr_serv_ref);
END;

-- Create a list of MOPSIK objects
DECLARE
    tes_list_obj tes_list := tes_list();
BEGIN
    FOR i IN 1..tes_list_obj.COUNT LOOP
        SELECT REF(a), REF(s) INTO tes_list_obj(i).adr_ref, tes_list_obj(i).adr_serv
        FROM yy a, AAAA s
        WHERE ROWNUM = 1;
    END LOOP;
END;


-- Create an instance of tesBIG with the tes_list
DECLARE
    adr_ref_ref REF ADDRESS;
    adr_serv_ref REF Service;
    tes_list_obj tes_list := tes_list();
    tes_big_obj tesBIG;
BEGIN

    FOR i IN 1..2 LOOP
        SELECT REF(a), REF(s) INTO tes_list_obj(i).adr_ref, tes_list_obj(i).adr_serv
        FROM yy a, AAAA s
        WHERE ROWNUM = 1;
        tes_list_obj.EXTEND;
    END LOOP;

    tes_big_obj := tesBIG(tes_list_obj);

    -- Insert the tesBIG object into the mamdosc table
    INSERT INTO mamdosc VALUES (tes_big_obj);

    COMMIT;
END;

select * from mamdosc;