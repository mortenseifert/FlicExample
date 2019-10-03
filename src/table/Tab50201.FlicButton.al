table 50201 "Flic Button"
{
    Caption = 'Flic Button';
    LookupPageId = "Flic Button List";

    fields
    {
        field(1; "Id"; Guid)
        {
            Caption = 'Id';
            Editable = false;
        }
        field(2; "Button Id"; Text[32])
        {
            Caption = 'Button Id';
            Editable = false;
        }
        field(3; "Description"; Text[100])
        {
            Caption = 'Description';
        }
        field(4; "Created At"; DateTime)
        {
            Caption = 'Created At';
        }
        field(5; "Last Used At"; DateTime)
        {
            Caption = 'Last Used At';
        }
    }

    keys
    {
        key(PK; "Id")
        {
            Clustered = true;
        }
        key(ButtonId; "Button Id")
        {
            Unique = true;
        }
    }

    trigger OnDelete()
    var
        FlicEntry: Record "Flic Entry";
    begin
        FlicEntry.SetRange("Flic Id", Id);
        FlicEntry.DeleteAll(true);
    end;
}