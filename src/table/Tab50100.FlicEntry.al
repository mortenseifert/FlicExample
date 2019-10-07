table 50200 "Flic Entry"
{
    fields
    {
        field(1; "Id"; Guid)
        {
            Caption = 'Entry No.';
        }
        field(2; "Created at"; DateTime)
        {
            Caption = 'Created at';
        }
        field(3; "State"; Option)
        {
            Caption = 'State';
            OptionMembers = Pending,Processed,Error;
            OptionCaption = 'Pending,Processed,Error';
            InitValue = Pending;
        }
        field(4; "Error Message"; Text[250])
        {
            Caption = 'Error Message';
        }
        field(5; "Processed At"; DateTime)
        {
            Caption = 'Processed At';
        }
        field(10; "Button Id"; Code[32])
        {
            Caption = 'Button Id';
        }
        field(11; "Flic Id"; Guid)
        {
            Caption = 'Flic Id';
            TableRelation = "Flic Button";
        }
        field(12; "Flic Action"; Code[20])
        {
            Caption = 'Flic Action';
        }
    }

    keys
    {
        key(PK; "Id")
        {
            Clustered = true;
        }
        key(CreatedAt; "Created at")
        { }
    }

    trigger OnInsert()
    begin
        Id := CreateGuid();
        "Created at" := CurrentDateTime();
        "Flic Id" := GetFlicId("Button Id");
    end;

    procedure GetFlicId(ButtonId: Text[32]): Guid
    var
        FlicButton: Record "Flic Button";
    begin
        FlicButton.SetRange("Button Id", ButtonId);
        if FlicButton.FindFirst() then begin
            FlicButton."Last Used At" := CurrentDateTime();
            FlicButton.Modify(true);
            exit(FlicButton.Id);
        end;

        FlicButton.Init();
        // 22222222222222222222222222222222
        // '{22222222-2222-2222-2222-222222222222}'
        Evaluate(FlicButton.Id, StrSubstNo('{%1-%2-%3-%4-%5}',
            CopyStr(ButtonId, 1, 8),
            CopyStr(ButtonId, 9, 4),
            CopyStr(ButtonId, 13, 4),
            CopyStr(ButtonId, 17, 4),
            CopyStr(ButtonId, 21, 12)));
        FlicButton."Button Id" := ButtonId;
        FlicButton."Created At" := CurrentDateTime;
        FlicButton."Last Used At" := CurrentDateTime;
        FlicButton.Insert(true);

        Message('done');
    end;

}