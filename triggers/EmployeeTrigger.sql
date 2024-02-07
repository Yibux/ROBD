CREATE OR REPLACE TRIGGER CheckContractDates
BEFORE INSERT OR UPDATE OF EMPLOYEESTABLE
FOR EACH ROW
DECLARE
    dateSmallerExpcetion EXCEPTION;
BEGIN
    IF :NEW.CONTRACT_END_DATE < :NEW.CONTRACT_START_DATE THEN
        RAISE dateSmallerExpcetionl;
    END IF;
    EXCEPTION
        WHEN dateSmallerExpcetion THEN
            RAISE_APPLICATION_ERROR(-20001, 'Contract end date can not be before start date.');
END;
/
