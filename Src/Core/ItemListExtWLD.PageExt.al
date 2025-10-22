pageextension 60201 "Item List Ext WLD" extends "Item List"
{
    actions
    {
        addfirst(processing)
        {
            action(TranslateWithCopilot)
            {
                Caption = 'Translate with Copilot';
                ToolTip = 'Use AI to translate item descriptions and names.';
                Image = Sparkle;
                ApplicationArea = All;

                trigger OnAction()
                begin
                end;
            }
        }
    }
}
