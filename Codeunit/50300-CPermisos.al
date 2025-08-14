codeunit 50120 "Update Purchase Invoice"
{
    Permissions = tabledata "Purch. Inv. Header" = rim;

    procedure UpdateFroToPayInfo(DocumentNo: Code[20]; FroToPay: Text[35])
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        if PurchInvHeader.Get(DocumentNo) then begin
            PurchInvHeader."Form to Pay" := FroToPay;
            PurchInvHeader.Modify(true);
        end;
    end;

    procedure GetFroToPayInfo(DocumentNo: Code[20]; var FroToPay: Text[35])
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        FroToPay := '';

        if PurchInvHeader.Get(DocumentNo) then begin
            FroToPay := PurchInvHeader."Form to Pay";
        end;
    end;
}