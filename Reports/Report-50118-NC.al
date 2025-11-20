report 50118 NotaCreditoVenta
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './ReportLayout/Ventas/NotaCreditoVenta.rdl';
    Caption = 'Nota Credito Ventav2';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = where("Document Type" = filter("Credit Memo"));
            CalcFields = "Amount Including VAT", Amount;
            RequestFilterFields = "No.";

            column(USERID; UserId) { }
            column(Descuentox; "Invoice Discount Amount") { }
            column(Seriex; Serie) { }
            column(foliox; folio) { }
            column(No_SalesHeaderBarCode; '*' + "Sales Header"."No." + '*') { }
            column(Serie; Serie) { }
            column(Folio; Folio) { }
            column(NoDocExt; "External Document No.") { }
            column(Vencimiento; format("Due Date")) { }
            column(CondicionesPago; CondPago) { }
            column(Informacion; "Bill-to Name") { }

            column(CompanyInformation_Picture; CompanyInformation.Picture) { }
            column(CompanyInformation_Name; CompanyInformation.Name) { }
            column(LugarExpTxt; LugarExpTxt) { }
            column(LugarExp; CompanyInformation.City + ', ' + CompanyInformation.County) { }
            column(Address; Address) { }
            column(tels; CompanyInformation."Phone No.") { }
            column(rfc; CompanyInformation."VAT Registration No.") { }

            column(FORMAT__Sales_Header___Document_Type____________Sales_Header___No__; Format("Sales Header"."Document Type") + ' ' + "Sales Header"."No.") { }
            column(SellToAddr_1; SellToAddr[1]) { }
            column(SellToAddr_2; SellToAddr[2]) { }
            column(SellToAddr_3; SellToAddr[3]) { }
            column(SellToAddr_4; SellToAddr[4]) { }
            column(SellToAddr_5; SellToAddr[5]) { }
            column(SellToAddr_6; SellToAddr[6]) { }
            column(SellToAddr_7; SellToAddr[7]) { }
            column(SellToAddr_8; SellToAddr[8]) { }
            column(Sales_Header___Ship_to_Code_Caption; "Sales Header".FieldCaption("Ship-to Code")) { }
            column(Sales_Header___Ship_to_Code_; "Sales Header"."Ship-to Code") { }
            column(ShipToAddr_1; ShipToAddr[1]) { }
            column(ShipToAddr_2; ShipToAddr[2]) { }
            column(ShipToAddr_3; ShipToAddr[3]) { }
            column(ShipToAddr_4; ShipToAddr[4]) { }
            column(ShipToAddr_5; ShipToAddr[5]) { }
            column(ShipToAddr_6; ShipToAddr[6]) { }
            column(ShipToAddr_7; ShipToAddr[7]) { }
            column(ShipToAddr_8; ShipToAddr[8]) { }
            column(Sales_Header___Bill_to_Customer_No__; "Sales Header"."Bill-to Customer No.") { }
            column(BillToAddr_1; BillToAddr[1]) { }
            column(BillToAddr_2; BillToAddr[2]) { }
            column(BillToAddr_3; BillToAddr[3]) { }
            column(BillToAddr_4; BillToAddr[4]) { }
            column(BillToAddr_5; BillToAddr[5]) { }
            column(BillToAddr_6; BillToAddr[6]) { }
            column(BillToAddr_7; BillToAddr[7]) { }
            column(BillToAddr_8; BillToAddr[8]) { }

            column(SucurTxt; SucurTxt) { }
            column(PedidoVentaTxt; PedidoVentaTxt) { }
            column(FechaExpTxt; FechaExpTxt) { }
            column(DatosfiscClienteTxt; DatosfiscClienteTxt) { }

            column(DatSucCordoba1; DatSucCordoba1) { }
            column(DatSucCordoba2; DatSucCordoba2) { }
            column(DatSucCordoba3; DatSucCordoba3) { }
            column(DatSucCordoba4; DatSucCordoba4) { }
            column(DatSucCordoba5; DatSucCordoba5) { }
            column(DatSucCordoba6; DatSucCordoba6) { }
            column(DatSucCordoba7; DatSucCordoba7) { }
            column(DatSucCordoba8; DatSucCordoba8) { }
            column(DatSucTehuacan1; DatSucTehuacan1) { }
            column(DatSucTehuacan2; DatSucTehuacan2) { }
            column(DatSucTehuacan3; DatSucTehuacan3) { }
            column(DatSucTehuacan4; DatSucTehuacan4) { }
            column(DatSucTehuacan5; DatSucTehuacan5) { }
            column(DatSucTehuacan6; DatSucTehuacan6) { }
            column(DatSucTehuacan7; DatSucTehuacan7) { }
            column(DatSucTehuacan8; DatSucTehuacan8) { }

            column(DatClienteDom; DatClienteDom) { }
            column(DatClienteCol; DatClienteCol) { }
            column(DatClienteCdEdo; DatClienteCdEdo) { }
            column(DatClienteCP; DatClienteCP) { }
            column(DatClienteRFC; DatClienteRFC) { }
            column(DatClienteEmail; DatClienteEmail) { }

            column(CustNo; CustNo) { }
            column(CustName; "Sales Header"."Bill-to Name") { }
            column(CustDom; Customer.Address) { }
            column(CustCol; CustCol) { }
            column(CustCdEdo; CustCdEdo) { }
            column(CustCP; CustCP) { }
            column(CustRFC; Customer."VAT Registration No.") { }
            column(CustEmail; CustEmail) { }

            column(SalesHeader_No; "Sales Header"."No.") { }
            column(SalesHeader_PostingDate; "Sales Header"."Posting Date") { }

            column(ImportSubTotal; SubTotalCFDI) { }
            column(DescPedido; DescPedido) { }
            column(ImportSubTotal2; ImportSubtotal2) { }
            column(importiva; ImporteTotalIVA) { }
            column(Importtotal; TotalCFDI) { }
            column(comentario; comentario) { }

            column(SalesHeader_PaymentMethodCode; CodMethPay) { }
            column(CodVendedText; CodVendedText) { }
            column(CodFormPagTxt; CodFormPagTxt) { }
            column(SalesHeader_FormtoPay; "Payment Method Code") { }

            // *** CAMPOS ADICIONALES DEL ENCABEZADO ***
            column(SalesHeader_ExternalDocumentNo; "External Document No.") { }
            column(SalesHeader_SalespersonCode; "Salesperson Code") { }
            column(SalesHeader_CustomerPostingGroup; "Customer Posting Group") { }
            column(SalesHeader_YourReference; "Your Reference") { }
            column(SalesHeader_CustomerDiscGroup; "Customer Disc. Group") { }
            column(SalesHeader_InvoiceDiscCode; "Invoice Disc. Code") { }
            column(SalesHeader_PaymentTermsCode; "Payment Terms Code") { }
            column(SalesHeader_PaymentDiscount; "Payment Discount %") { }
            column(SalesHeader_DueDate; Format("Due Date")) { }
            column(SalesHeader_PmtDiscountDate; Format("Pmt. Discount Date")) { }
            column(SalesHeader_ShipmentMethodCode; "Shipment Method Code") { }
            column(SalesHeader_DocumentDate; Format("Document Date")) { }
            column(SalesHeader_OrderDate; Format("Order Date")) { }
            column(SalesHeader_ShipmentDate; Format("Shipment Date")) { }
            column(SalesHeader_PricesIncludingVAT; "Prices Including VAT") { }
            column(SalesHeader_PricesIncludingVATFormat2; Format("Prices Including VAT")) { }

            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type"),
                               "Document No." = field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.");

                column(Descuent; "Sales Line"."Line Discount %") { }
                column(Unidad; "Unit of Measure Code") { }
                column(CodigoPostal; CompanyInformation."Post Code") { }
                column(CodProdServ; CodProdServ) { }

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
                column(SalesLine_Type; TypeText) { }
                column(CantEnLetra; CantEnLetra) { }
                column(subTotal; subTotal) { }
                column(descuento; descuento) { }
                column(iva; iva) { }
                column(total; total) { }
                column(Igual; Igual) { }
                column(ImportLetra; ImportLetra) { }
                column(CodMN; CodMN) { }
                column(PorcDesc; PorcDesc) { }
                column(Codlocation; Codlocation) { }
                column(Unit_of_Measure_Code; "Unit of Measure Code") { }

                trigger OnAfterGetRecord()
                begin
                    if "Sales Line"."No." <> '' then
                        CodProdServ := "Sales Line"."No."
                    else
                        CodProdServ := '';
                    case "Sales Line".Type of
                        "Sales Line".Type::" ":
                            TypeText := 'Comentario';
                        "Sales Line".Type::"G/L Account":
                            TypeText := 'Cuenta';
                        "Sales Line".Type::Item:
                            TypeText := 'Artículo';
                        "Sales Line".Type::Resource:
                            TypeText := 'Recurso';
                        "Sales Line".Type::"Fixed Asset":
                            TypeText := 'Activo Fijo';
                        "Sales Line".Type::"Charge (Item)":
                            TypeText := 'Cargo (Prod.)';
                    end;
                    n := "Sales Line"."No.";
                    d := "Sales Line".Quantity;

                    StockkeepingUnit.RESET;
                    StockkeepingUnit.SETRANGE("Location Code", '001');
                    StockkeepingUnit.SETRANGE("Item No.", "Sales Line"."No.");

                    if StockkeepingUnit.FINDSET then begin
                        StockkeepingUnit.CALCFIELDS(Inventory);
                        Codlocation := StockkeepingUnit.Inventory;
                    end else
                        Codlocation := 0;

                    if "Sales Line".Quantity <> 0 then
                        Qty_ := FORMAT(ABS("Sales Line".Quantity))
                    else
                        Qty_ := '';

                    if "Sales Line"."Unit of Measure Code" <> '' then
                        UM_ := FORMAT("Sales Line"."Unit of Measure Code")
                    else
                        UM_ := '';

                    Desc_ := FORMAT("Sales Line".Description);

                    if "Sales Line"."No." <> '' then begin
                        No_ := FORMAT("Sales Line"."No.");
                        DescPorLin_ := FORMAT("Sales Line"."Line Discount %");
                        PorcDesc := '%';
                    end else begin
                        No_ := '';
                        PorcDesc := '';
                        DescPorLin_ := '';
                    end;

                    if "Sales Line"."Unit Price" <> 0 then
                        UnitPrice_ := FORMAT(ABS("Sales Line"."Unit Price"))
                    else
                        UnitPrice_ := '';

                    Clear(AmountLine);
                    AmountLine := "Sales Line"."Line Amount";

                    if AmountLine <> 0 then
                        ImportInclVAT_ := FORMAT(AmountLine)
                    else
                        ImportInclVAT_ := '';
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Address := CompanyInformation.Address + ' ' + 'COL. ' + CompanyInformation."Address 2" + ' ' + CompanyInformation.City + ' ' + CompanyInformation.County;
                tels := 'TEL: ' + CompanyInformation."Phone No." + ' ' + CompanyInformation."Phone No. 2" + ' ' + 'FAX: ' + CompanyInformation."Fax No.";
                rfc := 'RFC: ' + CompanyInformation."VAT Registration No.";

                // *** FORMATEAR LAS DIRECCIONES USANDO FormatAddr ***
                FormatAddr.SalesHeaderSellTo(SellToAddr, "Sales Header");
                FormatAddr.SalesHeaderBillTo(BillToAddr, "Sales Header");
                FormatAddr.SalesHeaderShipTo(ShipToAddr, ShipToAddr, "Sales Header");

                Customer.GET("Sales Header"."Sell-to Customer No.");
                CustNo := "Sales Header"."Sell-to Customer No.";
                CustName := Customer.Name;
                CustDom := Customer.Address;
                CustCol := Customer."Address 2";
                CustCdEdo := Customer.City + ' ' + Customer.County;
                CustCP := Customer."Post Code";
                CustRFC := Customer."VAT Registration No.";
                CustEmail := Customer."E-Mail";

                CodMethPay := '';
                if PaymentMethod.GET("Sales Header"."Payment Method Code") then
                    CodMethPay := PaymentMethod.Description;

                ImporteTotalIVA := 0;
                SubTotalCFDI := 0;
                TotalDiscCFDI := 0;

                SubTotalCFDI := "Sales Header".Amount;
                ImporteTotalIVA := "Sales Header"."Amount Including VAT" - "Sales Header".Amount;
                TotalCFDI := "Sales Header"."Amount Including VAT";

                ImportLetra := numeroATexto(TotalCFDI, "Sales Header"."Currency Code");

                ImportSubTotal := "Sales Header".Amount + DescPedido;
                ImportSubtotal2 := ImportSubTotal - DescPedido;
                Importtotal := "Sales Header"."Amount Including VAT";
                importiva := Importtotal - ImportSubtotal2;

                CompanyInformation.CalcFields(Picture);

                PaymentTerms.Get("Payment Terms Code");
                Condpago := PaymentTerms.Description;

                Serie := FORMAT(getletras("No."));
                Folio := FORMAT(geTnumber("No."));
            end;
        }
    }

    procedure geTnumber(cadena: Code[20]): Integer
    var
        num: Decimal;
        i: Decimal;
        cadena2: Text;
    begin
        num := 0;
        for i := 1 to STRLEN(cadena) do begin
            if COPYSTR(cadena, i, 1) in ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'] then begin
                cadena2 := cadena2 + COPYSTR(cadena, i, 1);
            end
        end;
        EVALUATE(num, cadena2);
        exit(num);
    end;

    procedure getletras(CADENA1: Code[20]): Code[10]
    var
        SERIE: Code[10];
        i: Integer;
    begin
        SERIE := '';
        for i := 1 to STRLEN(CADENA1) do begin
            if COPYSTR(CADENA1, i, 1) in ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'] then begin
                SERIE := COPYSTR(CADENA1, 1, i - 1);
                exit(SERIE)
            end;
        end;
        exit(SERIE);
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
        nEntero := ROUND(nNumero, 1, '<');
        nDecimales := nNumero - nEntero;
        nDecimales := ROUND(nDecimales, 0.01, '=');
        if nDecimales < 0.1 then
            cDecimales := '0' + FORMAT(nDecimales * 100)
        else
            cDecimales := FORMAT(nDecimales * 100);
        cNumero := FORMAT(nEntero);
        Textos[1] := '';
        Textos[2] := 'mil';
        Textos[3] := 'millones';
        Textos[4] := 'mil millones';
        nLongitud := STRLEN(cNumero);
        nMod := nLongitud MOD 3;
        case nMod of
            1:
                cNumero := '00' + cNumero;
            2:
                cNumero := '0' + cNumero;
        end;
        nLongitud := STRLEN(cNumero);
        nVueltas := nLongitud / 3;
        cTextoNumero := '';
        for i := 1 to nVueltas do begin
            cGrupo3 := COPYSTR(cNumero, (i * 3) - 2, 3);
            nGrupo3 := Val(cGrupo3);
            cText := '';
            if nGrupo3 <> 0 then begin
                cText := Text3(nGrupo3);
                cTextoNumero := cTextoNumero + ' ' + cText + ' ' + Textos[nVueltas - i + 1];
            end;
            if (nVueltas = 3) then begin
                if nGrupo3 = 1 then begin
                    String := '   un millones';
                    Pos := STRPOS(cTextoNumero, String);
                    if Pos > 0 then
                        cTextoNumero := ' un millon';
                end;
            end;
        end;

        case currency of
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
        end;
    end;

    procedure Exp(var nNumero: Integer; var nExp: Integer) nValExp: Integer
    var
        i: Integer;
    begin
        nValExp := 0;
        case nExp of
            0:
                nValExp := 1;
            else begin
                nValExp := 1;
                for i := 1 to nExp do
                    nValExp := nValExp * nNumero;
            end;
        end;
    end;

    procedure Text3(var Numero: Integer) cTextoNum: Text[150]
    var
        Unidades: array[10] of Text;
        Dieces: array[10] of Text;
        Decenas: array[10] of Text;
        centenas: array[10] of Text;
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
        case STRLEN(cNumTem) of
            2:
                cNumTem := '0' + cNumTem;
            1:
                cNumTem := '00' + cNumTem
        end;
        cDigUni := COPYSTR(cNumTem, 3, 1);
        cDigDec := COPYSTR(cNumTem, 2, 1);
        cDigCen := COPYSTR(cNumTem, 1, 1);
        nDigUni := Val(cDigUni);
        nDigDec := Val(cDigDec);
        nDigCen := Val(cDigCen);

        if nDigUni = 0 then
            cUnidades := ''
        else
            cUnidades := Unidades[nDigUni];
        if nDigDec = 0 then begin
            cDecenas := '';
        end else begin
            if (nDigUni <> 0) and (nDigDec = 1) then begin
                cUnidades := '';
                cDecenas := Dieces[nDigUni];
            end else
                cDecenas := Decenas[nDigDec];
        end;
        if (nDigDec = 2) and (nDigUni = 0) then cDecenas := 'veinte';

        if nDigCen = 0 then
            cCentenas := ''
        else begin
            if (nDigCen = 1) and (nDigDec = 0) and (nDigUni = 0) then
                cCentenas := 'Cien'
            else
                cCentenas := Centenas[nDigCen];
        end;
        cConector := ' ';
        if (nDigUni <> 0) and (nDigDec <> 0) and (nDigDec <> 2) and (nDigDec <> 1) then
            cConector := ' y ';
        if (nDigDec = 2) and (nDigUni <> 0) then cConector := '';
        cTextoNum := cCentenas + ' ' + cDecenas + cConector + cUnidades;
    end;

    procedure Val(var cNumText: Text[10]) nValor: Integer
    var
        nlongitud: Integer;
        i: Integer;
        cCaracter: char;
        nDigito: Integer;
        nbase: Integer;
        nexponente: Integer;
        ndec: Decimal;
    begin
        nLongitud := STRLEN(cNumText);
        nValor := 0;
        for i := nLongitud downto 1 do begin
            cCaracter := cNumText[i];
            case cNumText[i] of
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
            end;
            nBase := 10;
            nExponente := nLongitud - i;
            nDec := Exp(nBase, nExponente);
            nValor := (nDigito * nDec) + nValor;
        end
    end;

    var
        TypeText: Text[50];
        CompanyInformation: Record "Company Information";

        // *** NUEVAS VARIABLES PARA DIRECCIONES ***
        FormatAddr: Codeunit "Format Address";
        SellToAddr: array[8] of Text[100];
        BillToAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];

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
        PaymentMethod: Record "Payment Method";
        CodMethPay: Code[50];
        Qty_: Code[30];
        UM_: Code[30];
        Desc_: Text;
        No_: Code[30];
        DescPorLin_: Code[30];
        UnitPrice_: Code[30];
        ImportInclVAT_: Code[30];
        d: Decimal;
        n: Code[30];
        PorcDesc: Code[10];
        Codlocation: Decimal;
        StockkeepingUnit: Record "Stockkeeping Unit";
        NoFolio: Text;
        HoraRegistro: Text;
        FechaHrEmision: Text;
        LugarExp: Text;
        Condpago: Text;
        PaymentTerms: Record "Payment Terms";
        Serie: Text;
        Folio: Text;
        CodProdServ: Code[20];
        No2_: Code[30];
        AmountLine: Decimal;
        SubTotalCFDI: Decimal;
        TotalCFDI: Decimal;
        ImporteTotalIVA: Decimal;
        TotalDiscCFDI: Decimal;

    trigger OnPreReport()
    begin
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);

        if "Sales Header".GETFILTER("No.") = '' then begin
            "Sales Header".RESET;
            "Sales Header".SETRANGE("Document Type", "Sales Header"."Document Type"::"Credit Memo");
            if "Sales Header".FINDLAST then
                "Sales Header".SETFILTER("No.", "Sales Header"."No.");
        end;
    end;
}