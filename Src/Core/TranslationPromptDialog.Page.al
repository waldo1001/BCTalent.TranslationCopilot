page 60200 "Translation Prompt Dialog"
{
    Caption = 'AI Translation';
    PageType = PromptDialog;
    Extensible = false;
    IsPreview = true;
    PromptMode = Prompt;

    layout
    {
        area(Prompt)
        {
            field(UserPrompt; UserInput)
            {
                ApplicationArea = All;
                Caption = 'Describe what you want to translate';
                ToolTip = 'Enter instructions for the AI translation (e.g., "Translate to German", "Make it more formal").';
                MultiLine = true;

                trigger OnValidate()
                begin
                    // TODO: Attendees can add validation logic here
                end;
            }
        }
        area(Content)
        {
            field(SourceText; SourceText)
            {
                ApplicationArea = All;
                Caption = 'Source Text';
                ToolTip = 'The original text to be translated.';
                MultiLine = true;
                Editable = false;
            }
            field(TranslatedText; TranslatedText)
            {
                ApplicationArea = All;
                Caption = 'AI Translation Result';
                ToolTip = 'The AI-generated translation.';
                MultiLine = true;
                Editable = false;
            }
        }
    }
    actions
    {
        area(SystemActions)
        {
            systemaction(Generate)
            {
                Caption = 'Generate';
                ToolTip = 'Generate AI translation based on your prompt.';

                trigger OnAction()
                begin
                    // TODO: Attendees implement AI translation logic here
                    TranslatedText := 'Translation will appear here...';
                end;
            }
            systemaction(OK)
            {
                Caption = 'Keep it';
                ToolTip = 'Accept this translation and close the dialog.';
            }
            systemaction(Cancel)
            {
                Caption = 'Discard';
                ToolTip = 'Discard this translation and close the dialog.';
            }
            systemaction(Regenerate)
            {
                Caption = 'Regenerate';
                ToolTip = 'Generate a new translation with the same prompt.';
            }
        }
    }
    var
        UserInput: Text;
        SourceText: Text;
        TranslatedText: Text;

    procedure SetSourceText(NewSourceText: Text)
    begin
        SourceText := NewSourceText;
    end;

    procedure GetTranslatedText(): Text
    begin
        exit(TranslatedText);
    end;

    procedure SetDefaultPrompt(DefaultPrompt: Text)
    begin
        UserInput := DefaultPrompt;
    end;
}
