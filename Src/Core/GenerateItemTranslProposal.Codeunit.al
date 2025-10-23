codeunit 60201 "Generate Item Transl. Proposal"
{
    var
        Item: Record Item;
        TmpItemTranslationAIProposal: Record "Item Translation AI Proposal" temporary;

    trigger OnRun()
    begin
        GenerateProposal;
    end;

    procedure SetItem(var pItem: Record Item)
    begin
        Item := pItem;
        Item.CopyFilters(pItem);
    end;

    procedure GetResult(var TmpItemTranslationAIProposal2: Record "Item Translation AI Proposal" temporary)
    begin
        TmpItemTranslationAIProposal2.Copy(TmpItemTranslationAIProposal, true);
    end;

    local procedure GenerateProposal()
    var
    //TODO: add CopilotTranslationLanguage record that you created
    begin
        //TODO: For each language in CopilotTranslationLanguage, there needs to be a record in the Item Translation.  Use "AddTranslationProposalIfNecessary" to make it easy on you.
        //Example:
        // CopilotTranslationLanguage.SetRange(Enabled, true);
        // if CopilotTranslationLanguage.FindSet() then
        //     repeat
        //         AddTranslationProposalIfNecessary(CopilotTranslationLanguage.Code);
        //     until CopilotTranslationLanguage.Next() = 0;
    end;

    local procedure AddTranslationProposalIfNecessary(TargetLanguageCode: Code[10])
    var
        ItemTranslation: Record "Item Translation";
        FullLanguageName: Text;
    begin
        if ItemTranslation.Get(Item."No.", TargetLanguageCode) then
            exit;

        FullLanguageName := GetFullLanguageName(TargetLanguageCode);

        TmpItemTranslationAIProposal.SetRange("No.", Item."No.");
        TmpItemTranslationAIProposal.SetRange("Target Language", FullLanguageName);
        if not TmpItemTranslationAIProposal.IsEmpty() then exit;

        TmpItemTranslationAIProposal.PrimaryKey := CreateGuid();
        TmpItemTranslationAIProposal."No." := Item."No.";
        TmpItemTranslationAIProposal."Original Description" := Item.Description;
        TmpItemTranslationAIProposal."Target Language" := FullLanguageName;
        TmpItemTranslationAIProposal."Translated Description" := GetTranslationFromCopilot(Item.Description, FullLanguageName);
        TmpItemTranslationAIProposal.Insert();
    end;

    local procedure GetFullLanguageName(LanguageCode: code[10]): Text
    var
        language: record Language;
    begin
        Language.SetAutoCalcFields("Windows Language Name");
        language.Get(LanguageCode);
        // exit(language."Windows Language Name".Split(' ').get(1))
        exit(language."Windows Language Name");
    end;

    procedure GetTranslationFromCopilot(TextToTranslate: Text; TargetLanguage: Text) Result: Text
    var
        ItemTranslationCopilotImpl: Codeunit "Item Translation Copilot Impl.";
        AzureOpenAI: Codeunit "Azure OpenAI";
        AOAIDeployments: Codeunit "AOAI Deployments";
        AOAIOperationResponse: Codeunit "AOAI Operation Response";
        AOAIChatCompletionParams: Codeunit "AOAI Chat Completion Params";
        AOAIChatMessages: Codeunit "AOAI Chat Messages";
    begin
        //TODO: Check if capability is enabled. Use "Item Translation Copilot Impl."

        //TODO: Check if there is a setup. Use "Item Translation Copilot Impl."

        //TODO: Set the Copilot Capability to "Item Translations"

        //TODO: Set authorization (Managed Resource), use "Item Translation Copilot Impl." for account name and API key, and use AOAIDeployments to get the latest GPT-4.1 Mini deployment


        AOAIChatCompletionParams.SetTemperature(0.3); // Balanced creativity for clear instructions
        AOAIChatCompletionParams.SetMaxTokens(2000); // Sufficient for detailed instructions

        //TODO: Create system and user prompts, use "Item Translation Copilot Impl." to get both, and set them up in AOAIChatMessages


        //This will perform the call to Azure OpenAI
        AzureOpenAI.GenerateChatCompletion(AOAIChatMessages, AOAIChatCompletionParams, AOAIOperationResponse);

        if AOAIOperationResponse.IsSuccess() then
            Result := AOAIChatMessages.GetLastMessage()
        else
            Error(AOAIOperationResponse.GetError());

        exit(Result);
    end;
}