report 50116 "MovimientosCliente"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/Cliente/MovimientosCliente.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'Movimientos de Cliente';
    Permissions = TableData "Cust. Ledger Entry" = r;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = sorting("Customer No.", "Posting Date");
            RequestFilterFields = "Customer No.", "Document Type";
            column(OpcionesFiltrado; GetOpcionesFiltrado())
            {
            }
            column(FechaCreacion; Format(Today, 0, '<Day,2>/<Month,2>/<Year4> HH:mm:ss'))
            {
            }
            column(NombreEmpresa; COMPANYPROPERTY.DisplayName())
            {
            }
            column(TipoMovimiento; GetTipoMovimiento("Entry No."))
            {
            }
            column(DocumentoOrigen; "Document No.")
            {
            }
            column(FechaRegistro; Format("Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(TipoDocumento; "Document Type")
            {
            }
            column(NumeroDocumento; "Document No.")
            {
            }
            column(NumeroDocExterno; "External Document No.")
            {
            }
            column(Importe; Amount)
            {
                AutoFormatType = 1;
            }
            column(ImporteUSD; GetImporteUSD(Amount))
            {
                AutoFormatType = 1;
            }
            column(Divisa; 'USD')
            {
            }
            column(Metodo; "Payment Method Code")
            {
            }
            column(FormaPago; "Form to Pay")
            {
            }
            column(NumeroCliente; "Customer No.")
            {
            }
            column(NombreCliente; GetCustomerName("Customer No."))
            {
            }
            column(Estatus; "Electronic Document Status")
            {
            }
            column(EstatusCancelacion; GetEstatusCancelacion("Entry No."))
            {
            }
            column(Usuario; "User ID")
            {
            }
            column(UUID; "Fiscal Invoice Number PAC")
            {
            }
            column(FechaHoraFirma; "Posting DateTime Payment")
            {
            }
            column(Description; Description)
            {
            }
            column(TipoCambio; GetTipoCambioRelacionado("Entry No."))
            {
            }
            column(DimensionSetID; "Dimension Set ID")
            {
            }

            dataitem("Dimension Set Entry"; "Dimension Set Entry")
            {
                DataItemLink = "Dimension Set ID" = field("Dimension Set ID");
                DataItemTableView = sorting("Dimension Set ID", "Dimension Code");
                column(DimensionCode; "Dimension Code")
                {
                }
                column(DimensionValueCode; "Dimension Value Code")
                {
                }
                column(DimensionName; GetDimensionName("Dimension Code"))
                {
                }
                column(DimensionValueName; GetDimensionValueName("Dimension Code", "Dimension Value Code"))
                {
                }
            }

            trigger OnPreDataItem()
            begin
                if StartDate <> 0D then
                    SetFilter("Posting Date", '>=%1', StartDate);
                if EndDate <> 0D then
                    SetFilter("Posting Date", '<=%1', EndDate);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Filtros)
                {
                    Caption = 'Opciones de filtrado';

                    field(FechaInicio; StartDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Fecha Inicio';
                        ToolTip = 'Especifica la fecha inicial del período';
                    }
                    field(FechaFin; EndDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Fecha Fin';
                        ToolTip = 'Especifica la fecha final del período';
                    }
                    field(FiltroCliente; CustomerFilter)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cliente';
                        ToolTip = 'Especifica el cliente a filtrar';
                        TableRelation = Customer."No.";
                    }
                    field(FiltroTipoDocumento; DocTypeFilter)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tipo Documento';
                        ToolTip = 'Especifica el tipo de documento';
                    }
                    field(FiltroEstatus; StatusFilter)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Estatus';
                        ToolTip = 'Especifica el estatus del movimiento';
                    }
                }
            }
        }
    }

    var
        StartDate: Date;
        EndDate: Date;
        CustomerFilter: Text;
        DocTypeFilter: Text;
        StatusFilter: Text;

    local procedure GetCustomerName(CustomerNo: Code[20]): Text
    var
        Customer: Record Customer;
    begin
        if Customer.Get(CustomerNo) then
            exit(Customer.Name);
        exit('');
    end;

    local procedure GetOpcionesFiltrado(): Text
    var
        FilterText: Text;
    begin
        FilterText := '';

        if StartDate <> 0D then
            FilterText := Format(StartDate, 0, '<Day,2>/<Month,2>/<Year4>');

        if EndDate <> 0D then begin
            if FilterText <> '' then
                FilterText += ' ... ';
            FilterText += Format(EndDate, 0, '<Day,2>/<Month,2>/<Year4>');
        end;

        exit(FilterText);
    end;

    local procedure GetTipoCambioRelacionado(EntryNo: Integer): Decimal
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        if CustLedgEntry.Get(EntryNo) then begin
            if CustLedgEntry."Original Currency Factor" <> 0 then
                exit(1.0000 / CustLedgEntry."Original Currency Factor")
            else if CustLedgEntry."Adjusted Currency Factor" <> 0 then
                exit(1.0000 / CustLedgEntry."Adjusted Currency Factor");
        end;
        exit(0);
    end;

    local procedure GetUUID(EntryNo: Integer): Text
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        if CustLedgEntry.Get(EntryNo) then
            exit(CustLedgEntry."External Document No.");
        exit('');
    end;

    local procedure GetTipoMovimiento(EntryNo: Integer): Text
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        if CustLedgEntry.Get(EntryNo) then begin
            case CustLedgEntry."Document Type" of
                CustLedgEntry."Document Type"::Invoice:
                    exit('Factura');
                CustLedgEntry."Document Type"::Payment:
                    exit('Pago');
                CustLedgEntry."Document Type"::"Credit Memo":
                    exit('Nota de Crédito');
                CustLedgEntry."Document Type"::"Finance Charge Memo":
                    exit('Cargo Financiero');
                CustLedgEntry."Document Type"::Reminder:
                    exit('Recordatorio');
                else
                    exit('Otro');
            end;
        end;
        exit('');
    end;

    local procedure GetImporteUSD(Amount: Decimal): Decimal
    begin
        exit(Amount);
    end;

    local procedure GetEstatusCancelacion(EntryNo: Integer): Text
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        if CustLedgEntry.Get(EntryNo) then begin
            if CustLedgEntry.Open then
                exit('Abierto')
            else
                exit('Cerrado');
        end;
        exit('');
    end;

    local procedure GetDimensionName(DimensionCode: Code[20]): Text
    var
        Dimension: Record Dimension;
    begin
        if Dimension.Get(DimensionCode) then
            exit(Dimension.Name);
        exit('');
    end;

    local procedure GetDimensionValueName(DimensionCode: Code[20]; DimensionValueCode: Code[20]): Text
    var
        DimensionValue: Record "Dimension Value";
    begin
        if DimensionValue.Get(DimensionCode, DimensionValueCode) then
            exit(DimensionValue.Name);
        exit('');
    end;
}