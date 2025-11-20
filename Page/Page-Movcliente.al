page 50119 "Movimientos Cliente List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Movimientos Cliente Buffer";
    Caption = 'Movimientos Cliente Liq.';
    Editable = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Editable = false;
                field("Tipo Movimiento"; Rec."Tipo Movimiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el tipo de movimiento';
                    StyleExpr = StyleText;
                }
                field("Documento Origen"; Rec."Documento Origen")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el documento origen';
                    StyleExpr = StyleText;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica la fecha de registro';
                    StyleExpr = StyleText;
                }
                field("Fecha Liquidacion"; Rec."Fecha Liquidacion")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha Liquidación';
                    ToolTip = 'Especifica la fecha en que se realizó la liquidación';
                    StyleExpr = StyleText;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha Vencimiento';
                    ToolTip = 'Especifica la fecha de vencimiento del documento';
                    StyleExpr = StyleText;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el tipo de documento';
                    StyleExpr = StyleText;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el número de documento';
                    StyleExpr = StyleText;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el número de documento externo';
                    StyleExpr = StyleText;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el código de moneda';
                    StyleExpr = StyleText;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el importe';
                    StyleExpr = StyleText;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el importe en moneda local';
                    StyleExpr = StyleText;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el importe pendiente';
                    StyleExpr = StyleText;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el método de pago';
                    StyleExpr = StyleText;
                }
                field("Form to Pay"; Rec."Form to Pay")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica la forma de pago';
                    StyleExpr = StyleText;
                }
                field("Tipo Cambio"; Rec."Tipo Cambio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el tipo de cambio';
                    StyleExpr = StyleText;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el número de cliente';
                    StyleExpr = StyleText;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el nombre del cliente';
                    StyleExpr = StyleText;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica la descripción';
                    StyleExpr = StyleText;
                }
                field(UUID; Rec.UUID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el UUID';
                    StyleExpr = StyleText;
                }
                field("Date/Time Stamped"; Rec."Date/Time Stamped")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica la fecha/hora de timbre';
                    StyleExpr = StyleText;
                }
                field("Electronic Status"; Rec."Electronic Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el estatus electrónico';
                    StyleExpr = StyleText;
                }
                field("Estatus Cancelacion"; Rec."Estatus Cancelacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el estatus de cancelación';
                    StyleExpr = StyleText;
                }
                field("Tipo Relacion"; Rec."Tipo Relacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el tipo de relación';
                    StyleExpr = StyleText;
                }
                field("UUID Relacionado"; Rec."UUID Relacionado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el UUID relacionado';
                    StyleExpr = StyleText;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el usuario';
                    StyleExpr = StyleText;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el código origen';
                    StyleExpr = StyleText;
                    Visible = false;
                }
                field("Fecha Creacion"; Rec."Fecha Creacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica la fecha de creación del registro';
                    StyleExpr = StyleText;
                }
                field("Dimension 1 Value"; Rec."Dimension 1 Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el valor de dimensión 1';
                    StyleExpr = StyleText;
                    Visible = ShowDimension1;
                    CaptionClass = '1,2,1';
                }
                field("Dimension 2 Value"; Rec."Dimension 2 Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el valor de dimensión 2';
                    StyleExpr = StyleText;
                    Visible = ShowDimension2;
                    CaptionClass = '1,2,2';
                }
                field("Dimension 3 Value"; Rec."Dimension 3 Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el valor de dimensión 3';
                    StyleExpr = StyleText;
                    Visible = ShowDimension3;
                    CaptionClass = '1,2,3';
                }
                field("Dimension 4 Value"; Rec."Dimension 4 Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el valor de dimensión 4';
                    StyleExpr = StyleText;
                    Visible = ShowDimension4;
                    CaptionClass = '1,2,4';
                }
                field("Dimension 5 Value"; Rec."Dimension 5 Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el valor de dimensión 5';
                    StyleExpr = StyleText;
                    Visible = ShowDimension5;
                    CaptionClass = '1,2,5';
                }
                field("Dimension 6 Value"; Rec."Dimension 6 Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el valor de dimensión 6';
                    StyleExpr = StyleText;
                    Visible = ShowDimension6;
                    CaptionClass = '1,2,6';
                }
                field("Dimension 7 Value"; Rec."Dimension 7 Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el valor de dimensión 7';
                    StyleExpr = StyleText;
                    Visible = ShowDimension7;
                    CaptionClass = '1,2,7';
                }
                field("Dimension 8 Value"; Rec."Dimension 8 Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el valor de dimensión 8';
                    StyleExpr = StyleText;
                    Visible = ShowDimension8;
                    CaptionClass = '1,2,8';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(CustomerLedgerEntries)
            {
                ApplicationArea = All;
                Caption = 'Movimientos Cliente';
                Image = CustomerLedger;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Abre la página de movimientos de cliente filtrada por el documento actual';
                RunObject = Page "Customer Ledger Entries";
                RunPageLink = "Document No." = field("Document No.");
            }
        }
        area(Processing)
        {
            action(GenerarMovimientos)
            {
                ApplicationArea = All;
                Caption = 'Generar Movimientos';
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Genera los movimientos de cliente en la tabla';

                trigger OnAction()
                begin
                    Page.RunModal(50121);
                    CurrPage.Update(false);
                end;
            }
        }
    }

    var
        StyleText: Text;
        ShowDimension1: Boolean;
        ShowDimension2: Boolean;
        ShowDimension3: Boolean;
        ShowDimension4: Boolean;
        ShowDimension5: Boolean;
        ShowDimension6: Boolean;
        ShowDimension7: Boolean;
        ShowDimension8: Boolean;

    trigger OnOpenPage()
    begin
        InitializeDimensionVisibility();
    end;

    trigger OnAfterGetRecord()
    begin
        StyleText := Rec.Style;
    end;

    local procedure InitializeDimensionVisibility()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        if not GLSetup.Get() then
            exit;

        ShowDimension1 := GLSetup."Global Dimension 1 Code" <> '';
        ShowDimension2 := GLSetup."Global Dimension 2 Code" <> '';
        ShowDimension3 := GLSetup."Shortcut Dimension 3 Code" <> '';
        ShowDimension4 := GLSetup."Shortcut Dimension 4 Code" <> '';
        ShowDimension5 := GLSetup."Shortcut Dimension 5 Code" <> '';
        ShowDimension6 := GLSetup."Shortcut Dimension 6 Code" <> '';
        ShowDimension7 := GLSetup."Shortcut Dimension 7 Code" <> '';
        ShowDimension8 := GLSetup."Shortcut Dimension 8 Code" <> '';
    end;
}