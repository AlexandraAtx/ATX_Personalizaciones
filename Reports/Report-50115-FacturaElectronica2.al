report 50115 FacturaElectronicaPDF
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = '.\FacturaCFDI40.rdl';
    Caption = 'FacturaElectronicaPDF';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            CalcFields = "Amount Including VAT", Amount;
            RequestFilterFields = "No.";
            DataItemTableView = WHERE("Document Type" = FILTER(Order | Invoice));
            column(NombreEmpresa1; CompanyInformation.Name + ' ' + CompanyInformation."Name 2") { }
            column(FolioR; "No.") { }
            column(EmisionT; CompanyInformation.County + ', ' + FORMAT("Document Date")) { }
            column(VendedorNombre; VendedorNombre) { }
            column(Banco; CompanyInformation."Bank Name") { }
            column(Sucursal; CompanyInformation."Bank Branch No.") { }
            column(Cuenta; CompanyInformation."Bank Account No.") { }
            column(Clabe; CompanyInformation."Payment Routing No.") { }
            column(Telefono; CompanyInformation."Phone No.") { }
            column(Telefono2; CompanyInformation."Phone No. 2") { }
            column(correCC; CompanyInformation."Correo CC") { }
            column(Bill_to_Address; CompanyInformation.Address + ' Col.' + CompanyInformation."Address 2") { }
            column(VendedorNo; "Salesperson Code") { }
            column(NombreVendedor; NombreVendedor) { }
            column(Moneda; Moneda) { }
            column(TipoCambio; TipoCambio) { }
            column(Seriex; Serie) { }
            column(Descuentox; "Invoice Discount Amount") { }
            column(foliox; folio) { }
            column(CodigoPostal; CompanyInformation."Post Code") { }
            column(Municipio; CompanyInformation.City) { }
            column(No_SalesHeaderBarCode; '*' + "Sales Header"."No." + '*') { }
            column(FormPay; formPay) { }
            column(UsoCFDI; UseCFDI) { }
            column(TRelacion; format(RelationType)) { }
            column(Metodpag; PayMethod) { }
            column(Serie; Serie) { }
            column(Folio; Folio) { }
            column(NoDocExt; "External Document No.") { }
            column(Vencimiento; format("Due Date")) { }
            column(CondicionesPago; CondPago) { }
            column(RegimenFiscal; RegimenFiscal) { }
            column(CFDI; "CFDI Purpose") { }
            column(TipoRelacion; "Relation Type") { }
            column(Informacion; "Bill-to Name") { }
            column(MetodoPago; SATUtilities.GetSATPaymentMethod("Payment Method Code")) { }
            column(CompanyInformation_Picture; CompanyInformation.Picture) { }
            column(CompanyInformation_Name; CompanyInformation.Name) { }
            column(LugarExpTxt; LugarExpTxt) { }
            column(LugarExp; CompanyInformation.City + ', ' + CompanyInformation.County) { }
            column(Address; Address) { }
            column(tels; CompanyInformation."Phone No.") { }
            column(tels2; CompanyInformation."Phone No. 2") { }
            column(rfc; CompanyInformation."VAT Registration No.") { }
            column(CustNo; CustNo) { }
            column(CustName; "Sales Header"."Bill-to Name") { }
            column(CustName2; "Sales Header"."Bill-to Name 2") { }
            column(CustDom; Customer.Address) { }
            column(CustCol; CustCol) { }
            column(CustCdEdo; CustCdEdo) { }
            column(CustCP; CustCP) { }
            column(CustRFC; Customer."VAT Registration No.") { }
            column(CustEmail; CustEmail) { }
            column(SalesHeader_No; "Sales Header"."No.") { }
            column(SalesHeader_DocumentDate; "Sales Header"."Document Date") { }
            column(ImportSubTotal; "Sales Header".Amount) { }
            column(ImportSubTotal2; ImportSubtotal2) { }
            column(importiva; "Sales Header"."Amount Including VAT" - "Sales Header".Amount) { }
            column(Importtotal; TotalCFDI) { }
            column(comentario; comentario) { }
            column(SalesHeader_PaymentMethodCode; CodMethPay) { }
            column(SalesHeader_SalespersonCode; Vendedor) { }
            column(CodVendedText; CodVendedText) { }
            column(CodFormPagTxt; CodFormPagTxt) { }
            column(SalesHeader_FormtoPay; SATUtilities.GetSATPaymentMethod("Payment Method Code")) { }
            column(COMENTCAB; COMENTCAB) { }
            column(TotalDiscountCFDI; TotalDiscountCFDI) { }
            column(ImporteTotalIVA; ImporteTotalIVA) { }
            column(AmountSubTotal; AmountSubTotal) { }
            column(CustomerType; '') { }
            column(TAXID; Customer.NumRegIdTrib) { }
            column(TipoExportacion; TipoExportacion) { }
            column(RegFiscalCliente; RegFiscalCliente) { }
            column(Due_Date; "Due Date") { }
            column(ImportLetra; ImportLetra) { }

            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                DataItemLinkReference = "Sales Header";
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                column(PedimentosNumber; PedimentosNumber) { }
                column(Unidad1; "Unit of Measure Code") { }
                column(Unidad; "Sales Line"."Unit of Measure Std SAT Code") { }
                column(Descuent; DescuentF) { }
                column(No_; "No.") { }
                column(CodProdServ; "Sales Line"."Product-Services Code SAT") { }
                column(Qty; Qty) { }
                column(UM; UM) { }
                column(Descrip; Descrip) { }
                column(Articulo; Articulo) { }
                column(Desc; Desc) { }
                column(PUnitario; PUnitario) { }
                column(Importe; Importe) { }
                column(SalesLine_Quantity; Qty_) { }
                column(SalesLine_UnitofMeasureCode; UM_) { }
                column(SalesLine_Description; Desc_) { }
                column(SalesLine_No; No_) { }
                column(SalesLine_No2; No2_) { }
                column(SalesLine_LineDiscount; DescPorLin_) { }
                column(SalesLine_UnitCostLCY; UnitPrice_) { }
                column(SalesLine_AmountIncludingVAT; ImportInclVAT_) { }
                column(ObjImpL; ObjImpL) { }
                column(Property_Account; "Property Account") { }

                trigger OnPreDataItem()
                begin
                    "Sales Line".SETFILTER("VAT Calculation Type", '<>%1', "Sales Line"."VAT Calculation Type"::"Full VAT");
                end;

                trigger OnAfterGetRecord()
                var
                    PedimientoNo: Text;
                begin
                    cont := cont + 1;

                    // Lógica similar pero adaptada para Sales Line
                    IF "Sales Line".Quantity <> 0 THEN
                        Qty_ := FORMAT("Sales Line".Quantity)
                    ELSE
                        Qty_ := '';

                    IF "Sales Line"."Unit of Measure Code" <> '' THEN
                        UM_ := FORMAT("Sales Line"."Unit of Measure Code")
                    ELSE
                        UM_ := '';

                    // Obtener descripción
                    Desc_ := "Sales Line".Description;
                    if "Sales Line"."Description 2" <> '' then
                        Desc_ := Desc_ + ' ' + "Sales Line"."Description 2";

                    if "Sales Line"."Property Account" <> '' then
                        Desc_ := Desc_ + ' Cuenta predial:' + "Sales Line"."Property Account";

                    CodigoProducto := '';
                    Clear(CodigoProducto);
                    DescuentF := '';

                    IF ("Sales Line"."No." <> '') and (Type = Type::Item) then begin
                        No_ := FORMAT("Sales Line"."No.");
                        if Item.Get(No_) then
                            No2_ := Item."No. 2";
                    end;

                    IF ("Sales Line"."No." <> '') then begin
                        No_ := FORMAT("Sales Line"."No.");
                        DescPorLin_ := FORMAT("Sales Line"."Line Discount %");
                        PorcDesc := '%';
                        CodigoProducto := "Sales Line"."Product-Services Code SAT";
                        DescuentF := FORMAT("Sales Line"."VAT %");
                    END
                    ELSE BEGIN
                        No_ := '';
                        PorcDesc := '';
                        DescPorLin_ := '';
                        CodigoProducto := '';
                        DescuentF := '';
                    END;

                    if (Type <> Type::Item) then
                        No2_ := No_;

                    if (cont > 1) then
                        CodigoProducto := '';

                    IF "Sales Line"."Unit Price" <> 0 THEN
                        UnitPrice_ := FORMAT("Sales Line"."Unit Price")
                    ELSE
                        UnitPrice_ := '';

                    CLEAR(AmountLine);
                    clear(ImportInclVAT_);
                    AmountLine := "Sales Line".Quantity * "Sales Line"."Unit Price";
                    if AmountLine <> 0 then
                        ImportInclVAT_ := format(AmountLine);

                    // Pedimentos (si aplica)
                    Clear(PedimentosNumber);
                    // Aquí podrías implementar lógica para pedimentos si la necesitas

                    // Objeto Impuesto FE4.0
                    Clear(ObjImpL);
                    if cObjetoImp.get("Sales Line"."Objeto Impuesto") then begin
                        ObjImpL := cObjetoImp.Codigo + '-' + cObjetoImp.Descripcion;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            var
                GeneralLedgerSetup: Record "General Ledger Setup";
            begin
                // Certificado.Get(1); // No necesario para documentos no registrados
                Address := CompanyInformation.Address + ' ' + 'COL. ' + CompanyInformation."Address 2" + ' ' + CompanyInformation.City + ' ' + CompanyInformation.County;
                tels := 'TEL: ' + CompanyInformation."Phone No." + ' ' + CompanyInformation."Phone No. 2" + ' ' + 'FAX: ' + CompanyInformation."Fax No.";
                rfc := 'RFC: ' + CompanyInformation."VAT Registration No.";

                // Vendedor    
                IF SalespersonPurchaser.GET("Sales Header"."Salesperson Code") THEN
                    NombreVendedor := SalespersonPurchaser.Name;

                Customer.GET("Sales Header"."Sell-to Customer No.");
                CustNo := "Sales Header"."Sell-to Customer No.";
                CustName := Customer.Name;
                CustName2 := Customer."Name 2";
                CustDom := Customer.Address;
                CustCol := Customer."Address 2";
                CustCdEdo := Customer.City + ' ' + Customer.County;
                CustCP := Customer."Post Code";
                CustRFC := Customer."RFC No.";
                CustEmail := Customer."E-Mail";

                clear(CodMethPay);
                IF PaymentMethod.GET("Sales Header"."Payment Method Code") THEN
                    CodMethPay := PaymentMethod.Description;

                ImportSubTotal := "Sales Header".Amount + DescPedido;
                ImportSubtotal2 := ImportSubTotal - DescPedido;
                Importtotal := "Sales Header"."Amount Including VAT";
                importiva := Importtotal - ImportSubtotal2;

                // Calcular totales (sin usar funciones de timbrado)
                CLEAR(TotalDiscountCFDI);
                TotalDiscountCFDI := "Sales Header"."Invoice Discount Amount";

                clear(ImporteTotalIVA);
                ImporteTotalIVA := "Sales Header"."Amount Including VAT" - "Sales Header".Amount;

                // No hay retenciones en documentos no registrados
                clear(RetentionAmount);
                RetentionAmount := 0;

                // Tipo Exportación FE4.0
                Clear(TipoExportacion);
                cExportacion.Reset();
                if cExportacion.Get("Sales Header"."Tipo Exportacion") then begin
                    TipoExportacion := cExportacion.Codigo + '-' + cExportacion.Descripcion;
                end;

                Clear(RegFiscalCliente);
                if SATTaxScheme.Get(Customer."SAT Tax Regime Classification") then begin
                    RegFiscalCliente := SATTaxScheme."SAT Tax Scheme" + '-' + SATTaxScheme.Description;
                end;

                // Subtotal
                clear(AmountSubTotal);
                AmountSubTotal := "Sales Header".Amount;

                Clear(TotalCFDI);
                TotalCFDI := AmountSubTotal - TotalDiscountCFDI - RetentionAmount + ImporteTotalIVA;

                ImportLetra := numeroATexto(TotalCFDI, "Sales Header"."Currency Code");

                Clear(Vendedor);
                if "Salesperson Code" <> '' THEN begin
                    "Salesperson/Purchaser".Get("Salesperson Code");
                    Vendedor := "Salesperson/Purchaser".Name;
                end;

                CompanyInformation.CalcFields(Picture);
                RelationType := '';
                PaymentMethod.GET("Sales Header"."Payment Method Code");

                FormPay := PaymentMethod.Code + '-' + PaymentMethod.Description;
                if "Sales Header"."CFDI Purpose" <> '' then
                    SATUseCode.GET("Sales Header"."CFDI Purpose");
                UseCFDI := SATUseCode."SAT Use Code" + '-' + SATUseCode.Description;

                PayMethod := '';
                PayMethod := SATUtilities.GetSATPaymentMethodCodeDescription("Sales Header"."Payment Method Code");

                SATTaxScheme.GET(CompanyInformation."SAT Tax Regime Classification");
                RegimenFiscal := CompanyInformation."SAT Tax Regime Classification" + '-' + SATTaxScheme.Description;

                PaymentTerms.Get("Payment Terms Code");
                Condpago := PaymentTerms.Description;

                Serie := FORMAT(getletras("No."));
                Folio := FORMAT(geTnumber("No."));

                COMENTCAB := '';
                // Aquí podrías obtener comentarios de Sales Comment Line para documentos no registrados

                if ("Salesperson Code" <> '') then begin
                    SalesPurchPerson.Get("Salesperson Code");
                    VendedorMail := SalesPurchPerson."E-Mail";
                    VendedorNombre := SalesPurchPerson.Name;
                end;

                GeneralLedgerSetup.get;

                IF "Currency Code" <> '' THEN begin
                    Moneda := "Currency Code";
                    TipoCambio := Format(1 / "Currency Factor");
                end else begin
                    Moneda := GeneralLedgerSetup."LCY Code";
                    TipoCambio := Format(1);
                end;
            end;
        }
    }

    // Mantener las mismas funciones auxiliares
    procedure geTnumber(cadena: Code[20]): Integer
    var
        num: Decimal;
        i: Decimal;
        cadena2: Text;
    begin
        num := 0;
        FOR i := 1 TO STRLEN(cadena) DO BEGIN
            IF COPYSTR(cadena, i, 1) IN ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'] THEN BEGIN
                cadena2 := cadena2 + COPYSTR(cadena, i, 1);
            END
        END;
        EVALUATE(num, cadena2);
        EXIT(num);
    end;

    procedure getletras(CADENA1: Code[20]): Code[10]
    var
        SERIE: Code[10];
        i: Integer;
    begin
        SERIE := '';
        FOR i := 1 TO STRLEN(CADENA1) DO BEGIN
            IF COPYSTR(CADENA1, i, 1) IN ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'] THEN BEGIN
                SERIE := COPYSTR(CADENA1, 1, i - 1);
                EXIT(SERIE)
            END;
        END;
        EXIT(SERIE);
    end;

    procedure numeroATexto(nNumero: Decimal; currency: Code[20]) cTextoNumero: Text[256]
    var
        String: Text;
        Pos: Integer;
        Text3: Text;
        nLongitud: Integer;
        cNumero: Text;
        nMod: Decimal;
        Textos: array[5] of Text;
        nVueltas: Integer;
        i: Integer;
        cGrupo3: Text;
        nGrupo3: Integer;
        cText: Text;
        nEntero: Integer;
        nDecimales: Decimal;
        cDecimales: Text;
    begin
        // Misma implementación que en el reporte original
        nEntero := ROUND(nNumero, 1, '<');
        nDecimales := nNumero - nEntero;
        nDecimales := ROUND(nDecimales, 0.01, '=');
        IF nDecimales < 0.1 THEN
            cDecimales := '0' + FORMAT(nDecimales * 100)
        ELSE
            cDecimales := FORMAT(nDecimales * 100);
        cNumero := FORMAT(nEntero);
        Textos[1] := '';
        Textos[2] := 'mil';
        Textos[3] := 'millones';
        Textos[4] := 'mil millones';
        nLongitud := STRLEN(cNumero);
        nMod := nLongitud MOD 3;
        CASE nMod OF
            1:
                cNumero := '00' + cNumero;
            2:
                cNumero := '0' + cNumero;
        END;
        nLongitud := STRLEN(cNumero);
        nVueltas := nLongitud / 3;
        cTextoNumero := '';
        FOR i := 1 TO nVueltas DO BEGIN
            cGrupo3 := COPYSTR(cNumero, (i * 3) - 2, 3);
            nGrupo3 := Val(cGrupo3);
            cText := '';
            IF nGrupo3 <> 0 THEN BEGIN
                cText := Text3(nGrupo3);
                cTextoNumero := cTextoNumero + ' ' + cText + ' ' + Textos[nVueltas - i + 1];
            END;
            if (nVueltas = 3) then begin
                if nGrupo3 = 1 then begin
                    String := '   un millones';
                    Pos := STRPOS(cTextoNumero, String);
                    IF Pos > 0 THEN
                        cTextoNumero := ' un millon';
                end;
            end;
        END;

        CASE currency OF
            '':
                cTextoNumero := cTextoNumero + ' PESOS' + ' ' + cDecimales + '/100' + ' M.N.';
            'MX':
                cTextoNumero := cTextoNumero + ' PESOS' + ' ' + cDecimales + '/100' + ' M.N.';
            'MXN':
                cTextoNumero := cTextoNumero + ' PESOS' + ' ' + cDecimales + '/100' + ' M.N.';
            'USD':
                cTextoNumero := cTextoNumero + ' DOLARES' + ' ' + cDecimales + '/100' + ' USD';
            'EUR':
                cTextoNumero := cTextoNumero + ' EUROS' + ' ' + cDecimales + '/100' + ' EUR';
            'US DOLAR':
                cTextoNumero := cTextoNumero + ' DOLARES' + ' ' + cDecimales + '/100' + ' USD';
        END;
    end;


    //=================================


    procedure Exp(VAR nNumero: Integer; VAR nExp: Integer) nValExp: Integer
    var
        i: Integer;
    begin
        nValExp := 0;
        CASE nExp OF
            0:
                nValExp := 1;
            ELSE BEGIN
                nValExp := 1;
                FOR i := 1 TO nExp DO
                    nValExp := nValExp * nNumero;
            END;
        END;
    end;


    procedure Text3(VAR Numero: Integer) cTextoNum: Text[150]
    var
        Unidades: array[10] of Text;
        Dieces: array[10] of Text;
        Decenas: array[10] of Text;
        centenas: array[10] of Text;
        //cNumTem:Text;
        //cDigUni:Text;
        //cDigDec:Text;
        //cDigCen:Text;
        //nDigUni:Integer;
        //nDigDec:Integer;
        //nDigCen:Integer;


        //Unidades:Text;
        //Decenas:	Text;
        //Centenas:	Text;
        //Dieces:	Text;
        cConector: Text;
        nDigUni: Integer;
        nDigDec: Integer;
        nDigCen: Integer;
        cCentenas: Text;
        cUnidades: Text;
        cDecenas: Text;
        cNumTem: Text;
        cDigUni: Text;
        cDigDec: Text;
        cDigCen: Text;
    begin
        Unidades[1] := 'un';
        Unidades[2] := 'dos';
        Unidades[3] := 'tres';
        Unidades[4] := 'cuatro';
        Unidades[5] := 'cinco';
        Unidades[6] := 'seis';
        Unidades[7] := 'siete';
        Unidades[8] := 'ocho';
        Unidades[9] := 'nueve';
        Dieces[1] := 'once';
        Dieces[2] := 'doce';
        Dieces[3] := 'trece';
        Dieces[4] := 'catorce';
        Dieces[5] := 'quince';
        Dieces[6] := 'dieciseis';
        Dieces[7] := 'diecisiete';
        Dieces[8] := 'dieciocho';
        Dieces[9] := 'diecinueve';
        Decenas[1] := 'diez';
        Decenas[2] := 'veinti';
        Decenas[3] := 'treinta';
        Decenas[4] := 'cuarenta';
        Decenas[5] := 'cincuenta';
        Decenas[6] := 'sesenta';
        Decenas[7] := 'setenta';
        Decenas[8] := 'ochenta';
        Decenas[9] := 'noventa';
        Centenas[1] := 'ciento';
        Centenas[2] := 'doscientos';
        Centenas[3] := 'trescientos';
        Centenas[4] := 'cuatrocientos';
        Centenas[5] := 'quinientos';
        Centenas[6] := 'seiscientos';
        Centenas[7] := 'setecientos';
        Centenas[8] := 'ochocientos';
        Centenas[9] := 'novecientos';

        cNumTem := FORMAT(Numero);
        CASE STRLEN(cNumTem) OF
            2:
                cNumTem := '0' + cNumTem;
            1:
                cNumTem := '00' + cNumTem
        END;
        cDigUni := COPYSTR(cNumTem, 3, 1);
        cDigDec := COPYSTR(cNumTem, 2, 1);
        cDigCen := COPYSTR(cNumTem, 1, 1);
        nDigUni := Val(cDigUni);
        nDigDec := Val(cDigDec);
        nDigCen := Val(cDigCen);

        IF nDigUni = 0 THEN
            cUnidades := ''
        ELSE
            cUnidades := Unidades[nDigUni];
        IF nDigDec = 0 THEN BEGIN
            cDecenas := '';
        END
        ELSE BEGIN
            IF (nDigUni <> 0) AND (nDigDec = 1) THEN BEGIN
                cUnidades := '';
                cDecenas := Dieces[nDigUni];
            END
            ELSE
                cDecenas := Decenas[nDigDec];
        END;
        IF (nDigDec = 2) AND (nDigUni = 0) THEN cDecenas := 'veinte';

        IF nDigCen = 0 THEN
            cCentenas := ''
        ELSE BEGIN
            IF (nDigCen = 1) AND (nDigDec = 0) AND (nDigUni = 0) THEN
                cCentenas := 'Cien'
            ELSE
                cCentenas := Centenas[nDigCen];
        END;
        cConector := ' ';
        IF (nDigUni <> 0) AND (nDigDec <> 0) AND (nDigDec <> 2) AND (nDigDec <> 1) THEN
            cConector := ' y ';
        IF (nDigDec = 2) AND (nDigUni <> 0) THEN cConector := '';
        cTextoNum := cCentenas + ' ' + cDecenas + cConector + cUnidades;
    end;

    procedure Val(VAR cNumText: Text[10]) nValor: Integer

    var
        nlongitud: Integer;
        i: Integer;
        cCaracter: char;
        nDigito: Integer;
        nbase: Integer;
        nexponente: Integer;
        ndec: Decimal;
    begin
        // Transforma una cadena en valor numerico

        nLongitud := STRLEN(cNumText);
        nValor := 0;
        FOR i := nLongitud DOWNTO 1 DO BEGIN
            cCaracter := cNumText[i];
            CASE cNumText[i] OF
                '0':
                    nDigito := 0;
                '1':
                    nDigito := 1;
                '2':
                    nDigito := 2;
                '3':
                    nDigito := 3;
                '4':
                    nDigito := 4;
                '5':
                    nDigito := 5;
                '6':
                    nDigito := 6;
                '7':
                    nDigito := 7;
                '8':
                    nDigito := 8;
                '9':
                    nDigito := 9;
            END;
            nBase := 10;
            nExponente := nLongitud - i;
            nDec := Exp(nBase, nExponente);
            nValor := (nDigito * nDec) + nValor;
        END

    end;

    var
        CompanyInformation: Record "Company Information";
        LugarExpTxt: Label 'Lugar de Expedición:';
        Address: Text[250];
        tels: Code[100];
        rfc: Code[30];
        SucurTxt: Label 'Sucursales';
        PedidoVentaTxt: Label 'No. PEDIDO VENTA';
        FechaExpTxt: Label 'FECHA EXPEDICION:';
        DatosfiscClienteTxt: Label 'DATOS FISCALES DEL CLIENTE';
        DatSucCordoba1: Label 'Cordoba, Ver.';
        DatSucCordoba2: Label 'Av. 11 No. 1022 Col . Federal';
        DatSucCordoba3: Label 'C.P. 94500 Cordoba, Ver.';
        DatSucCordoba4: Label 'Tels (271) 714-77-85';
        DatSucCordoba5: Label '714-77-89';
        DatSucCordoba6: Label 'Fax (271) 714-94-85';
        DatSucCordoba7: Label 'Nextel/Tel 62*234555*2';
        DatSucCordoba8: Label '/ (222) 444-3407';
        DatSucTehuacan1: Label 'Tehuacan, Pue.';
        DatSucTehuacan2: Label '14 Norte No. 147';
        DatSucTehuacan3: Label 'Col. Aquiles Serdan';
        DatSucTehuacan4: Label 'C.P. 75750 Tehuacan, Pue.';
        DatSucTehuacan5: Label 'Tel y Fax (238) 392-23-68';
        DatSucTehuacan6: Label '384-70-37';
        DatSucTehuacan7: Label 'Nextel/Tel 62*234555*3';
        DatSucTehuacan8: Label '(222) 444-3437';
        DatClienteDom: Label 'DOM.';
        DatClienteCol: Label 'COLONIA';
        DatClienteCdEdo: Label 'CIUDAD Y EDO.';
        DatClienteCP: Label 'C.P.';
        DatClienteRFC: Label 'R.F.C';
        DatClienteEmail: Label 'E-Mail';
        Qty: Label 'CANT.';
        UM: Label 'U. MED.';
        Descrip: Label 'DESCRIPCION';
        Articulo: Label 'ART.';
        Desc: Label '% DESC.';
        PUnitario: Label 'P. UNITARIO';
        Importe: Label 'IMPORTE';
        Customer: Record Customer;
        CustNo: Code[30];
        CustName: Code[100];
        CustName2: Code[100];
        CustDom: Code[100];
        CustCol: Code[100];
        CustCdEdo: Code[100];
        CustCP: Code[30];
        CustRFC: Code[30];
        CantEnLetra: Label 'CANTIDAD EN LETRA:';
        subTotal: Label 'SUB-TOTAL';
        descuento: Label 'DESCUENTO';
        iva: Label 'IVA';
        total: Label 'TOTAL';
        Igual: Label '=';
        ImportLetra: Code[500];
        CodMN: Label 'MN';
        DescPedido: Decimal;
        ImportSubTotal: Decimal;
        ImportSubtotal2: Decimal;
        importiva: Decimal;
        Importtotal: Decimal;
        CustEmail: Text[100];
        comentario: Code[80];
        CodVendedText: Label 'Vendedor';
        CodFormPagTxt: Label 'Cod. Forna Pago';
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        PaymentMethod: Record "Payment Method";
        CodMethPay: Code[50];
        Qty_: Code[30];
        UM_: Code[30];
        Desc_: Text;
        No_: Code[30];

        No2_: Code[30];
        DescPorLin_: Code[30];
        UnitPrice_: Code[30];
        ImportInclVAT_: Code[30];
        formPay: Code[50];
        d: Decimal;
        n: Code[30];
        PorcDesc: Code[10];
        Location: Record Location;
        Codlocation: Decimal;
        BinContent: Record "Bin Content";
        StockkeepingUnit: Record "Stockkeeping Unit";

        Vendedor: Text;


        "Salesperson/Purchaser": Record "Salesperson/Purchaser";

        RelationType: Text;

        SATRelationshipType: Record "SAT Relationship Type";

        UseCFDI: Text;

        SATPaymentMethod: Record "SAT Payment Method";
        SATUseCode: Record "SAT Use Code";
        PayMethod: Text;

        NoFolio: Text;
        HoraRegistro: Text;
        FechaHrEmision: Text;

        LugarExp: Text;

        UUID: Text;

        Condpago: Text;

        PaymentTerms: Record "Payment Terms";

        Certificado: Record Certificado;

        Serie: Text;

        Folio: Text;
        SATTaxScheme: Record "SAT Tax Scheme";
        RegimenFiscal: Text;

        SelloSAT: Text;

        SelloPAC: Text;
        Instr: InStream;

        CadenaOriginalSAT: Text;
        cfdiRelationed: Record "CFDI Relationed";

        CFDIRel: Text;
        CFDIRelationDocumentTmp: Record "CFDI Relation Document";
        CFDIRelationDocument: Record "CFDI Relation Document";
        TipoRelacion: array[10] of Text;
        CfdiRelacionado: array[10] of Text;
        ContCfdiRel: Integer;

        TempSalesInvoiceLine: Record "Sales Invoice Line" temporary;

        SpacePointer: Integer;

        HighestLineNo: Integer;

        COMENTCAB: Text;

        SalesLineComments: Record "Sales Comment Line";

        Lineas: Record "Sales Invoice Line";

        Item: Record Item;

        CodigoProducto: Text;
        DescuentF: Text;

        TempLines: Record "Sales Invoice Line Temp" temporary;

        cont: Integer;

        NombreVendedor: Text;
        SalesPurchPerson: Record "Salesperson/Purchaser";
        VendedorMail: Text;
        VendedorNombre: Text;
        Pedimentos: Record "Lot No. Information";
        PedimentosNumber: Text;
        Moneda: Text;
        TipoCambio: Text;
        TmpSerialNoInformation: Record "Serial No. Information" temporary;
        TmpItemLedgEntry: Record "Item Ledger Entry" temporary;
        TmpLotNo: Record "Lot No. Information" temporary;
        ImportDeclaration: Boolean;

        Timbrado: Codeunit Timbradocfdi;
        AmountSubTotal: Decimal;
        RetentionAmount: Decimal;
        ImporteTotalIVA: Decimal;
        TotalDiscountCFDI: Decimal;
        AmountLine: Decimal;
        TotalCFDI: Decimal;
        Funciones: Codeunit subscriber;
        lineasFacRet: Record "Sales Invoice Line";
        TipoRetencion: array[10] of Text;
        ImporteRetencion: array[10] of Decimal;
        x: Integer;
        //FE4.0
        TipoExportacion: Text;
        cExportacion: Record cExportacion;
        cObjetoImp: Record cObjetoImp;
        ObjImpL: Text;
        RegFiscalCliente: Text;
        SATUtilities: Codeunit subscriber;



    trigger OnPreReport()
    begin

        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
    end;

    Procedure GetCustomDecInfoY(TempSalesInvoiceLine: Record "Sales Invoice Line Temp" temporary)
    var
        LotNo: Record "Lot No. Information";

    begin
        CLEAR(TmpSerialNoInformation);
        Clear(TmpLotNo);
        TmpSerialNoInformation.DELETEALL;
        TmpLotNo.DeleteAll;

        IF CollectAsmInformation1(TempSalesInvoiceLine) THEN BEGIN
            IF TempSalesInvoiceLine.Type = TempSalesInvoiceLine.Type::Item THEN BEGIN
                TmpItemLedgEntry.RESET;
                TmpItemLedgEntry.DELETEALL;
                TempSalesInvoiceLine.GetItemLedgEntries(TmpItemLedgEntry, TRUE);
                TmpItemLedgEntry.RESET;
                IF TmpItemLedgEntry.FINDSET THEN
                    REPEAT
                        IF LotNo.GET(TmpItemLedgEntry."Item No.", TmpItemLedgEntry."Variant Code", TmpItemLedgEntry."Lot No.") THEN BEGIN
                            IF LotNo."No. Customs Declaration" <> '' THEN BEGIN
                                TmpLotNo.INIT;
                                TmpLotNo.TRANSFERFIELDS(LotNo);
                                IF (TmpLotNo.INSERT) THEN
                                    ImportDeclaration := TRUE;
                            END;
                        END;
                    UNTIL TmpItemLedgEntry.NEXT = 0;
            END;
        END;
    end;


    procedure CollectAsmInformation1(TempSalesInvoiceLine: Record "Sales Invoice Line Temp" TEMPORARY): Boolean
    var
        TmpSerialNoInformation: Record "Serial No. Information";
        TempPostedAsmLine: Record "Posted Assembly Line";
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        SalesShipmentLine: Record "Sales Shipment Line";
        PostedAsmLine: Record "Posted Assembly Line";
        PostedAsmHeader: Record "Posted Assembly Header";
        TempItemLedgerEntry: Record "Item Ledger Entry";
        ImportDeclaration: Boolean;
    begin
        CLEAR(TmpSerialNoInformation);
        TmpSerialNoInformation.DELETEALL;

        TempPostedAsmLine.DELETEALL;
        EXIT(TRUE);
    end;
}