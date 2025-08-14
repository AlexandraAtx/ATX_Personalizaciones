pageextension 50110 "Chart of Accounts" extends "Chart of Accounts"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addbefore("&Balance")
        {
            action("Balanza Comprobacion CE")
            {
                CaptionML = ESM = 'Balanza Comprobacion';
                Image = Action;
                ApplicationArea = All;

                trigger OnAction()
                var
                    BalanzaCrompobacion: Report "Balanza Comprobacion";
                begin
                    Clear(BalanzaCrompobacion);
                    BalanzaCrompobacion.RunModal();
                end;
            }
        }
    }

    var
        myInt: Integer;
}