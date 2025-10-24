pageextension 60201 "Item List Ext WLD" extends "Item List"
{
    actions
    {
        // This is how you add it to the "Copilot" promoted actions
        addfirst(Prompting)
        {
            action(TranslateWithCopilot)
            {
                Caption = 'Translate with Copilot';
                ToolTip = 'Use AI to translate item descriptions and names.';
                Image = Sparkle;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //TODO: Make sure to call the "SetSourceItem" on the page, to set the right Item before you modally open the item
                end;
            }
        }
    }
}
