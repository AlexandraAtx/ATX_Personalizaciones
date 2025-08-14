report 50110 "Balanza Comprobacion"
{
    // version E-CONT2.00

    DefaultLayout = RDLC;
    Caption = 'Balanza Comprobacion';
    RDLCLayout = './Balanza Comprobacion CE.rdl';

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            //DataItemTableView = WHERE("SAT Account Code" = FILTER(<> ''));
            RequestFilterFields = "No.", "Date Filter";
            column(No; "G/L Account"."No.")
            {
            }
            column(Name_; "G/L Account".Name)
            {
            }
            column(SaldoIni_; SaldoIni)
            {
            }
            column(Debe_; SaldoDeb)
            {
            }
            column(Haber_; SaldoHab)
            {
            }
            column(SaldoFin_; SaldoFin)
            {
            }
            column(TotIni; TotIni)
            {
            }
            column(TotFin; TotFin)
            {
            }
            column(TotDeb; TotDeb)
            {
            }
            column(TotHab; TotHab)
            {
            }
            column(TextTitulo; TextTitulo)
            {
            }
            column(CompanyInformationPicture; CompanyInformation.Picture)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(Filters; Filters)
            {
            }

            trigger OnAfterGetRecord()
            begin

                SaldoIni := 0;
                SaldoFin := 0;
                SaldoDeb := 0;
                SaldoHab := 0;

                //>>calcula Saldos
                EAccountingMgt.CalcBalanceAmount("G/L Account", PeriodoIni, PeriodoFin, FALSE, Month, SaldoIni, SaldoDeb, SaldoHab, SaldoFin);
            end;

            trigger OnPreDataItem()
            begin
                PeriodoIni := "G/L Account".GETRANGEMIN("Date Filter");
                PeriodoFin := "G/L Account".GETRANGEMAX("Date Filter");

                Month := DATE2DMY(PeriodoIni, 2);

                IF PeriodoIni = 0D THEN
                    ERROR('Se Requiere Fecha Inicial');
                IF PeriodoFin = 0D THEN
                    ERROR('Se Requiere Fecha Final');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    Visible = false;
                    field(CreateXMLBal; CreateXMLBal)
                    {
                        Caption = 'Crear XML Balanza Contable';
                        ApplicationArea = all;
                    }
                    field(TypeBal; TypeBal)
                    {
                        Caption = 'Tipo de Balanza';
                        ApplicationArea = all;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Filters := "G/L Account".GETFILTERS;
        CompanyInformation.GET('');
        //CompanyInformation.
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        SaldoIni: Decimal;
        SaldoFin: Decimal;
        SaldoDeb: Decimal;
        SaldoHab: Decimal;
        PeriodoIni: Date;
        PeriodoFin: Date;
        GLEntry: Record "G/L Entry";
        BLZGLEntry: Record "G/L Entry";
        BLZFINGLEntry: Record "G/L Entry";
        TotIni: Decimal;
        TotFin: Decimal;
        TotDeb: Decimal;
        TotHab: Decimal;
        CreateXMLBal: Boolean;
        TypeBal: Option Normal,Complementaria;
        EAccountingMgt: Codeunit XMLContabilidad;
        IsCorrect: Boolean;
        TextTitulo: Label 'Balanza Comprobacion';
        CompanyInformation: Record "Company Information";
        Filters: Text;
        Month: Integer;
        report: Report 20;
}

