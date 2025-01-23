codeunit 50501 "Item Cost Update Handler"
{
    procedure GetItemCosts(unitCost: Decimal; ItemNo: Code[20]; var LatestCost: Decimal; var PreviousCost: Decimal; var CostVariation: Decimal)
    var
        ValueEntry: Record "Value Entry";
        Count: Integer;
    begin
        LatestCost := unitCost;
        PreviousCost := unitCost;
        CostVariation := 0;
        Count := 0;

        ValueEntry.SetRange("Item No.", ItemNo);
        ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Purchase);
        ValueEntry.SetRange("Document Type", ValueEntry."Document Type"::"Purchase Receipt");
        ValueEntry.SetAscending("Entry No.", false);

        if ValueEntry.FindSet() then begin
            repeat
                if Count = 0 then
                    LatestCost := ValueEntry."Cost per Unit"
                else if Count = 1 then begin
                    PreviousCost := ValueEntry."Cost per Unit";
                    break;
                end;
                Count += 1;
            until ValueEntry.Next() = 0;
        end;

        CostVariation := LatestCost - PreviousCost;
    end;
}
