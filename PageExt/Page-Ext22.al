pageextension 50112 "Customer List Ext" extends "Customer List"
{
    actions
    {
        addafter("&Customer")
        {
            action("Reporte Ingresos Sumimsa")
            {
                ApplicationArea = All;
                Caption = 'Reporte Ingresos Ventas';
                Image = Report;

                trigger OnAction()
                var
                    CustLedEntry: Record "Cust. Ledger Entry";
                    IngresosReport: Report "Ingresos Ventas";
                begin
                    CustLedEntry.SetRange("Customer No.", Rec."No.");
                    IngresosReport.SetTableView(CustLedEntry);
                    IngresosReport.RunModal();
                end;
            }
        }
    }
}