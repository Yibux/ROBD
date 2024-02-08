DECLARE
    client_ref REF ClientObj;
    service_ref REF SERVICE;
    employee_ref REF EMPLOYEE;
    order_date DATE;
BEGIN

    SELECT REF(c) INTO client_ref FROM ClientsTable c WHERE CLIENTID = 29;
    SELECT REF(s) INTO service_ref FROM ServiceTable s WHERE SERVICEID = 27;
    SELECT REF(e) INTO employee_ref FROM EmployeesTable e WHERE ROWNUM = 1;
    order_date := SYSDATE;

    ORDERPACKAGE.CREATEORDER(client_ref,service_ref,employee_ref);

END;

SELECT * FROM ClientsOrdersTable;