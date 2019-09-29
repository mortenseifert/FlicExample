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
        field(10; "Button Id"; Code[20])
        {
            Caption = 'Button Id';
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
    end;
}