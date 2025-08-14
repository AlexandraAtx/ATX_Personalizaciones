pageextension 50113 "Chart of Accounts Extension" extends "Chart of Accounts"
{
    actions
    {
        modify("G/L Register")
        {
            Visible = false;
        }

        addbefore("G/L Register")
        {
            action(CustomGLRegister)
            {
                Caption = 'Registros movs. contabilidad';
                Image = GLRegisters;
                ApplicationArea = All;

                trigger OnAction()
                var
                    GLEntry: Record "G/L Entry";
                    GLRegisterReport: Report "GLRegister";
                begin
                    GLEntry.Reset();
                    GLEntry.SetRange("G/L Account No.", Rec."No.");
                    GLRegisterReport.SetTableView(GLEntry);
                    GLRegisterReport.RunModal();
                end;
            }
        }
    }
}