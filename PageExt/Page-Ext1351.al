pageextension 50119 "Posted Purch. Invoice - Update" extends "Posted Purch. Invoice - Update"
{
    layout
    {
        addafter("Payment Method Code")
        {
            field("Form to Pay"; FroToPayTxt)
            {
                ApplicationArea = all;
                Editable = true;
                Caption = 'Metodo';
                TableRelation = "SAT Payment Method";

                trigger OnValidate()
                begin
                    UpdatePurchInvHeader();
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        UpdatePurchInvCodeunit: Codeunit "Update Purchase Invoice";
    begin
        UpdatePurchInvCodeunit.GetFroToPayInfo(Rec."No.", FroToPayTxt);
    end;


    local procedure UpdatePurchInvHeader()
    var
        UpdatePurchInvCodeunit: Codeunit "Update Purchase Invoice";
    begin
        UpdatePurchInvCodeunit.UpdateFroToPayInfo(Rec."No.", FroToPayTxt);
    end;

    var
        FroToPayTxt: Text[35];
}