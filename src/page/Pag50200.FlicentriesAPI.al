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
                field("action"; "Flic Action")
                {
                    Caption = 'Action';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        JobQueueEntry: Record "Job Queue Entry";
        LblProcessFlic: Label 'Process flic';
    begin
        Insert(true);       // Force insert trigger to be run
        Modify(true);

        JobQueueEntry.Init();
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
        JobQueueEntry."Object ID to Run" := Codeunit::"Flic Process";
        JobQueueEntry."Record ID to Process" := Rec.RecordId;
        JobQueueEntry.Description := LblProcessFlic;
        JobQueueEntry."Earliest Start Date/Time" := CurrentDateTime() + 15000;       // Delay 15 seconds
        JobQueueEntry."Maximum No. of Attempts to Run" := 1;
        Codeunit.Run(Codeunit::"Job Queue - Enqueue", JobQueueEntry);

        exit(false);
    end;
}