codeunit 50200 "Flic Process"
{
    TableNo = "Job Queue Entry";

    trigger onRun()
    var
        FlicEntry: Record "Flic Entry";
    begin
        if not FlicEntry.Get("Record ID to Process") then
            exit;
        ClearLastError();
        if Code(FlicEntry) then begin
            FlicEntry."Processed At" := CurrentDateTime();
            FlicEntry.State := FlicEntry.State::Processed;
            FlicEntry.Modify();
        end else begin
            FlicEntry.State := FlicEntry.State::Error;
            FlicEntry."Error Message" := CopyStr(GetLastErrorText, 1, MaxStrLen(FlicEntry."Error Message"));
            FlicEntry.Modify();
        end;
    end;

    [TryFunction]
    local procedure Code(var FlicEntry: Record "Flic Entry")
    var
        FlicButton: Record "Flic Button";
    begin
        Randomize();
        if Random(10) = 10 then
            Error('Random error raised for action %1.', FlicEntry."Flic Action");

        FlicButton.Get(FlicEntry."Flic Id");
        case FlicButton.Description of
            'White':
                PostOutput(1);
            'Black':
                PostOutput(25);
        end;
    end;

    procedure PostOutput(Quantity: Decimal)
    var
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlLine: Record "Item Journal Line";
        ProdOrder: Record "Production Order";
        ProdOrderLine: Record "Prod. Order Line";
    begin
        ProdOrder.SetRange(Status, ProdOrder.Status::Released);
        ProdOrder.SetRange("Source Type", ProdOrder."Source Type"::Item);
        ProdOrder.SetFilter("Source No.", '<>''''');
        ProdOrder.FindLast();
        ProdOrderLine.SetRange(Status, ProdOrder.Status);
        ProdOrderLine.SetRange("Prod. Order No.", ProdOrder."No.");
        ProdOrderLine.FindFirst();
        ItemJnlTemplate.SetRange(Type, ItemJnlTemplate.type::"Prod. Order");
        ItemJnlTemplate.FindFirst();

        ItemJnlLine.Init();
        ItemJnlLine.Validate("Journal Template Name", ItemJnlTemplate.Name);
        ItemJnlLine."Source Type" := ItemJnlLine."Source Type"::Item;
        ItemJnlLine."Source No." := ProdOrder."Source No.";
        ItemJnlLine.Validate("Item No.", ProdOrder."Source No.");
        ItemJnlLine."Order Type" := ItemJnlLine."Order Type"::Production;
        ItemJnlLine."Order No." := ProdOrder."No.";
        ItemJnlLine."Order Line No." := ProdOrderLine."Line No.";
        ItemJnlLine."Document No." := ProdOrder."No.";
        ItemJnlLine.Validate("Posting Date", WorkDate());
        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::Output;
        ItemJnlLine.Validate("Output Quantity", Quantity);

        Codeunit.Run(codeunit::"Item Jnl.-Post Line", ItemJnlLine);
    end;
}