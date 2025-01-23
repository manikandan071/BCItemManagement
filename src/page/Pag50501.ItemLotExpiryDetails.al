page 50501 ItemLotExpiryDetails
{
    APIGroup = 'apiGroup';
    APIPublisher = 'BCAchulien';
    APIVersion = 'v2.0', 'v1.0';
    ApplicationArea = All;
    Caption = 'ItemLotExpiryDetailsAPI';
    DelayedInsert = true;
    EntityName = 'ItemLedgerEntry';
    EntitySetName = 'ItemLedgerEntries';
    PageType = API;
    SourceTable = "Item Ledger Entry";
    InsertAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Lot_No"; Rec."Lot No.")
                {
                    Caption = 'OrderID';
                }
                field("Item_no"; Rec."Item No.")
                {
                    Caption = 'Location';
                }
                field(description; Description)
                {
                    Caption = 'Description';
                }
                field("Expiration_Date"; Rec."Expiration Date")
                {
                    Caption = 'Date';
                }
                field("Unit_Of_Measure"; Rec."Unit of Measure Code")
                {
                    Caption = 'Date';
                }
                field("Inventory"; Rec."Remaining Quantity")
                {
                    Caption = 'ContainerNumber';
                }
                field("Open"; Rec."Open")
                {
                    Caption = 'ContainerNumber';
                }
                field("PostingDate"; Rec."Posting Date")
                {
                    Caption = 'ContainerNumber';
                }
                field("EntryType"; Rec."Entry Type")
                {
                    Caption = 'ContainerNumber';
                }
                field("Unit_Cost"; UnitCost)
                {
                    Caption = 'Unit Cost';
                    ApplicationArea = All;
                }
                field("Unit_Price"; UnitPrice)
                {
                    Caption = 'Unit Cost';
                    ApplicationArea = All;
                }
                field("Sales_Amount"; Rec."Sales Amount (Actual)")
                {
                    Caption = 'Unit Cost';
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        Item: Record Item;
    begin
        if Item.Get(Rec."Item No.") then begin
            UnitCost := Item."Unit Cost";
            UnitPrice := Item."Unit Price";
            Description := Item.Description;
        end
        else
            UnitCost := 0; // Default value if item is not found
    end;

    var
        UnitCost: Decimal;
        UnitPrice: Decimal;
        Description: text;
}