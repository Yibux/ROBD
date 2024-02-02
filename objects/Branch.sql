//--------------------------------BRANCH----------------------------------------------------//

CREATE OR REPLACE TYPE Branch AS OBJECT (

    Branch_address Address,
    Employees Employee_List,

    CONSTRUCTOR FUNCTION Branch(
        Branch_address IN Address,
        Employees IN Employee_List

    ) RETURN SELF AS RESULT

);


CREATE OR REPLACE TYPE BODY Branch AS

    CONSTRUCTOR FUNCTION Branch(

        Branch_address IN Address,

        Employees IN Employee_List,

        Private_individual_clients IN Private_Individual_List,

        Company_clients IN Company_List

    ) RETURN SELF AS RESULT IS

    BEGIN

        SELF.Branch_address := Branch_address;

        SELF.Employees := Employees;

        SELF.Private_individual_clients := Private_individual_clients;

        SELF.Company_clients := Company_clients;

        RETURN;

    END;

END;
