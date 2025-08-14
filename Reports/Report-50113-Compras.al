report 50113 "Ingresos Compras"
{
    Caption = 'Ingresos Compras';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(VendLedEntry; "Vendor Ledger Entry")
        {
            RequestFilterFields = "Posting Date", "Vendor No.", "Document Type", "Document No.";
            //DataItemTableView = WHERE("Document Type" = FILTER(Invoice));

            trigger OnPreDataItem()
            begin
                TempExcelBuf.DeleteAll();

                TempExcelBuf.NewRow();
                TempExcelBuf.AddColumn('Fecha de Registro', false, '', true, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn('Tipo Documento', false, '', true, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn('N° Documento', false, '', true, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn('Importe', false, '', true, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn('Divisa', false, '', true, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn('No. Proveedor', false, '', true, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn('Descripción', false, '', true, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn('Tipo Docu', false, '', true, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn('N° Documento Concilia', false, '', true, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn('Cód. Divisa', false, '', true, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn('Imp. Liq. Doc. Relacionado($)', false, '', true, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn('Imp. Liq. Doc. Relacionado', false, '', true, false, false, '', TempExcelBuf."Cell Type"::Text);
            end;

            trigger OnAfterGetRecord()
            var
                Vendor: Record Vendor;
                CurrencyCode: Code[10];
                VendorName: Text[100];
                AmountText: Text[50];
                DetailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
                AppliedVendLedgEntry: Record "Vendor Ledger Entry";
                AppliedDetailedEntry: Record "Detailed Vendor Ledg. Entry";
                OriginalAmount: Decimal;
                AppliedAmount: Decimal;
                AppliedAmountLCY: Decimal;
                HasApplications: Boolean;
            begin
                VendorName := '';
                if Vendor.Get(VendLedEntry."Vendor No.") then
                    VendorName := Vendor.Name;

                CurrencyCode := VendLedEntry."Currency Code";
                /* if CurrencyCode = '' then
                    CurrencyCode := 'MXN'; */

                OriginalAmount := 0;
                DetailedVendLedgEntry.SetRange("Vendor Ledger Entry No.", VendLedEntry."Entry No.");
                DetailedVendLedgEntry.SetRange("Entry Type", DetailedVendLedgEntry."Entry Type"::"Initial Entry");
                if DetailedVendLedgEntry.FindFirst() then
                    OriginalAmount := DetailedVendLedgEntry.Amount;

                if OriginalAmount = 0 then
                    OriginalAmount := VendLedEntry."Purchase (LCY)";

                AmountText := FormatAmountWithComma(OriginalAmount);

                HasApplications := false;
                DetailedVendLedgEntry.Reset();
                DetailedVendLedgEntry.SetRange("Vendor Ledger Entry No.", VendLedEntry."Entry No.");
                DetailedVendLedgEntry.SetRange("Entry Type", DetailedVendLedgEntry."Entry Type"::Application);
                if DetailedVendLedgEntry.FindSet() then begin
                    repeat
                        AppliedDetailedEntry.Reset();
                        AppliedDetailedEntry.SetRange("Transaction No.", DetailedVendLedgEntry."Transaction No.");
                        AppliedDetailedEntry.SetRange("Entry Type", AppliedDetailedEntry."Entry Type"::Application);
                        AppliedDetailedEntry.SetFilter("Vendor Ledger Entry No.", '<>%1', VendLedEntry."Entry No.");
                        if AppliedDetailedEntry.FindFirst() then begin
                            if AppliedVendLedgEntry.Get(AppliedDetailedEntry."Vendor Ledger Entry No.") then begin
                                HasApplications := true;

                                AppliedAmount := 0;
                                AppliedAmountLCY := 0;

                                AppliedDetailedEntry.Reset();
                                AppliedDetailedEntry.SetRange("Vendor Ledger Entry No.", AppliedVendLedgEntry."Entry No.");
                                AppliedDetailedEntry.SetRange("Entry Type", AppliedDetailedEntry."Entry Type"::"Initial Entry");
                                if AppliedDetailedEntry.FindFirst() then begin
                                    AppliedAmount := Abs(AppliedDetailedEntry.Amount);
                                    AppliedAmountLCY := Abs(AppliedDetailedEntry."Amount (LCY)");
                                end else begin
                                    if AppliedVendLedgEntry."Currency Code" <> '' then
                                        AppliedAmount := Abs(AppliedVendLedgEntry."Original Amount")
                                    else
                                        AppliedAmount := Abs(AppliedVendLedgEntry."Purchase (LCY)");
                                    AppliedAmountLCY := Abs(AppliedVendLedgEntry."Amount (LCY)");
                                end;

                                TempExcelBuf.NewRow();
                                TempExcelBuf.AddColumn(Format(VendLedEntry."Posting Date"), false, '', false, false, false, '', TempExcelBuf."Cell Type"::Date);
                                TempExcelBuf.AddColumn(Format(VendLedEntry."Document Type"), false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                                TempExcelBuf.AddColumn(VendLedEntry."Document No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                                TempExcelBuf.AddColumn(AmountText, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                                TempExcelBuf.AddColumn(CurrencyCode, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                                TempExcelBuf.AddColumn(VendLedEntry."Vendor No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                                TempExcelBuf.AddColumn(VendorName, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                                TempExcelBuf.AddColumn(Format(AppliedVendLedgEntry."Document Type"), false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                                TempExcelBuf.AddColumn(AppliedVendLedgEntry."Document No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                                TempExcelBuf.AddColumn(AppliedVendLedgEntry."Currency Code", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                                TempExcelBuf.AddColumn(FormatAmountWithComma(AppliedAmount), false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                                TempExcelBuf.AddColumn(FormatAmountWithComma(AppliedAmountLCY), false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                            end;
                        end;
                    until DetailedVendLedgEntry.Next() = 0;
                end;

                if not HasApplications then begin
                    TempExcelBuf.NewRow();
                    TempExcelBuf.AddColumn(Format(VendLedEntry."Posting Date"), false, '', false, false, false, '', TempExcelBuf."Cell Type"::Date);
                    TempExcelBuf.AddColumn(Format(VendLedEntry."Document Type"), false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                    TempExcelBuf.AddColumn(VendLedEntry."Document No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                    TempExcelBuf.AddColumn(AmountText, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                    TempExcelBuf.AddColumn(CurrencyCode, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                    TempExcelBuf.AddColumn(VendLedEntry."Vendor No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                    TempExcelBuf.AddColumn(VendorName, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                    TempExcelBuf.AddColumn('', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                    TempExcelBuf.AddColumn('', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                    TempExcelBuf.AddColumn('', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                    TempExcelBuf.AddColumn('0,00', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                    TempExcelBuf.AddColumn('0,00', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                end;
            end;

            trigger OnPostDataItem()
            begin
                TempExcelBuf.CreateNewBook('Ingresos Compras');
                TempExcelBuf.WriteSheet('Ingresos Compras', CompanyName, UserId);
                TempExcelBuf.CloseBook();
                TempExcelBuf.SetFriendlyFilename('Ingresos_Compras_' + Format(Today, 0, '<Year4><Month,2><Day,2>'));
                TempExcelBuf.OpenExcel();
            end;
        }
    }

    var
        TempExcelBuf: Record "Excel Buffer" temporary;

    local procedure FormatAmountWithComma(Amount: Decimal): Text[50]
    var
        FormattedAmount: Text[50];
    begin
        FormattedAmount := Format(Amount, 0, '<Precision,2><Standard Format,0>');

        FormattedAmount := FormattedAmount.Replace('.', ',');

        exit(FormattedAmount);
    end;
}