codeunit 50112 "Movimientos Cliente Mgt"
{
    procedure GenerarMovimientos(FechaInicio: Date; FechaFin: Date; CustomerFilter: Text; DocTypeFilter: Integer)
    var
        CustomerLedger: Record "Cust. Ledger Entry";
        MovBuffer: Record "Movimientos Cliente Buffer";
        CustLedgLiq: Record "Cust. Ledger Entry";
        RelatedEntries: List of [Integer];
        EntryNo: Integer;
        i: Integer;
        ProgressDialog: Dialog;
        TotalRecords: Integer;
        ProcessedRecords: Integer;
    begin
        MovBuffer.DeleteAll();

        CustomerLedger.Reset();
        if FechaInicio <> 0D then
            CustomerLedger.SetRange("Posting Date", FechaInicio, FechaFin);

        if CustomerFilter <> '' then
            CustomerLedger.SetFilter("Customer No.", CustomerFilter);

        // NUEVO: Aplicar filtro de tipo de documento
        if DocTypeFilter > 0 then begin
            case DocTypeFilter of
                1:
                    CustomerLedger.SetRange("Document Type", CustomerLedger."Document Type"::Payment);
                2:
                    CustomerLedger.SetRange("Document Type", CustomerLedger."Document Type"::Invoice);
                3:
                    CustomerLedger.SetRange("Document Type", CustomerLedger."Document Type"::"Credit Memo");
                4:
                    CustomerLedger.SetRange("Document Type", CustomerLedger."Document Type"::"Finance Charge Memo");
                5:
                    CustomerLedger.SetRange("Document Type", CustomerLedger."Document Type"::Reminder);
                6:
                    CustomerLedger.SetRange("Document Type", CustomerLedger."Document Type"::Refund);
            end;
        end;

        TotalRecords := CustomerLedger.Count();
        if TotalRecords = 0 then begin
            Message('No se encontraron registros con los filtros especificados.');
            exit;
        end;

        ProgressDialog.Open('Procesando movimientos...\\@1@@@@@@@@@@@@@@@@@@@@@@@');

        if CustomerLedger.FindSet() then
            repeat
                ProcessedRecords += 1;
                ProgressDialog.Update(1, Round(ProcessedRecords / TotalRecords * 10000, 1));

                CustomerLedger.CalcFields(Amount, "Amount (LCY)", "Remaining Amount");
                InsertMovimientoInicial(CustomerLedger, FechaInicio, FechaFin);
                RelatedEntries := GetAppliedDocumentsFromCustomer(CustomerLedger."Entry No.");

                if RelatedEntries.Count > 0 then begin
                    for i := 1 to RelatedEntries.Count do begin
                        EntryNo := RelatedEntries.Get(i);
                        if CustLedgLiq.Get(EntryNo) then begin
                            CustLedgLiq.CalcFields(Amount, "Amount (LCY)", "Remaining Amount");
                            InsertLiquidacionesIndividuales(CustomerLedger, CustLedgLiq, FechaInicio, FechaFin);
                        end;
                    end;
                end;
            until CustomerLedger.Next() = 0;

        ProgressDialog.Close();
    end;

    local procedure InsertMovimientoInicial(CustLedger: Record "Cust. Ledger Entry"; FechaInicio: Date; FechaFin: Date)
    var
        MovBuffer: Record "Movimientos Cliente Buffer";
        TipoCambio: Text[50];
        EstatusCancelacion: Text[50];
        TipoRelacion: Text[50];
        UUIDRelacionado: Text[250];
        FormaPago: Text[50];
    begin
        MovBuffer.Init();
        MovBuffer."Entry No." := 0;
        MovBuffer."Tipo Movimiento" := MovBuffer."Tipo Movimiento"::"Mov. Inicial";
        MovBuffer."Documento Origen" := CustLedger."Document No.";
        MovBuffer."Posting Date" := CustLedger."Posting Date";
        MovBuffer."Fecha Liquidacion" := 0D;
        MovBuffer."Document Type" := CustLedger."Document Type";
        MovBuffer."Document No." := CustLedger."Document No.";
        MovBuffer."External Document No." := CustLedger."External Document No.";
        MovBuffer.Amount := CustLedger.Amount;
        MovBuffer."Amount (LCY)" := CustLedger."Amount (LCY)";
        if CustLedger."Currency Code" = '' then
            MovBuffer."Currency Code" := 'MXN'
        else
            MovBuffer."Currency Code" := CustLedger."Currency Code";
        MovBuffer."Payment Method Code" := CustLedger."Payment Method Code";
        FormaPago := GetSATMethodOfPayment(CustLedger."Payment Method Code");
        MovBuffer."Form to Pay" := FormaPago;

        MovBuffer."Customer No." := CustLedger."Customer No.";
        MovBuffer."Customer Name" := CustLedger."Customer Name";
        MovBuffer.Description := CustLedger.Description;
        MovBuffer.UUID := CustLedger."Fiscal Invoice Number PAC";
        MovBuffer."Date/Time Stamped" := Format(CustLedger."Date/Time Stamped");
        MovBuffer."Electronic Status" := Format(CustLedger."Electronic Document Status");
        MovBuffer."User ID" := CustLedger."User ID";
        MovBuffer."Dimension Set ID" := CustLedger."Dimension Set ID";
        MovBuffer."Remaining Amount" := CustLedger."Remaining Amount";
        MovBuffer."Source Code" := CustLedger."Source Code";
        MovBuffer."Company Name" := CompanyName;
        MovBuffer."Fecha Creacion" := WorkDate();
        MovBuffer."Parent Entry No." := CustLedger."Entry No.";

        MovBuffer."Due Date" := CustLedger."Due Date";

        if IsDocumentOverdue(CustLedger."Due Date", CustLedger."Remaining Amount") then
            MovBuffer.Style := 'Attention'
        else
            MovBuffer.Style := 'Strong';

        TipoCambio := GetTipoCambioFromCustLedger(CustLedger);

        GetAdditionalDocumentData(
            CustLedger."Document Type",
            CustLedger."Document No.",
            EstatusCancelacion,
            TipoRelacion,
            UUIDRelacionado
        );

        MovBuffer."Tipo Cambio" := TipoCambio;
        MovBuffer."Estatus Cancelacion" := EstatusCancelacion;
        MovBuffer."Tipo Relacion" := TipoRelacion;
        MovBuffer."UUID Relacionado" := UUIDRelacionado;

        MovBuffer."Dimension 1 Value" := GetDimensionValue(CustLedger."Dimension Set ID", 1);
        MovBuffer."Dimension 2 Value" := GetDimensionValue(CustLedger."Dimension Set ID", 2);
        MovBuffer."Dimension 3 Value" := GetDimensionValue(CustLedger."Dimension Set ID", 3);
        MovBuffer."Dimension 4 Value" := GetDimensionValue(CustLedger."Dimension Set ID", 4);
        MovBuffer."Dimension 5 Value" := GetDimensionValue(CustLedger."Dimension Set ID", 5);
        MovBuffer."Dimension 6 Value" := GetDimensionValue(CustLedger."Dimension Set ID", 6);
        MovBuffer."Dimension 7 Value" := GetDimensionValue(CustLedger."Dimension Set ID", 7);
        MovBuffer."Dimension 8 Value" := GetDimensionValue(CustLedger."Dimension Set ID", 8);

        MovBuffer.Insert(true);
    end;

    // liquidación por cada movimiento detallado individual
    local procedure InsertLiquidacionesIndividuales(ParentCustLedger: Record "Cust. Ledger Entry"; CustLedgLiq: Record "Cust. Ledger Entry"; FechaInicio: Date; FechaFin: Date)
    var
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        // Buscar movimientos donde el documento padre es el principal
        DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", ParentCustLedger."Entry No.");
        DetailedCustLedgEntry.SetRange("Applied Cust. Ledger Entry No.", CustLedgLiq."Entry No.");
        DetailedCustLedgEntry.SetRange("Entry Type", DetailedCustLedgEntry."Entry Type"::Application);
        DetailedCustLedgEntry.SetRange(Unapplied, false);

        if DetailedCustLedgEntry.FindSet() then
            repeat
                InsertLiquidacionDetalle(ParentCustLedger, CustLedgLiq, DetailedCustLedgEntry, FechaInicio, FechaFin);
            until DetailedCustLedgEntry.Next() = 0;

        // Buscar movimientos en dirección inversa
        DetailedCustLedgEntry.Reset();
        DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", CustLedgLiq."Entry No.");
        DetailedCustLedgEntry.SetRange("Applied Cust. Ledger Entry No.", ParentCustLedger."Entry No.");
        DetailedCustLedgEntry.SetRange("Entry Type", DetailedCustLedgEntry."Entry Type"::Application);
        DetailedCustLedgEntry.SetRange(Unapplied, false);

        if DetailedCustLedgEntry.FindSet() then
            repeat
                InsertLiquidacionDetalle(ParentCustLedger, CustLedgLiq, DetailedCustLedgEntry, FechaInicio, FechaFin);
            until DetailedCustLedgEntry.Next() = 0;
    end;

    // liquidación
    local procedure InsertLiquidacionDetalle(ParentCustLedger: Record "Cust. Ledger Entry"; CustLedgLiq: Record "Cust. Ledger Entry"; DetailedEntry: Record "Detailed Cust. Ledg. Entry"; FechaInicio: Date; FechaFin: Date)
    var
        MovBuffer: Record "Movimientos Cliente Buffer";
        TipoCambio: Text[50];
        EstatusCancelacion: Text[50];
        TipoRelacion: Text[50];
        UUIDRelacionado: Text[250];
        AppAmount: Decimal;
        AppAmountLCY: Decimal;
        SignoLiquidacion: Decimal;
        FormaPago: Text[50];
    begin
        AppAmount := Abs(DetailedEntry.Amount);
        AppAmountLCY := Abs(DetailedEntry."Amount (LCY)");

        if AppAmount = 0 then
            exit;

        case ParentCustLedger."Document Type" of
            ParentCustLedger."Document Type"::Invoice:
                SignoLiquidacion := -1;
            ParentCustLedger."Document Type"::"Credit Memo":
                SignoLiquidacion := 1;
            ParentCustLedger."Document Type"::Payment:
                SignoLiquidacion := 1;
            ParentCustLedger."Document Type"::Refund:
                SignoLiquidacion := -1;
            else
                SignoLiquidacion := -1;
        end;

        MovBuffer.Init();
        MovBuffer."Entry No." := 0;
        MovBuffer."Tipo Movimiento" := MovBuffer."Tipo Movimiento"::"Liquidación";
        MovBuffer."Documento Origen" := ParentCustLedger."Document No.";
        MovBuffer."Posting Date" := CustLedgLiq."Posting Date";
        MovBuffer."Fecha Liquidacion" := DetailedEntry."Posting Date"; // Fecha del movimiento detallado
        MovBuffer."Document Type" := CustLedgLiq."Document Type";
        MovBuffer."Document No." := CustLedgLiq."Document No.";
        MovBuffer."External Document No." := CustLedgLiq."External Document No.";
        MovBuffer.Amount := AppAmount * SignoLiquidacion;
        MovBuffer."Amount (LCY)" := AppAmountLCY * SignoLiquidacion;
        if CustLedgLiq."Currency Code" = '' then
            MovBuffer."Currency Code" := 'MXN'
        else
            MovBuffer."Currency Code" := CustLedgLiq."Currency Code";
        MovBuffer."Payment Method Code" := CustLedgLiq."Payment Method Code";
        FormaPago := GetSATMethodOfPayment(CustLedgLiq."Payment Method Code");
        MovBuffer."Form to Pay" := FormaPago;

        MovBuffer."Customer No." := CustLedgLiq."Customer No.";
        MovBuffer."Customer Name" := CustLedgLiq."Customer Name";
        MovBuffer.Description := CustLedgLiq.Description;
        MovBuffer.UUID := CustLedgLiq."Fiscal Invoice Number PAC";
        MovBuffer."Date/Time Stamped" := Format(CustLedgLiq."Date/Time Stamped");
        MovBuffer."Electronic Status" := Format(CustLedgLiq."Electronic Document Status");
        MovBuffer."User ID" := CustLedgLiq."User ID";
        MovBuffer."Dimension Set ID" := CustLedgLiq."Dimension Set ID";
        MovBuffer."Remaining Amount" := CustLedgLiq."Remaining Amount";
        MovBuffer."Source Code" := CustLedgLiq."Source Code";
        MovBuffer."Company Name" := CompanyName;
        MovBuffer."Fecha Creacion" := WorkDate();
        MovBuffer."Parent Entry No." := ParentCustLedger."Entry No.";
        MovBuffer."Due Date" := CustLedgLiq."Due Date";

        MovBuffer.Style := 'Standard';
        TipoCambio := GetTipoCambioFromCustLedger(CustLedgLiq);

        GetAdditionalDocumentData(
            CustLedgLiq."Document Type",
            CustLedgLiq."Document No.",
            EstatusCancelacion,
            TipoRelacion,
            UUIDRelacionado
        );

        MovBuffer."Tipo Cambio" := TipoCambio;
        MovBuffer."Estatus Cancelacion" := EstatusCancelacion;
        MovBuffer."Tipo Relacion" := TipoRelacion;
        MovBuffer."UUID Relacionado" := UUIDRelacionado;

        MovBuffer."Dimension 1 Value" := GetDimensionValue(CustLedgLiq."Dimension Set ID", 1);
        MovBuffer."Dimension 2 Value" := GetDimensionValue(CustLedgLiq."Dimension Set ID", 2);
        MovBuffer."Dimension 3 Value" := GetDimensionValue(CustLedgLiq."Dimension Set ID", 3);
        MovBuffer."Dimension 4 Value" := GetDimensionValue(CustLedgLiq."Dimension Set ID", 4);
        MovBuffer."Dimension 5 Value" := GetDimensionValue(CustLedgLiq."Dimension Set ID", 5);
        MovBuffer."Dimension 6 Value" := GetDimensionValue(CustLedgLiq."Dimension Set ID", 6);
        MovBuffer."Dimension 7 Value" := GetDimensionValue(CustLedgLiq."Dimension Set ID", 7);
        MovBuffer."Dimension 8 Value" := GetDimensionValue(CustLedgLiq."Dimension Set ID", 8);

        MovBuffer.Insert(true);
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

    local procedure GetAppliedDocumentsFromCustomer(CustEntryNo: Integer): List of [Integer]
    var
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        RelatedCustLedgEntry: Record "Cust. Ledger Entry";
        TempRelatedEntries: List of [Integer];
        TempAppliedEntry: Integer;
    begin
        Clear(TempRelatedEntries);

        DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", CustEntryNo);
        DetailedCustLedgEntry.SetRange("Entry Type", DetailedCustLedgEntry."Entry Type"::Application);
        DetailedCustLedgEntry.SetRange(Unapplied, false);

        if DetailedCustLedgEntry.FindSet() then
            repeat
                TempAppliedEntry := DetailedCustLedgEntry."Applied Cust. Ledger Entry No.";
                if (TempAppliedEntry <> 0) and (TempAppliedEntry <> CustEntryNo) then
                    if not TempRelatedEntries.Contains(TempAppliedEntry) then
                        if RelatedCustLedgEntry.Get(TempAppliedEntry) then
                            TempRelatedEntries.Add(TempAppliedEntry);
            until DetailedCustLedgEntry.Next() = 0;

        DetailedCustLedgEntry.Reset();
        DetailedCustLedgEntry.SetRange("Applied Cust. Ledger Entry No.", CustEntryNo);
        DetailedCustLedgEntry.SetRange("Entry Type", DetailedCustLedgEntry."Entry Type"::Application);
        DetailedCustLedgEntry.SetRange(Unapplied, false);

        if DetailedCustLedgEntry.FindSet() then
            repeat
                TempAppliedEntry := DetailedCustLedgEntry."Cust. Ledger Entry No.";
                if (TempAppliedEntry <> 0) and (TempAppliedEntry <> CustEntryNo) then
                    if not TempRelatedEntries.Contains(TempAppliedEntry) then
                        if RelatedCustLedgEntry.Get(TempAppliedEntry) then
                            TempRelatedEntries.Add(TempAppliedEntry);
            until DetailedCustLedgEntry.Next() = 0;

        exit(TempRelatedEntries);
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

    local procedure GetDimensionValue(DimensionSetID: Integer; Index: Integer): Text
    var
        DimSetEntry: Record "Dimension Set Entry";
        DimensionValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        DimensionCode: Code[20];
    begin
        if DimensionSetID = 0 then
            exit('');

        if not GLSetup.Get() then
            exit('');

        case Index of
            1:
                DimensionCode := GLSetup."Global Dimension 1 Code";
            2:
                DimensionCode := GLSetup."Global Dimension 2 Code";
            3:
                DimensionCode := GLSetup."Shortcut Dimension 3 Code";
            4:
                DimensionCode := GLSetup."Shortcut Dimension 4 Code";
            5:
                DimensionCode := GLSetup."Shortcut Dimension 5 Code";
            6:
                DimensionCode := GLSetup."Shortcut Dimension 6 Code";
            7:
                DimensionCode := GLSetup."Shortcut Dimension 7 Code";
            8:
                DimensionCode := GLSetup."Shortcut Dimension 8 Code";
        end;

        if DimensionCode = '' then
            exit('');

        DimSetEntry.Reset();
        DimSetEntry.SetRange("Dimension Set ID", DimensionSetID);
        DimSetEntry.SetRange("Dimension Code", DimensionCode);

        if DimSetEntry.FindFirst() then begin
            if DimensionValue.Get(DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code") then
                exit(DimensionValue.Name)
            else
                exit(DimSetEntry."Dimension Value Code");
        end else
            exit('');
    end;

    local procedure IsDocumentOverdue(DueDate: Date; RemainingAmount: Decimal): Boolean
    begin
        if (DueDate = 0D) then
            exit(false);

        if (RemainingAmount = 0) then
            exit(false);

        exit(DueDate < WorkDate());
    end;
}