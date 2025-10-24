page 60200 "Translation Prompt Dialog"
{
    Caption = 'Handle Item Translations with Copilot';
    PageType = PromptDialog;
    Extensible = false;
    IsPreview = true;
    PromptMode = Prompt;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            part(ItemTranslationProposal; "Items Transl. AI Proposal Sub")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(SystemActions)
        {
            systemaction(Generate)
            {
                Caption = 'Verify';
                ToolTip = 'Verify Item Translations with Copilot.';

                trigger OnAction()
                begin
                    RunGeneration();
                end;
            }
            systemaction(OK)
            {
                Caption = 'Confirm';
                ToolTip = 'Add selected Items to Substitutions.';
            }
            systemaction(Cancel)
            {
                Caption = 'Discard';
                ToolTip = 'Discard Items proposed by Dynamics 365 Copilot.';
            }
            systemaction(Regenerate)
            {
                Caption = 'Regenerate';
                ToolTip = 'Regenerate Item Substitutions proposal with Dynamics 365 Copilot.';
                trigger OnAction()
                begin
                    RunGeneration();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        CurrPage.Caption := 'Handle Item Translations with Copilot';

        RunGeneration();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = CloseAction::OK then begin
            CurrPage.ItemTranslationProposal.Page.SaveTranslationsForItem(SourceItem);
        end;
    end;

    local procedure RunGeneration()
    var
        Attempts: Integer;
        GenerateItemTranslProposal: Codeunit "Generate Item Transl. Proposal";
        TmpItemTranslationAIProposal: Record "Item Translation AI Proposal";
    begin
        GenerateItemTranslProposal.SetItem(SourceItem);

        TmpItemTranslationAIProposal.Reset();
        TmpItemTranslationAIProposal.DeleteAll();

        // Attempts := 0;
        // while TmpItemTranslationAIProposal.IsEmpty and (Attempts < 5) do begin
        GenerateItemTranslProposal.Run();
        GenerateItemTranslProposal.GetResult(TmpItemTranslationAIProposal);

        //     Attempts += 1;
        // end;

        // if (Attempts < 5) then begin
        Load(TmpItemTranslationAIProposal);
        // end else
        //     Error('Something went wrong or nothing to translate. ' + GetLastErrorText);

    end;

    procedure SetSourceItem(Item2: Record Item)
    begin
        SourceItem := Item2;

        OnAfterSetSourceItem(SourceItem); //Merely here for testing the Escaperoom
    end;

    procedure GetSourceItem(): Record Item
    begin
        exit(SourceItem);
    end;

    procedure Load(var TmpItemTranslationAIProposal: Record "Item Translation AI Proposal")
    begin
        CurrPage.ItemTranslationProposal.page.Load(TmpItemTranslationAIProposal);

        CurrPage.Update(false);
    end;

    var
        SourceItem: Record Item;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetSourceItem(var Item: Record Item) //Merely here for testing the Escaperoom
    begin
    end;
}
