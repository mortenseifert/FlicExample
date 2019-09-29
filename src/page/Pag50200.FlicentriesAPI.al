page 50200 "Flic Entries API"
{
    // URL to access the API
    // Use BaseAuthentication (remember to create API Key for user)
    // https://api.businesscentral.dynamics.com/v2.0/notora.dk/Production/api/MortenSeifert/flic/v1.0/companies({{companyID}})/flicEntries
    PageType = API;
    Caption = 'flicEntry';
    APIPublisher = 'MortenSeifert';
    APIVersion = 'beta', 'v1.0', 'v2.0';
    APIGroup = 'flic';
    EntityName = 'flicEntry';
    EntitySetName = 'flicEntries';
    SourceTable = "Flic Entry";
    DelayedInsert = true;
    ODataKeyFields = Id;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Id)
                {
                    Caption = 'Id';
                    ApplicationArea = All;
                }
                field("buttonId"; "Button Id")
                {
                    Caption = 'ButtonId';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Insert(true);       // Force insert trigger to be run

        Modify(true);
        exit(false);
    end;
}