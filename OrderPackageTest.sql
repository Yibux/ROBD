DECLARE
    client_ref REF ClientObj;
    service_ref REF SERVICE;
    employee_ref REF EMPLOYEE;
    order_date DATE;
BEGIN

--     SELECT REF(c) INTO client_ref FROM ClientsTable c WHERE PERSONID = 15;
--     SELECT REF(s) INTO service_ref FROM ServiceTable s WHERE SERVICEID = 16;
--     SELECT REF(e) INTO employee_ref FROM EmployeesTable e WHERE EMPLOYEEID = 47;
--     order_date := SYSDATE;
--
--     ORDERPACKAGE.CREATEORDER(client_ref,service_ref,employee_ref);

--     ORDERPACKAGE.SHOWORDERSBYCLIENT(15);
    ORDERPACKAGE.SHOWORDERSBYEMPLOYEE(47);





END;

SELECT * FROM ClientsOrdersTable;
SELECT * FROM EmployeesTable;
SELECT * FROM ClientsTable;
SELECT * FROM ServiceTable;