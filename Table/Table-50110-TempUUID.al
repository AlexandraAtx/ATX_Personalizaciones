table 50110 "TempAppliedInvoicesInfo"
{
    TableType = Temporary;

    fields
    {
        field(1; "Entry No."; Integer) { }
        field(2; "Document No."; Code[20]) { }
        field(3; "Posting Date"; Date) { }
        field(4; "Payment Method Code"; Code[10]) { }
        field(5; "Form to Pay Code"; Code[10]) { }
        field(6; "Source Code"; Code[10]) { }
        field(7; "Journal Batch Name"; Code[10]) { }
        field(8; "Fiscal Invoice Number"; Text[100]) { }
        field(9; "Vendor No."; Code[20]) { }
        //field(10; "Document Type"; Enum "Document Type") { }
    }

    keys
    {
        key(PK; "Entry No.", "Document No.") { }
    }
}
