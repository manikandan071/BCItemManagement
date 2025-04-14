codeunit 50501 "Item Cost Update Handler"
{
    procedure GetItemCosts(unitCost: Decimal; ItemNo: Code[20]; var LatestCost: Decimal; var PreviousCost: Decimal; var CostVariation: Decimal)
    var
        ValueEntry: Record "Value Entry";
        itemLedger: Record "Item Ledger Entry";
        totalPurchaseAmount: Decimal;
        Count: Integer;
    begin
        LatestCost := unitCost;
        PreviousCost := unitCost;
        CostVariation := 0;
        Count := 0;

        itemLedger.Reset();
        itemLedger.SetRange("Item No.", ItemNo);
        itemLedger.SetRange("Entry Type", itemLedger."Entry Type"::Purchase);
        itemLedger.SetRange("Document Type", itemLedger."Document Type"::"Purchase Receipt");
        itemLedger.SetCurrentKey("Item No.", "Posting Date");
        itemLedger.Ascending(false); // Get latest records first

        if itemLedger.FindSet() then begin
            repeat
                if itemLedger."Quantity" <> 0 then begin

                    ValueEntry.SetRange("Item Ledger Entry No.", itemLedger."Entry No.");
                    if ValueEntry.FindSet() then begin
                        repeat
                            totalPurchaseAmount += ValueEntry."Cost Amount (Actual)"
                        until ValueEntry.Next() = 0;
                    end;
                    unitCost := totalPurchaseAmount / itemLedger."Quantity";

                    if Count = 0 then begin

                        LatestCost := unitCost;
                        totalPurchaseAmount := 0;
                    end
                    else if Count = 1 then begin
                        PreviousCost := unitCost;
                        totalPurchaseAmount := 0;
                        break;
                    end;
                    Count += 1;
                end;
            until itemLedger.Next() = 0;
        end;


        // ValueEntry.SetRange("Item No.", ItemNo);
        // ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Purchase);
        // ValueEntry.SetRange("Document Type", ValueEntry."Document Type"::"Purchase Receipt");
        // ValueEntry.SetAscending("Entry No.", false);

        // if ValueEntry.FindSet() then begin
        //     repeat
        //         if Count = 0 then
        //             LatestCost := ValueEntry."Cost per Unit"
        //         else if Count = 1 then begin
        //             PreviousCost := ValueEntry."Cost per Unit";
        //             break;
        //         end;
        //         Count += 1;
        //     until ValueEntry.Next() = 0;
        // end;

        CostVariation := LatestCost - PreviousCost;
    end;
}
