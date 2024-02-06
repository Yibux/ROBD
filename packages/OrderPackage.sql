drop package OrderPackage;
/

CREATE OR REPLACE PACKAGE OrderPackage AS

    PROCEDURE ShowOrdersByClient(ClientId IN NUMBER);

    PROCEDURE ShowOrdersByEmployee(EmployeeId IN NUMBER);

END OrderPackage;
/

CREATE OR REPLACE PACKAGE BODY OrderPackage AS



    PROCEDURE ShowOrdersByClient(ClientId IN NUMBER) IS
    BEGIN
        FOR order_rec IN (SELECT * FROM ClientsOrdersTable WHERE DEREF(SingleClient).ClientId = ShowOrdersByClient.ClientId) LOOP
            DBMS_OUTPUT.PUT_LINE('Order Id: ' || order_rec.OrderId);
        END LOOP;
    END ShowOrdersByClient;

    PROCEDURE ShowOrdersByEmployee(EmployeeId IN NUMBER) IS
    BEGIN
        FOR order_rec IN (SELECT * FROM ClientsOrdersTable WHERE DEREF(SingleEmployee).EmployeeId = ShowOrdersByEmployee.EmployeeId) LOOP
            DBMS_OUTPUT.PUT_LINE('Order Id: ' || order_rec.OrderId);
        END LOOP;
    END ShowOrdersByEmployee;


END OrderPackage;
/
