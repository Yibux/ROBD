CREATE OR REPLACE TRIGGER CheckClientContractDates
BEFORE INSERT ON CLIENTSTABLE
FOR EACH ROW
DECLARE
    dateSmallerExpcetion EXCEPTION;
BEGIN
    IF :NEW.CONTRACT_END_DATE < :NEW.CONTRACT_START_DATE THEN
        RAISE dateSmallerExpcetion;
    END IF;
    EXCEPTION
        WHEN dateSmallerExpcetion THEN
            RAISE_APPLICATION_ERROR(-20001, 'Contract end date can not be before start date.');
END;
/

CREATE OR REPLACE TRIGGER CheckClientNipOrPesel
BEFORE INSERT ON CLIENTSTABLE
FOR EACH ROW
DECLARE
    INCORRECT_FORMAT EXCEPTION;
BEGIN
    IF (:NEW.PESEL IS NULL AND :NEW.NIP IS NULL) OR
       (:NEW.PESEL IS NOT NULL AND :NEW.NIP IS NOT NULL) THEN
        RAISE INCORRECT_FORMAT;
    END IF;

    IF :NEW.PESEL IS NOT NULL THEN
        IF LENGTH(:NEW.PESEL) != 11 OR NOT REGEXP_LIKE(:NEW.PESEL, '^[0-9]+$') THEN
            RAISE INCORRECT_FORMAT;
        END IF;
    ELSE
        IF LENGTH(:NEW.NIP) != 10 OR NOT REGEXP_LIKE(:NEW.NIP, '^[0-9]+$') THEN
            RAISE INCORRECT_FORMAT;
        END IF;
    END IF;

    EXCEPTION
        WHEN INCORRECT_FORMAT THEN
            RAISE_APPLICATION_ERROR(-20001, 'Incorrect format: Either PESEL or NIP must be provided, ' ||
                                            'but not both, and in the correct format.');
END;
/
