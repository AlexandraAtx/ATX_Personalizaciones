codeunit 50113 "Movimientos Proveedor Mgt"
{
    procedure GenerarMovimientos(FechaInicio: Date; FechaFin: Date; VendorFilter: Text; DocTypeFilter: Integer)
    var
        VendorLedger: Record "Vendor Ledger Entry";
        MovBuffer: Record "Movimientos Proveedor Liq";
        VendLedgLiq: Record "Vendor Ledger Entry";
        RelatedEntries: List of [Integer];
        EntryNo: Integer;
        i: Integer;
        ProgressDialog: Dialog;
        TotalRecords: Integer;
        ProcessedRecords: Integer;
    begin
        MovBuffer.DeleteAll();

        VendorLedger.Reset();
        if FechaInicio <> 0D then
            VendorLedger.SetRange("Posting Date", FechaInicio, FechaFin);

        if VendorFilter <> '' then
            VendorLedger.SetFilter("Vendor No.", VendorFilter);

        // Aplicar filtro de tipo de documento
        if DocTypeFilter > 0 then begin
            case DocTypeFilter of
                1:
                    VendorLedger.SetRange("Document Type", VendorLedger."Document Type"::Payment);
                2:
                    VendorLedger.SetRange("Document Type", VendorLedger."Document Type"::Invoice);
                3:
                    VendorLedger.SetRange("Document Type", VendorLedger."Document Type"::"Credit Memo");
                4:
                    VendorLedger.SetRange("Document Type", VendorLedger."Document Type"::"Finance Charge Memo");
                5:
                    VendorLedger.SetRange("Document Type", VendorLedger."Document Type"::Reminder);
                6:
                    VendorLedger.SetRange("Document Type", VendorLedger."Document Type"::Refund);
            end;
        end;

        TotalRecords := VendorLedger.Count();
        if TotalRecords = 0 then begin
            Message('No se encontraron registros con los filtros especificados.');
            exit;
        end;

        ProgressDialog.Open('Procesando movimientos...\\@1@@@@@@@@@@@@@@@@@@@@@@@');

        if VendorLedger.FindSet() then
            repeat
                ProcessedRecords += 1;
                ProgressDialog.Update(1, Round(ProcessedRecords / TotalRecords * 10000, 1));

                VendorLedger.CalcFields(Amount, "Amount (LCY)", "Remaining Amount");
                InsertMovimientoInicial(VendorLedger, FechaInicio, FechaFin);
                RelatedEntries := GetAppliedDocumentsFromVendor(VendorLedger."Entry No.");

                if RelatedEntries.Count > 0 then begin
                    for i := 1 to RelatedEntries.Count do begin
                        EntryNo := RelatedEntries.Get(i);
                        if VendLedgLiq.Get(EntryNo) then begin
                            VendLedgLiq.CalcFields(Amount, "Amount (LCY)", "Remaining Amount");
                            InsertLiquidacionesIndividuales(VendorLedger, VendLedgLiq, FechaInicio, FechaFin);
                        end;
                    end;
                end;
            until VendorLedger.Next() = 0;

        ProgressDialog.Close();
    end;

    local procedure InsertMovimientoInicial(VendLedger: Record "Vendor Ledger Entry"; FechaInicio: Date; FechaFin: Date)
    var
        MovBuffer: Record "Movimientos Proveedor Liq";
        TipoCambio: Text[50];
        EstatusCancelacion: Text[50];
        TipoRelacion: Text[50];
        UUIDRelacionado: Text[250];
        FormaPago: Text[50];
    begin
        MovBuffer.Init();
        MovBuffer."Entry No." := 0;
        MovBuffer."Tipo Movimiento" := MovBuffer."Tipo Movimiento"::"Mov. Inicial";
        MovBuffer."Documento Origen" := VendLedger."Document No.";
        MovBuffer."Posting Date" := VendLedger."Posting Date";
        MovBuffer."Fecha Liquidacion" := 0D;
        MovBuffer."Document Type" := VendLedger."Document Type";
        MovBuffer."Document No." := VendLedger."Document No.";
        MovBuffer."External Document No." := VendLedger."External Document No.";
        MovBuffer.Amount := VendLedger.Amount;
        MovBuffer."Amount (LCY)" := VendLedger."Amount (LCY)";
        if VendLedger."Currency Code" = '' then
            MovBuffer."Currency Code" := 'MXN'
        else
            MovBuffer."Currency Code" := VendLedger."Currency Code";
        MovBuffer."Payment Method Code" := VendLedger."Payment Method Code";
        FormaPago := GetSATMethodOfPayment(VendLedger."Payment Method Code");
        MovBuffer."Form to Pay" := FormaPago;

        MovBuffer."Vendor No." := VendLedger."Vendor No.";
        MovBuffer."Vendor Name" := VendLedger."Vendor Name";
        MovBuffer.Description := VendLedger.Description;
        MovBuffer.UUID := VendLedger."Fiscal Invoice Number PAC";
        MovBuffer."Date/Time Stamped" := Format(VendLedger."Date/Time Stamped");
        MovBuffer."Electronic Status" := Format(VendLedger."Electronic Document Status");
        MovBuffer."User ID" := VendLedger."User ID";
        MovBuffer."Dimension Set ID" := VendLedger."Dimension Set ID";
        MovBuffer."Remaining Amount" := VendLedger."Remaining Amount";
        MovBuffer."Source Code" := VendLedger."Source Code";
        MovBuffer."Company Name" := CompanyName;
        MovBuffer."Fecha Creacion" := WorkDate();
        MovBuffer."Parent Entry No." := VendLedger."Entry No.";

        MovBuffer."Due Date" := VendLedger."Due Date";

        if IsDocumentOverdue(VendLedger."Due Date", VendLedger."Remaining Amount") then
            MovBuffer.Style := 'Attention'
        else
            MovBuffer.Style := 'Strong';

        TipoCambio := GetTipoCambioFromVendLedger(VendLedger);

        GetAdditionalDocumentData(
            VendLedger."Document Type",
            VendLedger."Document No.",
            EstatusCancelacion,
            TipoRelacion,
            UUIDRelacionado
        );

        MovBuffer."Tipo Cambio" := TipoCambio;
        MovBuffer."Estatus Cancelacion" := EstatusCancelacion;
        MovBuffer."Tipo Relacion" := TipoRelacion;
        MovBuffer."UUID Relacionado" := UUIDRelacionado;

        MovBuffer."Dimension 1 Value" := GetDimensionValue(VendLedger."Dimension Set ID", 1);
        MovBuffer."Dimension 2 Value" := GetDimensionValue(VendLedger."Dimension Set ID", 2);
        MovBuffer."Dimension 3 Value" := GetDimensionValue(VendLedger."Dimension Set ID", 3);
        MovBuffer."Dimension 4 Value" := GetDimensionValue(VendLedger."Dimension Set ID", 4);
        MovBuffer."Dimension 5 Value" := GetDimensionValue(VendLedger."Dimension Set ID", 5);
        MovBuffer."Dimension 6 Value" := GetDimensionValue(VendLedger."Dimension Set ID", 6);
        MovBuffer."Dimension 7 Value" := GetDimensionValue(VendLedger."Dimension Set ID", 7);
        MovBuffer."Dimension 8 Value" := GetDimensionValue(VendLedger."Dimension Set ID", 8);

        MovBuffer.Insert(true);
    end;

    local procedure InsertLiquidacionesIndividuales(ParentVendLedger: Record "Vendor Ledger Entry"; VendLedgLiq: Record "Vendor Ledger Entry"; FechaInicio: Date; FechaFin: Date)
    var
        DetailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
    begin
        // Buscar movimientos donde el documento padre es el principal
        DetailedVendLedgEntry.SetRange("Vendor Ledger Entry No.", ParentVendLedger."Entry No.");
        DetailedVendLedgEntry.SetRange("Applied Vend. Ledger Entry No.", VendLedgLiq."Entry No.");
        DetailedVendLedgEntry.SetRange("Entry Type", DetailedVendLedgEntry."Entry Type"::Application);
        DetailedVendLedgEntry.SetRange(Unapplied, false);

        if DetailedVendLedgEntry.FindSet() then
            repeat
                InsertLiquidacionDetalle(ParentVendLedger, VendLedgLiq, DetailedVendLedgEntry, FechaInicio, FechaFin);
            until DetailedVendLedgEntry.Next() = 0;

        // Buscar movimientos en dirección inversa
        DetailedVendLedgEntry.Reset();
        DetailedVendLedgEntry.SetRange("Vendor Ledger Entry No.", VendLedgLiq."Entry No.");
        DetailedVendLedgEntry.SetRange("Applied Vend. Ledger Entry No.", ParentVendLedger."Entry No.");
        DetailedVendLedgEntry.SetRange("Entry Type", DetailedVendLedgEntry."Entry Type"::Application);
        DetailedVendLedgEntry.SetRange(Unapplied, false);

        if DetailedVendLedgEntry.FindSet() then
            repeat
                InsertLiquidacionDetalle(ParentVendLedger, VendLedgLiq, DetailedVendLedgEntry, FechaInicio, FechaFin);
            until DetailedVendLedgEntry.Next() = 0;
    end;

    local procedure InsertLiquidacionDetalle(ParentVendLedger: Record "Vendor Ledger Entry"; VendLedgLiq: Record "Vendor Ledger Entry"; DetailedEntry: Record "Detailed Vendor Ledg. Entry"; FechaInicio: Date; FechaFin: Date)
    var
        MovBuffer: Record "Movimientos Proveedor Liq";
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

        case ParentVendLedger."Document Type" of
            ParentVendLedger."Document Type"::Invoice:
                SignoLiquidacion := -1;
            ParentVendLedger."Document Type"::"Credit Memo":
                SignoLiquidacion := 1;
            ParentVendLedger."Document Type"::Payment:
                SignoLiquidacion := 1;
            ParentVendLedger."Document Type"::Refund:
                SignoLiquidacion := -1;
            else
                SignoLiquidacion := -1;
        end;

        MovBuffer.Init();
        MovBuffer."Entry No." := 0;
        MovBuffer."Tipo Movimiento" := MovBuffer."Tipo Movimiento"::"Liquidación";
        MovBuffer."Documento Origen" := ParentVendLedger."Document No.";
        MovBuffer."Posting Date" := VendLedgLiq."Posting Date";
        MovBuffer."Fecha Liquidacion" := DetailedEntry."Posting Date";
        MovBuffer."Document Type" := VendLedgLiq."Document Type";
        MovBuffer."Document No." := VendLedgLiq."Document No.";
        MovBuffer."External Document No." := VendLedgLiq."External Document No.";
        MovBuffer.Amount := AppAmount * SignoLiquidacion;
        MovBuffer."Amount (LCY)" := AppAmountLCY * SignoLiquidacion;
        if VendLedgLiq."Currency Code" = '' then
            MovBuffer."Currency Code" := 'MXN'
        else
            MovBuffer."Currency Code" := VendLedgLiq."Currency Code";
        MovBuffer."Payment Method Code" := VendLedgLiq."Payment Method Code";
        FormaPago := GetSATMethodOfPayment(VendLedgLiq."Payment Method Code");
        MovBuffer."Form to Pay" := FormaPago;

        MovBuffer."Vendor No." := VendLedgLiq."Vendor No.";
        MovBuffer."Vendor Name" := VendLedgLiq."Vendor Name";
        MovBuffer.Description := VendLedgLiq.Description;
        MovBuffer.UUID := VendLedgLiq."Fiscal Invoice Number PAC";
        MovBuffer."Date/Time Stamped" := Format(VendLedgLiq."Date/Time Stamped");
        MovBuffer."Electronic Status" := Format(VendLedgLiq."Electronic Document Status");
        MovBuffer."User ID" := VendLedgLiq."User ID";
        MovBuffer."Dimension Set ID" := VendLedgLiq."Dimension Set ID";
        MovBuffer."Remaining Amount" := VendLedgLiq."Remaining Amount";
        MovBuffer."Source Code" := VendLedgLiq."Source Code";
        MovBuffer."Company Name" := CompanyName;
        MovBuffer."Fecha Creacion" := WorkDate();
        MovBuffer."Parent Entry No." := ParentVendLedger."Entry No.";
        MovBuffer."Due Date" := VendLedgLiq."Due Date";

        MovBuffer.Style := 'Standard';
        TipoCambio := GetTipoCambioFromVendLedger(VendLedgLiq);

        GetAdditionalDocumentData(
            VendLedgLiq."Document Type",
            VendLedgLiq."Document No.",
            EstatusCancelacion,
            TipoRelacion,
            UUIDRelacionado
        );

        MovBuffer."Tipo Cambio" := TipoCambio;
        MovBuffer."Estatus Cancelacion" := EstatusCancelacion;
        MovBuffer."Tipo Relacion" := TipoRelacion;
        MovBuffer."UUID Relacionado" := UUIDRelacionado;

        MovBuffer."Dimension 1 Value" := GetDimensionValue(VendLedgLiq."Dimension Set ID", 1);
        MovBuffer."Dimension 2 Value" := GetDimensionValue(VendLedgLiq."Dimension Set ID", 2);
        MovBuffer."Dimension 3 Value" := GetDimensionValue(VendLedgLiq."Dimension Set ID", 3);
        MovBuffer."Dimension 4 Value" := GetDimensionValue(VendLedgLiq."Dimension Set ID", 4);
        MovBuffer."Dimension 5 Value" := GetDimensionValue(VendLedgLiq."Dimension Set ID", 5);
        MovBuffer."Dimension 6 Value" := GetDimensionValue(VendLedgLiq."Dimension Set ID", 6);
        MovBuffer."Dimension 7 Value" := GetDimensionValue(VendLedgLiq."Dimension Set ID", 7);
        MovBuffer."Dimension 8 Value" := GetDimensionValue(VendLedgLiq."Dimension Set ID", 8);

        MovBuffer.Insert(true);
    end;

    local procedure GetTipoCambioFromVendLedger(VendLedger: Record "Vendor Ledger Entry"): Text[50]
    var
        TipoCambioDecimal: Decimal;
    begin
        if (VendLedger."Currency Code" = '') or (VendLedger."Currency Code" = 'MXN') then
            exit('1');

        if VendLedger."Adjusted Currency Factor" <> 0 then begin
            TipoCambioDecimal := 1 / VendLedger."Adjusted Currency Factor";
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

    local procedure GetAppliedDocumentsFromVendor(VendEntryNo: Integer): List of [Integer]
    var
        DetailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        RelatedVendLedgEntry: Record "Vendor Ledger Entry";
        TempRelatedEntries: List of [Integer];
        TempAppliedEntry: Integer;
    begin
        Clear(TempRelatedEntries);

        DetailedVendLedgEntry.SetRange("Vendor Ledger Entry No.", VendEntryNo);
        DetailedVendLedgEntry.SetRange("Entry Type", DetailedVendLedgEntry."Entry Type"::Application);
        DetailedVendLedgEntry.SetRange(Unapplied, false);

        if DetailedVendLedgEntry.FindSet() then
            repeat
                TempAppliedEntry := DetailedVendLedgEntry."Applied Vend. Ledger Entry No.";
                if (TempAppliedEntry <> 0) and (TempAppliedEntry <> VendEntryNo) then
                    if not TempRelatedEntries.Contains(TempAppliedEntry) then
                        if RelatedVendLedgEntry.Get(TempAppliedEntry) then
                            TempRelatedEntries.Add(TempAppliedEntry);
            until DetailedVendLedgEntry.Next() = 0;

        DetailedVendLedgEntry.Reset();
        DetailedVendLedgEntry.SetRange("Applied Vend. Ledger Entry No.", VendEntryNo);
        DetailedVendLedgEntry.SetRange("Entry Type", DetailedVendLedgEntry."Entry Type"::Application);
        DetailedVendLedgEntry.SetRange(Unapplied, false);

        if DetailedVendLedgEntry.FindSet() then
            repeat
                TempAppliedEntry := DetailedVendLedgEntry."Vendor Ledger Entry No.";
                if (TempAppliedEntry <> 0) and (TempAppliedEntry <> VendEntryNo) then
                    if not TempRelatedEntries.Contains(TempAppliedEntry) then
                        if RelatedVendLedgEntry.Get(TempAppliedEntry) then
                            TempRelatedEntries.Add(TempAppliedEntry);
            until DetailedVendLedgEntry.Next() = 0;

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
        PurchInvHeader: Record "Purch. Inv. Header";
        DocumentRelationCFDI: Record "CFDI Relation Document";
    begin
        if PurchInvHeader.Get(DocNo) then begin
            PurchInvHeader.CalcFields(Cancelled);
            if PurchInvHeader.Cancelled then
                EstatusCancelacion := 'Cancelado'
            else
                EstatusCancelacion := '';

            DocumentRelationCFDI.SetRange("Document Table ID", Database::"Purch. Inv. Header");
            DocumentRelationCFDI.SetRange("Document No.", DocNo);
            if DocumentRelationCFDI.FindFirst() then begin
                TipoRelacion := Format(DocumentRelationCFDI."SAT Relation Type");
                UUIDRelacionado := DocumentRelationCFDI."Fiscal Invoice Number PAC";
            end;
        end;
    end;

    local procedure GetCreditMemoData(DocNo: Code[20]; var EstatusCancelacion: Text[50]; var TipoRelacion: Text[50]; var UUIDRelacionado: Text[250])
    var
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        DocumentRelationCFDI: Record "CFDI Relation Document";
    begin
        if PurchCrMemoHdr.Get(DocNo) then begin
            PurchCrMemoHdr.CalcFields(Cancelled);
            if PurchCrMemoHdr.Cancelled then
                EstatusCancelacion := 'Cancelado'
            else
                EstatusCancelacion := '';

            DocumentRelationCFDI.SetRange("Document Table ID", Database::"Purch. Cr. Memo Hdr.");
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