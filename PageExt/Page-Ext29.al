pageextension 50121 "Vendor Ledger Entries Ext" extends "Vendor Ledger Entries"
{
    actions
    {
        addfirst(processing)
        {
            action(VerMovimientosProv)
            {
                ApplicationArea = All;
                Caption = 'Movimientos Proveedor Liq.';
                Image = Table;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Abre la tabla de movimientos de proveedor';

                trigger OnAction()
                var
                    MovProvePage: Page "Movimientos Proveedor List";
                begin
                    MovProvePage.Run();
                end;
            }
        }
    }
}