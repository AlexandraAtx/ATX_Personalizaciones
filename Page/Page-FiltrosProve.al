page 50122 "Fecha Request Page Proveedor"
{
    PageType = StandardDialog;
    Caption = 'Generar Registros Mov. Proveedor';
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

            group(FiltrosMovProveedor)
            {
                Caption = 'Filtro: Mov. Proveedor';

                field(FilterVendorNo; FilterVendorNo)
                {
                    ApplicationArea = All;
                    Caption = 'No. Proveedor';
                    ToolTip = 'Filtrar por número de proveedor';
                    TableRelation = Vendor."No.";

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Vendor: Record Vendor;
                        VendorList: Page "Vendor List";
                    begin
                        Vendor.Reset();
                        if FilterVendorNo <> '' then
                            if Vendor.Get(FilterVendorNo) then;

                        VendorList.SetTableView(Vendor);
                        VendorList.SetRecord(Vendor);
                        VendorList.LookupMode := true;

                        if VendorList.RunModal() = Action::LookupOK then begin
                            VendorList.GetRecord(Vendor);
                            Text := Vendor."No.";
                            FilterVendorNo := Vendor."No.";
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
        FilterVendorNo: Code[20];
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
        MovimientosMgt: Codeunit "Movimientos Proveedor Mgt";
        VendorFilter: Text;
    begin
        if CloseAction = Action::OK then begin
            if FechaInicio = 0D then
                Error('Debe especificar la fecha inicial.');

            if FechaFin = 0D then
                Error('Debe especificar la fecha final.');

            if FechaInicio > FechaFin then
                Error('La fecha inicial no puede ser mayor a la fecha final.');

            VendorFilter := '';
            if FilterVendorNo <> '' then
                VendorFilter := FilterVendorNo;

            MovimientosMgt.GenerarMovimientos(FechaInicio, FechaFin, VendorFilter, FilterDocumentType);
            Message('Movimientos generados correctamente.');
        end;
    end;

    procedure SetFechas(FechaIni: Date; FechaFinal: Date)
    begin
        FechaInicio := FechaIni;
        FechaFin := FechaFinal;
    end;

    procedure SetFiltros(VendorNo: Code[20]; DocumentType: Text[50]; PostingDate: Date)
    begin
        FilterVendorNo := VendorNo;
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