page 50201 "Flic Entries"
{
    PageType = List;
    Caption = 'Flic Entries';
    Editable = false;
    SourceTable = "Flic Entry";
    SourceTableView = sorting("Created At");
    UsageCategory = History;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Repeater1)
            {
                field(Id; Id)
                {
                    ApplicationArea = All;
                }
                field("Created at"; "Created at")
                {
                    ApplicationArea = All;
                }
                field("Processed At"; "Processed At")
                {
                    ApplicationArea = All;
                }
                field("Button Id"; "Button Id")
                {
                    ApplicationArea = All;
                }
                field(State; State)
                {
                    ApplicationArea = All;
                }
                field("Error Message"; "Error Message")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}