pageextension 50114 "Vendor List Ext" extends "Vendor List"
{
    actions
    {
        addafter(Items)
        {
            action("Reporte Ingresos Compras")
            {
                ApplicationArea = All;
                Caption = 'Reporte Ingresos Compras';
                Image = Report;

                trigger OnAction()
                var
                    VendLedEntry: Record "Vendor Ledger Entry";
                    IngresosComprasReport: Report "Ingresos Compras";
                begin
                    VendLedEntry.SetRange("Vendor No.", Rec."No.");
                    IngresosComprasReport.SetTableView(VendLedEntry);
                    IngresosComprasReport.RunModal();
                end;
            }
        }
    }
}
