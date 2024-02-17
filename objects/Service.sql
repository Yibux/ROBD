//--------------------------------SERVICE----------------------------------------------------//
CREATE SEQUENCE ServiceSequence START WITH 1 INCREMENT BY 1;
/

CREATE OR REPLACE TYPE Service AS OBJECT
(
    ServiceId Number,
    Description VARCHAR2(100),
    Price NUMBER
);

/

-- CREATE OR REPLACE TYPE BODY Service AS
--     CONSTRUCTOR FUNCTION Service
--     (
--         newId IN NUMBER,
--         Description IN VARCHAR2,
--         Price IN NUMBER
--     ) RETURN SELF AS RESULT IS
--     BEGIN
--         SELF.ServiceId := newId;
--         SELF.Description := Description;
--         SELF.Price := Price;
--         RETURN;
--     END;
-- END;

/
create table ServiceTable of Service (PRIMARY KEY (ServiceId));


INSERT INTO SERVICETABLE VALUES (SERVICE(SERVICESEQUENCE.nextval ,'lallala', 1234));

SELECT object_name, object_type
FROM user_objects
WHERE object_name = 'SERVICE';
