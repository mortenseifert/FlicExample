page 50202 "Flic Button List"
{
    PageType = List;
    Caption = 'Flic Buttons';
    CardPageId = "Flic Button Card";
    SourceTable = "Flic Button";
    UsageCategory = Lists;
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
                field("Button Id"; "Button Id")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Created At"; "Created At")
                {
                    ApplicationArea = All;
                }
                field("Last Used At"; "Last Used At")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(Entries)
            {
                Caption = 'Flic Entries';
                ApplicationArea = All;
                Image = Entries;
                RunObject = page "Flic Entries";
                RunPageLink = "Flic Id" = field(Id);
            }
        }
    }
}