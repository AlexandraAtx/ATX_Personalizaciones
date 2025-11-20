page 50121 "Fecha Request Page"
{
    PageType = StandardDialog;
    Caption = 'Generar Registros Mov. Cliente';
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(Opciones)
            {
                Caption = 'Opciones';

                field(FechaInicio; FechaInicio)
                {
                    ApplicationArea = All;
                    Caption = 'Fecha Inicial';
                    ToolTip = 'Especifica la fecha inicial del periodo';
                }

                field(FechaFin; FechaFin)
                {
                    ApplicationArea = All;
                    Caption = 'Fecha Final';
                    ToolTip = 'Especifica la fecha final del periodo';
                }
            }

            group(FiltrosMovCliente)
            {
                Caption = 'Filtro: Mov. Cliente';

                field(FilterCustomerNo; FilterCustomerNo)
                {
                    ApplicationArea = All;
                    Caption = 'No. Cliente';
                    ToolTip = 'Filtrar por número de cliente';
                    TableRelation = Customer."No.";

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Customer: Record Customer;
                        CustomerList: Page "Customer List";
                    begin
                        Customer.Reset();
                        if FilterCustomerNo <> '' then
                            if Customer.Get(FilterCustomerNo) then;

                        CustomerList.SetTableView(Customer);
                        CustomerList.SetRecord(Customer);
                        CustomerList.LookupMode := true;

                        if CustomerList.RunModal() = Action::LookupOK then begin
                            CustomerList.GetRecord(Customer);
                            Text := Customer."No.";
                            FilterCustomerNo := Customer."No.";
                            exit(true);
                        end;
                        exit(false);
                    end;
                }

                field(FilterDocumentType; FilterDocumentType)
                {
                    ApplicationArea = All;
                    Caption = 'Tipo Documento';
                    ToolTip = 'Filtrar por tipo de documento';
                }
            }
        }
    }

    var
        FechaInicio: Date;
        FechaFin: Date;
        FilterCustomerNo: Code[20];
        FilterDocumentType: Option " ",Pago,Factura,"Nota de crédito","Documento interés",Recordatorio,Reembolso;

    trigger OnOpenPage()
    begin
        if FechaInicio = 0D then
            FechaInicio := CalcDate('<-1M>', WorkDate());
        if FechaFin = 0D then
            FechaFin := WorkDate();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        MovimientosMgt: Codeunit "Movimientos Cliente Mgt";
        CustomerFilter: Text;
    begin
        if CloseAction = Action::OK then begin
            if FechaInicio = 0D then
                Error('Debe especificar la fecha inicial.');

            if FechaFin = 0D then
                Error('Debe especificar la fecha final.');

            if FechaInicio > FechaFin then
                Error('La fecha inicial no puede ser mayor a la fecha final.');

            CustomerFilter := '';
            if FilterCustomerNo <> '' then
                CustomerFilter := FilterCustomerNo;

            MovimientosMgt.GenerarMovimientos(FechaInicio, FechaFin, CustomerFilter, FilterDocumentType);
            Message('Movimientos generados correctamente.');
        end;
    end;

    procedure SetFechas(FechaIni: Date; FechaFinal: Date)
    begin
        FechaInicio := FechaIni;
        FechaFin := FechaFinal;
    end;

    procedure SetFiltros(CustomerNo: Code[20]; DocumentType: Text[50]; PostingDate: Date)
    begin
        FilterCustomerNo := CustomerNo;
        Evaluate(FilterDocumentType, DocumentType);
    end;

    procedure GetFechas(var FechaIni: Date; var FechaFinal: Date)
    begin
        FechaIni := FechaInicio;
        FechaFinal := FechaFin;
    end;

    procedure GetDocumentType(): Text
    begin
        exit(Format(FilterDocumentType));
    end;
}