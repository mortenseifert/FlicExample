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
    begin
        Randomize();
        if Random(10) = 10 then
            Error('Random error raised for action %1.', FlicEntry."Flic Action");
    end;
}