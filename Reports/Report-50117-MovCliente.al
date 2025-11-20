report 50117 "MovimientosCliente"
{
    Caption = 'Movimientos Cliente';
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/Cliente/MovimientosCliente.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(CustomerLedger; "Cust. Ledger Entry")
        {
            RequestFilterFields = "Customer No.", "Document Type", "Posting Date";

            dataitem(MovimientosYLiquidaciones; "Integer")
            {
                column(CompanyName; CompanyName) { }
                column(FechaGeneracionReporte; Today()) { }
                column(RangoFechas; RangoFechasTxt) { }
                column(TipoMovimiento; TipoMovimientoTxt) { }
                column(DocumentoOrigen; DocumentoOrigenTxt) { }
                column(PostingDate; PostingDateOut) { }
                column(FechaLiquidacion; FechaLiquidacionOut) { }
                column(DocumentType; DocumentTypeOut) { }
                column(DocumentNo; DocumentNoOut) { }
                column(ExternalDocNo; ExternalDocNoOut) { }
                column(Amount; AmountOut) { }
                column(AmountLCY; AmountLCYOut) { }
                column(CurrencyCode; CurrencyCodeOut) { }
                column(PaymentMethodCode; PaymentMethodCodeOut) { }
                column(FormToPay; FormToPayOut) { }
                column(CustomerNo; CustomerNoOut) { }
                column(CustomerName; CustomerNameOut) { }
                column(Description; DescriptionOut) { }
                column(UUID; UUIDOut) { }
                column(DateTimeStamped; DateTimeStampedOut) { }
                column(ElectronicStatus; ElectronicStatusOut) { }
                column(UserID; UserIDOut) { }
                column(FechaCreacion; WorkDate()) { }
                column(TipoCambio; TipoCambioTxt) { }
                column(EstatusCancelacion; EstatusCancelacionTxt) { }
                column(TipoRelacion; TipoRelacionTxt) { }
                column(UUIDRelacionado; UUIDRelacionadoTxt) { }
                column(AmountLiquidacion; AmountLiquidacion) { }
                column(AmountLCYLiquidacion; AmountLCYLiquidacion) { }
                // Dimensiones
                column(Dimension1Value; GetDimensionValue(DimensionSetIDOut, 1)) { }
                column(Dimension2Value; GetDimensionValue(DimensionSetIDOut, 2)) { }
                column(Dimension3Value; GetDimensionValue(DimensionSetIDOut, 3)) { }
                column(Dimension4Value; GetDimensionValue(DimensionSetIDOut, 4)) { }
                column(Dimension5Value; GetDimensionValue(DimensionSetIDOut, 5)) { }
                column(Dimension6Value; GetDimensionValue(DimensionSetIDOut, 6)) { }
                column(Dimension7Value; GetDimensionValue(DimensionSetIDOut, 7)) { }
                column(Dimension8Value; GetDimensionValue(DimensionSetIDOut, 8)) { }
                column(Dimension1Name; GetDimensionNameByIndex(1)) { }
                column(Dimension2Name; GetDimensionNameByIndex(2)) { }
                column(Dimension3Name; GetDimensionNameByIndex(3)) { }
                column(Dimension4Name; GetDimensionNameByIndex(4)) { }
                column(Dimension5Name; GetDimensionNameByIndex(5)) { }
                column(Dimension6Name; GetDimensionNameByIndex(6)) { }
                column(Dimension7Name; GetDimensionNameByIndex(7)) { }
                column(Dimension8Name; GetDimensionNameByIndex(8)) { }
                column(DimensionSetID; DimensionSetIDOut) { }
                column(RemainingAmount; RemainingAmountOut) { }
                column(SourceCode; SourceCodeOut) { }
                column(PaymentDimensionSetID; DimensionSetIDOut) { }
                column(PaymentSourceCode; SourceCodeOut) { }

                trigger OnPreDataItem()
                begin
                    // MODIFICADO: Ahora usamos TotalDetailedEntries que incluye movimientos individuales
                    SetRange(Number, 1, 1 + TotalDetailedEntries);

                    if (FechaInicio <> 0D) and (FechaFin <> 0D) then
                        RangoFechasTxt := Format(FechaInicio) + '...' + Format(FechaFin)
                    else
                        RangoFechasTxt := 'Todas las fechas';
                end;

                trigger OnAfterGetRecord()
                var
                    TempCustLedger: Record "Cust. Ledger Entry";
                    SignoLiquidacion: Decimal;
                    CurrentDetailedEntry: Record "Detailed Cust. Ledg. Entry";
                begin
                    Clear(TipoCambioTxt);
                    Clear(EstatusCancelacionTxt);
                    Clear(TipoRelacionTxt);
                    Clear(UUIDRelacionadoTxt);
                    Clear(AmountLiquidacion);
                    Clear(AmountLCYLiquidacion);
                    Clear(FormToPayTxt);
                    Clear(FechaLiquidacionOut);

                    TempCustLedger := SavedCustomerLedger;

                    if Number = 1 then begin
                        // Movimiento inicial
                        TipoMovimientoTxt := 'Mov. Inicial';
                        DocumentoOrigenTxt := TempCustLedger."Document No.";

                        PostingDateOut := TempCustLedger."Posting Date";
                        FechaLiquidacionOut := 0D;
                        DocumentTypeOut := Format(TempCustLedger."Document Type");
                        DocumentNoOut := TempCustLedger."Document No.";
                        ExternalDocNoOut := TempCustLedger."External Document No.";
                        AmountOut := TempCustLedger.Amount;
                        AmountLCYOut := TempCustLedger."Amount (LCY)";
                        if TempCustLedger."Currency Code" = '' then
                            CurrencyCodeOut := 'MXN'
                        else
                            CurrencyCodeOut := TempCustLedger."Currency Code";

                        PaymentMethodCodeOut := TempCustLedger."Payment Method Code";
                        FormToPayTxt := GetSATMethodOfPayment(TempCustLedger."Payment Method Code");
                        FormToPayOut := FormToPayTxt;

                        CustomerNoOut := TempCustLedger."Customer No.";
                        CustomerNameOut := TempCustLedger."Customer Name";
                        DescriptionOut := TempCustLedger.Description;
                        UUIDOut := TempCustLedger."Fiscal Invoice Number PAC";
                        DateTimeStampedOut := Format(TempCustLedger."Date/Time Stamped");
                        ElectronicStatusOut := Format(TempCustLedger."Electronic Document Status");
                        UserIDOut := TempCustLedger."User ID";
                        DimensionSetIDOut := TempCustLedger."Dimension Set ID";
                        RemainingAmountOut := TempCustLedger."Remaining Amount";
                        SourceCodeOut := TempCustLedger."Source Code";
                        TipoCambioTxt := GetTipoCambioFromCustLedger(TempCustLedger);

                        GetAdditionalDocumentData(
                            TempCustLedger."Document Type",
                            TempCustLedger."Document No.",
                            EstatusCancelacionTxt,
                            TipoRelacionTxt,
                            UUIDRelacionadoTxt
                        );
                    end else begin
                        if not GetDetailedEntryByIndex(Number - 1, CurrentDetailedEntry) then
                            CurrReport.Skip();

                        // Obtener el registro de liquidación
                        if CurrentDetailedEntry."Cust. Ledger Entry No." = SavedCustomerLedger."Entry No." then begin
                            if not CustLedgLiq.Get(CurrentDetailedEntry."Applied Cust. Ledger Entry No.") then
                                CurrReport.Skip();
                        end else begin
                            if not CustLedgLiq.Get(CurrentDetailedEntry."Cust. Ledger Entry No.") then
                                CurrReport.Skip();
                        end;

                        TipoMovimientoTxt := 'Liquidación';
                        DocumentoOrigenTxt := ParentDocumentNo;

                        PostingDateOut := CustLedgLiq."Posting Date";
                        FechaLiquidacionOut := CurrentDetailedEntry."Posting Date";

                        DocumentTypeOut := Format(CustLedgLiq."Document Type");
                        DocumentNoOut := CustLedgLiq."Document No.";
                        ExternalDocNoOut := CustLedgLiq."External Document No.";
                        if CustLedgLiq."Currency Code" = '' then
                            CurrencyCodeOut := 'MXN'
                        else
                            CurrencyCodeOut := CustLedgLiq."Currency Code";

                        PaymentMethodCodeOut := CustLedgLiq."Payment Method Code";
                        FormToPayTxt := GetSATMethodOfPayment(CustLedgLiq."Payment Method Code");
                        FormToPayOut := FormToPayTxt;

                        CustomerNoOut := CustLedgLiq."Customer No.";
                        CustomerNameOut := CustLedgLiq."Customer Name";
                        DescriptionOut := CustLedgLiq.Description;
                        UUIDOut := CustLedgLiq."Fiscal Invoice Number PAC";
                        DateTimeStampedOut := Format(CustLedgLiq."Date/Time Stamped");
                        ElectronicStatusOut := Format(CustLedgLiq."Electronic Document Status");
                        UserIDOut := CustLedgLiq."User ID";
                        DimensionSetIDOut := CustLedgLiq."Dimension Set ID";
                        RemainingAmountOut := CustLedgLiq."Remaining Amount";
                        SourceCodeOut := CustLedgLiq."Source Code";
                        AmountOut := Abs(CurrentDetailedEntry.Amount);
                        AmountLCYOut := Abs(CurrentDetailedEntry."Amount (LCY)");

                        case SavedCustomerLedger."Document Type" of
                            SavedCustomerLedger."Document Type"::Invoice:
                                SignoLiquidacion := -1;
                            SavedCustomerLedger."Document Type"::"Credit Memo":
                                SignoLiquidacion := 1;
                            SavedCustomerLedger."Document Type"::Payment:
                                SignoLiquidacion := 1;
                            SavedCustomerLedger."Document Type"::Refund:
                                SignoLiquidacion := -1;
                            else
                                SignoLiquidacion := -1;
                        end;

                        AmountOut := AmountOut * SignoLiquidacion;
                        AmountLCYOut := AmountLCYOut * SignoLiquidacion;

                        AmountLiquidacion := AmountOut;
                        AmountLCYLiquidacion := AmountLCYOut;
                        TipoCambioTxt := GetTipoCambioFromCustLedger(CustLedgLiq);

                        GetAdditionalDocumentData(
                            CustLedgLiq."Document Type",
                            CustLedgLiq."Document No.",
                            EstatusCancelacionTxt,
                            TipoRelacionTxt,
                            UUIDRelacionadoTxt
                        );
                    end;
                end;
            }

            trigger OnPreDataItem()
            begin
                if (FechaInicio <> 0D) and (FechaFin <> 0D) then
                    SetRange("Posting Date", FechaInicio, FechaFin);

                InitializeDimensions();
            end;

            trigger OnAfterGetRecord()
            begin
                ParentDocumentNo := "Document No.";
                CalcFields(Amount, "Amount (LCY)");
                SavedCustomerLedger := CustomerLedger;

                // MODIFICADO: Cargar todos los movimientos detallados individuales
                LoadDetailedEntries("Entry No.");
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(FechaInicio; FechaInicio)
                {
                    ApplicationArea = All;
                    Caption = 'Fecha inicio';
                }
                field(FechaFin; FechaFin)
                {
                    ApplicationArea = All;
                    Caption = 'Fecha fin';
                }
                field(Pendiente; Pendiente)
                {
                    ApplicationArea = All;
                    Caption = 'Pendiente';
                }
            }
        }
    }

    var
        CustLedgLiq: Record "Cust. Ledger Entry";
        SavedCustomerLedger: Record "Cust. Ledger Entry";
        DimensionCodes: array[8] of Code[20];
        DimensionNames: array[8] of Text[100];
        ShowDimension: array[8] of Boolean;
        TipoMovimientoTxt: Text[30];
        DocumentoOrigenTxt: Code[20];
        FechaInicio: Date;
        FechaFin: Date;
        Pendiente: Boolean;
        ParentDocumentNo: Code[20];
        TipoCambioTxt: Text[50];
        EstatusCancelacionTxt: Text[50];
        TipoRelacionTxt: Text[50];
        UUIDRelacionadoTxt: Text[250];
        RangoFechasTxt: Text[100];
        PostingDateOut: Date;
        FechaLiquidacionOut: Date;
        DocumentTypeOut: Text;
        DocumentNoOut: Code[20];
        ExternalDocNoOut: Code[35];
        AmountOut: Decimal;
        AmountLCYOut: Decimal;
        CurrencyCodeOut: Code[10];
        PaymentMethodCodeOut: Code[10];
        FormToPayOut: Code[10];
        FormToPayTxt: Text[50];
        CustomerNoOut: Code[20];
        CustomerNameOut: Text[100];
        DescriptionOut: Text[100];
        UUIDOut: Text[50];
        DateTimeStampedOut: Text[50];
        ElectronicStatusOut: Text;
        UserIDOut: Code[50];
        DimensionSetIDOut: Integer;
        RemainingAmountOut: Decimal;
        SourceCodeOut: Code[10];
        AmountLiquidacion: Decimal;
        AmountLCYLiquidacion: Decimal;
        TempDetailedEntries: List of [Integer];
        TotalDetailedEntries: Integer;

    local procedure LoadDetailedEntries(CustEntryNo: Integer)
    var
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        Clear(TempDetailedEntries);
        TotalDetailedEntries := 0;

        DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", CustEntryNo);
        DetailedCustLedgEntry.SetRange("Entry Type", DetailedCustLedgEntry."Entry Type"::Application);
        DetailedCustLedgEntry.SetRange(Unapplied, false);

        if DetailedCustLedgEntry.FindSet() then
            repeat
                if (DetailedCustLedgEntry."Applied Cust. Ledger Entry No." <> 0) and
                   (DetailedCustLedgEntry."Applied Cust. Ledger Entry No." <> CustEntryNo) then begin
                    TempDetailedEntries.Add(DetailedCustLedgEntry."Entry No.");
                    TotalDetailedEntries += 1;
                end;
            until DetailedCustLedgEntry.Next() = 0;

        DetailedCustLedgEntry.Reset();
        DetailedCustLedgEntry.SetRange("Applied Cust. Ledger Entry No.", CustEntryNo);
        DetailedCustLedgEntry.SetRange("Entry Type", DetailedCustLedgEntry."Entry Type"::Application);
        DetailedCustLedgEntry.SetRange(Unapplied, false);

        if DetailedCustLedgEntry.FindSet() then
            repeat
                if (DetailedCustLedgEntry."Cust. Ledger Entry No." <> 0) and
                   (DetailedCustLedgEntry."Cust. Ledger Entry No." <> CustEntryNo) then begin
                    TempDetailedEntries.Add(DetailedCustLedgEntry."Entry No.");
                    TotalDetailedEntries += 1;
                end;
            until DetailedCustLedgEntry.Next() = 0;
    end;

    local procedure GetDetailedEntryByIndex(Index: Integer; var DetailedEntry: Record "Detailed Cust. Ledg. Entry"): Boolean
    var
        EntryNo: Integer;
    begin
        if (Index < 1) or (Index > TempDetailedEntries.Count) then
            exit(false);

        EntryNo := TempDetailedEntries.Get(Index);
        exit(DetailedEntry.Get(EntryNo));
    end;

    local procedure GetTipoCambioFromCustLedger(CustLedger: Record "Cust. Ledger Entry"): Text[50]
    var
        TipoCambioDecimal: Decimal;
    begin
        if (CustLedger."Currency Code" = '') or (CustLedger."Currency Code" = 'MXN') then
            exit('1');

        if CustLedger."Adjusted Currency Factor" <> 0 then begin
            TipoCambioDecimal := 1 / CustLedger."Adjusted Currency Factor";
            exit(Format(TipoCambioDecimal, 0, '<Precision,2:5><Standard Format,0>'));
        end else
            exit('');
    end;

    local procedure GetSATMethodOfPayment(PaymentMethodCode: Code[10]): Text[50]
    var
        PaymentMethod: Record "Payment Method";
    begin
        if PaymentMethodCode = '' then
            exit('');

        if PaymentMethod.Get(PaymentMethodCode) then
            exit(Format(PaymentMethod."SAT Method of Payment"))
        else
            exit('');
    end;

    local procedure GetAdditionalDocumentData(DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20]; var EstatusCancelacion: Text[50]; var TipoRelacion: Text[50]; var UUIDRelacionado: Text[250])
    begin
        EstatusCancelacion := '';
        TipoRelacion := '';
        UUIDRelacionado := '';

        case DocType of
            DocType::Invoice:
                GetInvoiceData(DocNo, EstatusCancelacion, TipoRelacion, UUIDRelacionado);
            DocType::"Credit Memo":
                GetCreditMemoData(DocNo, EstatusCancelacion, TipoRelacion, UUIDRelacionado);
        end;
    end;

    local procedure GetInvoiceData(DocNo: Code[20]; var EstatusCancelacion: Text[50]; var TipoRelacion: Text[50]; var UUIDRelacionado: Text[250])
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        DocumentRelationCFDI: Record "CFDI Relation Document";
    begin
        if SalesInvoiceHeader.Get(DocNo) then begin
            EstatusCancelacion := Format(SalesInvoiceHeader."Estatus Cancelacion");

            DocumentRelationCFDI.SetRange("Document Table ID", Database::"Sales Invoice Header");
            DocumentRelationCFDI.SetRange("Document No.", DocNo);
            if DocumentRelationCFDI.FindFirst() then begin
                TipoRelacion := Format(DocumentRelationCFDI."SAT Relation Type");
                UUIDRelacionado := DocumentRelationCFDI."Fiscal Invoice Number PAC";
            end;
        end;
    end;

    local procedure GetCreditMemoData(DocNo: Code[20]; var EstatusCancelacion: Text[50]; var TipoRelacion: Text[50]; var UUIDRelacionado: Text[250])
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        DocumentRelationCFDI: Record "CFDI Relation Document";
    begin
        if SalesCrMemoHeader.Get(DocNo) then begin
            EstatusCancelacion := Format(SalesCrMemoHeader."Estatus Cancelacion");

            DocumentRelationCFDI.SetRange("Document Table ID", Database::"Sales Cr.Memo Header");
            DocumentRelationCFDI.SetRange("Document No.", DocNo);
            if DocumentRelationCFDI.FindFirst() then begin
                TipoRelacion := Format(DocumentRelationCFDI."SAT Relation Type");
                UUIDRelacionado := DocumentRelationCFDI."Fiscal Invoice Number PAC";
            end;
        end;
    end;

    local procedure InitializeDimensions()
    var
        GLSetup: Record "General Ledger Setup";
        Dimension: Record Dimension;
        i: Integer;
    begin
        Clear(DimensionCodes);
        Clear(DimensionNames);
        Clear(ShowDimension);

        if not GLSetup.Get() then
            exit;

        i := 1;

        if GLSetup."Global Dimension 1 Code" <> '' then begin
            DimensionCodes[i] := GLSetup."Global Dimension 1 Code";
            if Dimension.Get(GLSetup."Global Dimension 1 Code") then
                DimensionNames[i] := Dimension.Name;
            ShowDimension[i] := true;
            i += 1;
        end;

        if GLSetup."Global Dimension 2 Code" <> '' then begin
            DimensionCodes[i] := GLSetup."Global Dimension 2 Code";
            if Dimension.Get(GLSetup."Global Dimension 2 Code") then
                DimensionNames[i] := Dimension.Name;
            ShowDimension[i] := true;
            i += 1;
        end;

        if GLSetup."Shortcut Dimension 3 Code" <> '' then begin
            DimensionCodes[i] := GLSetup."Shortcut Dimension 3 Code";
            if Dimension.Get(GLSetup."Shortcut Dimension 3 Code") then
                DimensionNames[i] := Dimension.Name;
            ShowDimension[i] := true;
            i += 1;
        end;

        if GLSetup."Shortcut Dimension 4 Code" <> '' then begin
            DimensionCodes[i] := GLSetup."Shortcut Dimension 4 Code";
            if Dimension.Get(GLSetup."Shortcut Dimension 4 Code") then
                DimensionNames[i] := Dimension.Name;
            ShowDimension[i] := true;
            i += 1;
        end;

        if GLSetup."Shortcut Dimension 5 Code" <> '' then begin
            DimensionCodes[i] := GLSetup."Shortcut Dimension 5 Code";
            if Dimension.Get(GLSetup."Shortcut Dimension 5 Code") then
                DimensionNames[i] := Dimension.Name;
            ShowDimension[i] := true;
            i += 1;
        end;

        if GLSetup."Shortcut Dimension 6 Code" <> '' then begin
            DimensionCodes[i] := GLSetup."Shortcut Dimension 6 Code";
            if Dimension.Get(GLSetup."Shortcut Dimension 6 Code") then
                DimensionNames[i] := Dimension.Name;
            ShowDimension[i] := true;
            i += 1;
        end;

        if GLSetup."Shortcut Dimension 7 Code" <> '' then begin
            DimensionCodes[i] := GLSetup."Shortcut Dimension 7 Code";
            if Dimension.Get(GLSetup."Shortcut Dimension 7 Code") then
                DimensionNames[i] := Dimension.Name;
            ShowDimension[i] := true;
            i += 1;
        end;

        if GLSetup."Shortcut Dimension 8 Code" <> '' then begin
            DimensionCodes[i] := GLSetup."Shortcut Dimension 8 Code";
            if Dimension.Get(GLSetup."Shortcut Dimension 8 Code") then
                DimensionNames[i] := Dimension.Name;
            ShowDimension[i] := true;
            i += 1;
        end;
    end;

    local procedure GetDimensionValue(DimensionSetID: Integer; Index: Integer): Text
    var
        DimSetEntry: Record "Dimension Set Entry";
        DimensionValue: Record "Dimension Value";
    begin
        if DimensionSetID = 0 then
            exit('');

        if (Index > ArrayLen(DimensionCodes)) or (DimensionCodes[Index] = '') then
            exit('');

        DimSetEntry.Reset();
        DimSetEntry.SetRange("Dimension Set ID", DimensionSetID);
        DimSetEntry.SetRange("Dimension Code", DimensionCodes[Index]);

        if DimSetEntry.FindFirst() then begin
            if DimensionValue.Get(DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code") then
                exit(DimensionValue.Name)
            else
                exit(DimSetEntry."Dimension Value Code");
        end else
            exit('');
    end;

    local procedure GetDimensionNameByIndex(Index: Integer): Text[100]
    begin
        if Index <= ArrayLen(DimensionNames) then
            exit(DimensionNames[Index]);
        exit('');
    end;
}