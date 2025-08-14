report 50112 "Ingresos Ventas"
{
    Caption = 'Ingresos Ventas';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(CustLedEntry; "Cust. Ledger Entry")
        {
            RequestFilterFields = "Posting Date", "Customer No.", "Document Type", "Document No.";
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
                TempExcelBuf.AddColumn('No. Cliente', false, '', true, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn('Descripción', false, '', true, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn('Tipo Docu', false, '', true, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn('N° Documento Concilia', false, '', true, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn('Cód. Divisa', false, '', true, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn('Imp. Liq. Doc. Relacionado', false, '', true, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn('($)Imp. Liq. Doc. Relacionado', false, '', true, false, false, '', TempExcelBuf."Cell Type"::Text);
            end;

            trigger OnAfterGetRecord()
            var
                Customer: Record Customer;
                CurrencyCode: Code[10];
                CustomerName: Text[100];
                AmountText: Text[50];
                DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                AppliedCustLedgEntry: Record "Cust. Ledger Entry";
                AppliedDetailedEntry: Record "Detailed Cust. Ledg. Entry";
                OriginalAmount: Decimal;
                AppliedAmount: Decimal;
                AppliedAmountLCY: Decimal;
                HasApplications: Boolean;
            begin
                CustomerName := '';
                if Customer.Get(CustLedEntry."Customer No.") then
                    CustomerName := Customer.Name;

                CurrencyCode := CustLedEntry."Currency Code";
                /* if CurrencyCode = '' then
                    CurrencyCode := 'MXN'; */

                OriginalAmount := 0;
                DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", CustLedEntry."Entry No.");
                DetailedCustLedgEntry.SetRange("Entry Type", DetailedCustLedgEntry."Entry Type"::"Initial Entry");
                if DetailedCustLedgEntry.FindFirst() then
                    OriginalAmount := DetailedCustLedgEntry.Amount;

                if OriginalAmount = 0 then
                    OriginalAmount := CustLedEntry."Sales (LCY)";

                AmountText := FormatAmountWithComma(OriginalAmount);

                HasApplications := false;
                DetailedCustLedgEntry.Reset();
                DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", CustLedEntry."Entry No.");
                DetailedCustLedgEntry.SetRange("Entry Type", DetailedCustLedgEntry."Entry Type"::Application);
                if DetailedCustLedgEntry.FindSet() then begin
                    repeat
                        AppliedDetailedEntry.Reset();
                        AppliedDetailedEntry.SetRange("Transaction No.", DetailedCustLedgEntry."Transaction No.");
                        AppliedDetailedEntry.SetRange("Entry Type", AppliedDetailedEntry."Entry Type"::Application);
                        AppliedDetailedEntry.SetFilter("Cust. Ledger Entry No.", '<>%1', CustLedEntry."Entry No.");
                        if AppliedDetailedEntry.FindFirst() then begin
                            if AppliedCustLedgEntry.Get(AppliedDetailedEntry."Cust. Ledger Entry No.") then begin
                                HasApplications := true;

                                AppliedAmount := 0;
                                AppliedAmountLCY := 0;

                                AppliedDetailedEntry.Reset();
                                AppliedDetailedEntry.SetRange("Cust. Ledger Entry No.", AppliedCustLedgEntry."Entry No.");
                                AppliedDetailedEntry.SetRange("Entry Type", AppliedDetailedEntry."Entry Type"::"Initial Entry");
                                if AppliedDetailedEntry.FindFirst() then begin
                                    AppliedAmount := Abs(AppliedDetailedEntry.Amount);
                                    AppliedAmountLCY := Abs(AppliedDetailedEntry."Amount (LCY)");
                                end else begin
                                    if AppliedCustLedgEntry."Currency Code" <> '' then
                                        AppliedAmount := Abs(AppliedCustLedgEntry."Original Amount")
                                    else
                                        AppliedAmount := Abs(AppliedCustLedgEntry."Sales (LCY)");
                                    AppliedAmountLCY := Abs(AppliedCustLedgEntry."Amount (LCY)");
                                end;

                                TempExcelBuf.NewRow();
                                TempExcelBuf.AddColumn(Format(CustLedEntry."Posting Date"), false, '', false, false, false, '', TempExcelBuf."Cell Type"::Date);
                                TempExcelBuf.AddColumn(Format(CustLedEntry."Document Type"), false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                                TempExcelBuf.AddColumn(CustLedEntry."Document No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                                TempExcelBuf.AddColumn(AmountText, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                                TempExcelBuf.AddColumn(CurrencyCode, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                                TempExcelBuf.AddColumn(CustLedEntry."Customer No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                                TempExcelBuf.AddColumn(CustomerName, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                                TempExcelBuf.AddColumn(Format(AppliedCustLedgEntry."Document Type"), false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                                TempExcelBuf.AddColumn(AppliedCustLedgEntry."Document No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                                TempExcelBuf.AddColumn(AppliedCustLedgEntry."Currency Code", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                                TempExcelBuf.AddColumn(FormatAmountWithComma(AppliedAmount), false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                                TempExcelBuf.AddColumn(FormatAmountWithComma(AppliedAmountLCY), false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                            end;
                        end;
                    until DetailedCustLedgEntry.Next() = 0;
                end;

                if not HasApplications then begin
                    TempExcelBuf.NewRow();
                    TempExcelBuf.AddColumn(Format(CustLedEntry."Posting Date"), false, '', false, false, false, '', TempExcelBuf."Cell Type"::Date);
                    TempExcelBuf.AddColumn(Format(CustLedEntry."Document Type"), false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                    TempExcelBuf.AddColumn(CustLedEntry."Document No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                    TempExcelBuf.AddColumn(AmountText, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                    TempExcelBuf.AddColumn(CurrencyCode, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                    TempExcelBuf.AddColumn(CustLedEntry."Customer No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                    TempExcelBuf.AddColumn(CustomerName, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                    TempExcelBuf.AddColumn('', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                    TempExcelBuf.AddColumn('', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                    TempExcelBuf.AddColumn('', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                    TempExcelBuf.AddColumn('0,00', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                    TempExcelBuf.AddColumn('0,00', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                end;
            end;

            trigger OnPostDataItem()
            begin
                TempExcelBuf.CreateNewBook('Ingresos Sumimsa');
                TempExcelBuf.WriteSheet('Ingresos Sumimsa', CompanyName, UserId);
                TempExcelBuf.CloseBook();
                TempExcelBuf.SetFriendlyFilename('Ingresos_Sumimsa_' + Format(Today, 0, '<Year4><Month,2><Day,2>'));
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