CREATE OR REPLACE PACKAGE OrderPackage AS

    PROCEDURE ShowOrdersByClient(Client_Id IN NUMBER);
--
    PROCEDURE ShowOrdersByEmployee(Employee_Id IN NUMBER);

    PROCEDURE CreateOrder(clientref IN REF ClientObj,service IN REF Service,employee IN REF Employee);

END OrderPackage;
/

CREATE OR REPLACE PACKAGE BODY OrderPackage AS

    PROCEDURE ShowOrdersByClient(Client_Id IN NUMBER) IS
    BEGIN
        FOR order_rec IN (SELECT * FROM ClientsOrdersTable WHERE DEREF(SingleClient).PersonId = Client_Id) LOOP
            DBMS_OUTPUT.PUT_LINE('Order Id: ' || order_rec.OrderId);
        END LOOP;

    END ShowOrdersByClient;

    PROCEDURE ShowOrdersByEmployee(Employee_Id IN NUMBER) IS
    BEGIN
        FOR order_rec IN (SELECT * FROM ClientsOrdersTable WHERE DEREF(SingleEmployee).EmployeeId = Employee_Id) LOOP
            DBMS_OUTPUT.PUT_LINE('Order Id: ' || order_rec.OrderId);
        END LOOP;
    END ShowOrdersByEmployee;

    PROCEDURE CreateOrder(clientref IN REF ClientObj,service IN REF Service,employee IN REF Employee) IS
        singleOrder CLIENTORDER := ClientOrder(clientref, service, employee, SYSDATE);
    BEGIN
        singleOrder.OrderId := ORDERSEQUENCE.nextval;
        INSERT INTO ClientsOrdersTable VALUES singleOrder;
        commit;

        DBMS_OUTPUT.PUT_LINE('Order created!');
    END CreateOrder;

END OrderPackage;
/