table 50112 "Movimientos Proveedor Liq"
{
    Caption = 'Movimientos Proveedor Liq.';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Tipo Movimiento"; Option)
        {
            Caption = 'Tipo Movimiento';
            OptionCaption = 'Mov. Inicial,Liquidación';
            OptionMembers = "Mov. Inicial","Liquidación";
            DataClassification = CustomerContent;
        }
        field(3; "Documento Origen"; Code[20])
        {
            Caption = 'Documento Origen';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Fecha Registro';
        }
        field(5; "Document Type"; Option)
        {
            Caption = 'Tipo documento';
            OptionCaption = ' ,Pago,Factura,Nota de crédito,Docs. interés,Recordatorio,Reembolso';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
            DataClassification = CustomerContent;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'No. documento';
        }
        field(7; "External Document No."; Code[35])
        {
            Caption = 'No. Doc Externo';
        }
        field(8; "Amount"; Decimal)
        {
            Caption = 'Importe';
        }
        field(9; "Amount (LCY)"; Decimal)
        {
            Caption = 'Importe ($)';
        }
        field(10; "Currency Code"; Code[10])
        {
            Caption = 'Cod. Divisa';
        }
        field(11; "Payment Method Code"; Code[10])
        {
            Caption = 'Forma pago';
        }
        field(12; "Form to Pay"; Code[10])
        {
            Caption = 'Metodo pago';
        }
        field(13; "Vendor No."; Code[20])
        {
            Caption = 'No. proveedor';
            TableRelation = Vendor;
        }
        field(14; "Vendor Name"; Text[100])
        {
            Caption = 'Nombre proveedor';
        }
        field(15; "Description"; Text[100])
        {
            Caption = 'Descripcion';
        }
        field(16; "UUID"; Text[50])
        {
            Caption = 'UUID';
        }
        field(17; "Date/Time Stamped"; Text[50])
        {
            Caption = 'Fecha y hora de firma';
        }
        field(18; "Electronic Status"; Text[50])
        {
            Caption = 'Estatus';
        }
        field(19; "User ID"; Code[50])
        {
            Caption = 'Usuario';
        }
        field(20; "Tipo Cambio"; Text[50])
        {
            Caption = 'Tipo Cambio';
        }
        field(21; "Estatus Cancelacion"; Text[50])
        {
            Caption = 'Estatus Cancelacion';
        }
        field(22; "Tipo Relacion"; Text[50])
        {
            Caption = 'Tipo Relacion';
        }
        field(23; "UUID Relacionado"; Text[250])
        {
            Caption = 'UUID Relacionado';
        }
        field(24; "Dimension 1 Value"; Text[100])
        {
        }
        field(25; "Dimension 2 Value"; Text[100])
        {
        }
        field(26; "Dimension 3 Value"; Text[100])
        {
        }
        field(27; "Dimension 4 Value"; Text[100])
        {
        }
        field(28; "Dimension 5 Value"; Text[100])
        {
        }
        field(29; "Dimension 6 Value"; Text[100])
        {
        }
        field(30; "Dimension 7 Value"; Text[100])
        {
        }
        field(31; "Dimension 8 Value"; Text[100])
        {
        }
        field(32; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            TableRelation = "Dimension Set Entry";
        }
        field(33; "Remaining Amount"; Decimal)
        {
            Caption = 'Importe pendiente';
        }
        field(34; "Source Code"; Code[10])
        {
            Caption = 'Cod. Origen';
            TableRelation = "Source Code";
        }
        field(35; "Company Name"; Text[100])
        {
            Caption = 'Company Name';
        }
        field(36; "Fecha Creacion"; Date)
        {
            Caption = 'Fecha Creacion';
        }
        field(37; "Parent Entry No."; Integer)
        {
            Caption = 'Parent Entry No.';
        }
        field(38; Style; Text[30])
        {
            Caption = 'Style';
            DataClassification = SystemMetadata;
        }
        field(39; "Fecha Liquidacion"; Date)
        {
            Caption = 'Fecha Liquidación';
            DataClassification = CustomerContent;
        }
        field(40; "Due Date"; Date)
        {
            Caption = 'Fecha Vencimiento';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Vendor; "Vendor No.", "Posting Date")
        {
        }
        key(Document; "Document No.", "Tipo Movimiento")
        {
        }
    }
}