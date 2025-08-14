pageextension 50118 "Purchase Credit Memo Ext" extends "Purchase Credit Memo"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Form to Pay"; Rec."Form to Pay")
            {
                Caption = 'Metodo';
                ApplicationArea = All;
            }
        }
    }
}