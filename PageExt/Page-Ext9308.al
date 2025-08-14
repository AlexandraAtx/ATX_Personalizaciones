pageextension 50117 "Purchase Invoice" extends "Purchase Invoice"
{
    layout
    {
        modify("Form to Pay")
        {
            Caption = 'Metodo';
        }
    }
    actions
    {
    }
    var
        myInt: Integer;
}