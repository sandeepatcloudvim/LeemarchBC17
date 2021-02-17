tableextension 50019 ExtendSalesCommentLine extends "Sales Comment Line"
{
    fields
    {
        field(50000; "User ID"; Code[10])
        {

        }
        field(50001; "System Comment"; Boolean)
        {

        }
        field(50002; "Date Created"; Date)
        {

        }
        field(50003; "Time Created"; Time)
        {

        }
        field(50004; "Custom Order Note"; Boolean)
        {

        }
    }

    var
        myInt: Integer;
}