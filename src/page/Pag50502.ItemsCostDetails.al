page 50502 ItemsCostDetails
{
    APIGroup = 'apiGroup';
    APIPublisher = 'BCAchulien';
    APIVersion = 'v2.0', 'v1.0';
    ApplicationArea = All;
    Caption = 'ItemsCostDetailsAPI';
    DelayedInsert = true;
    EntityName = 'ItemsCostDetails';
    EntitySetName = 'ItemsCostDetails';
    PageType = API;
    SourceTable = "Value Entry";
    InsertAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item_No"; Rec."Item No.")
                {
                    Caption = 'Item_No';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field("Item_Ledger_Entry_Type"; Rec."Item Ledger Entry Type")
                {
                    Caption = 'Item_Ledger_Entry_Type';
                }
                field("Document_Type"; Rec."Document Type")
                {
                    Caption = 'Document_Type';
                }
                field("Entry_No"; Rec."Entry No.")
                {
                    Caption = 'Entry_No';
                }
                field("Cost_per_Unit"; Rec."Cost per Unit")
                {
                    Caption = 'Cost_per_Unit';
                }
                field("Latest_Cost"; LatestCost)
                {
                    Caption = 'Latest Cost';
                }
                field("Previous_Cost"; PreviousCost)
                {
                    Caption = 'Previous Cost';
                }
                field("Cost_Variation"; CostVariation)
                {
                    Caption = 'Cost Variation';
                }
            }
        }
    }
    var
        LatestCost: Decimal;
        PreviousCost: Decimal;
        CostVariation: Decimal;
        ItemCostHandler: Codeunit "Item Cost Update Handler";

    trigger OnAfterGetRecord()
    begin
        ItemCostHandler.GetItemCosts(Rec."Cost per Unit", Rec."Item No.", LatestCost, PreviousCost, CostVariation);
    end;
}