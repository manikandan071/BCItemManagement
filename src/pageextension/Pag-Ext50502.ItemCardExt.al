pageextension 50502 "Item Card Ext" extends "Item Card"
{
    layout
    {

        addafter("Unit Cost")
        {
            field("Latest Cost"; LatestCost)
            {
                ApplicationArea = All;
                Caption = 'Recent Cost';
                Editable = false;
                ToolTip = 'Cost of the item from the latest recorded transaction.';
            }
            field("Previous Cost"; PreviousCost)
            {
                ApplicationArea = All;
                Caption = 'Previous Cost';
                Editable = false;
                ToolTip = 'Cost of the item from the transaction preceding the latest one.';
            }
            field("Cost Variation"; CostVariation)
            {
                ApplicationArea = All;
                Caption = 'Cost difference';
                Editable = false;
                ToolTip = 'Difference between the Recent Cost and the Previous Cost.';
            }
        }
    }
    // trigger OnOpenPage()
    // var
    //     ItemHandler: Codeunit "Item Cost Update Handler";
    // begin
    //     // Call the codeunit to process and show data
    //     ItemHandler.ProcessItem(Rec);
    // end;
    trigger OnAfterGetRecord()
    var
        CostHandler: Codeunit "Item Cost Update Handler";
    begin
        CostHandler.GetItemCosts(Rec."Unit Cost", Rec."No.", LatestCost, PreviousCost, CostVariation);
    end;

    var
        LatestCost: Decimal;
        PreviousCost: Decimal;
        CostVariation: Decimal;
}