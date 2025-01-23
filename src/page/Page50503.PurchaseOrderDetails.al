page 50503 PurchaseOrderDetails
{
    APIGroup = 'apiGroup';
    APIPublisher = 'BCAchulien';
    APIVersion = 'v2.0', 'v1.0';
    ApplicationArea = All;
    Caption = 'PurchaseOrderDetailsAPI';
    DelayedInsert = true;
    EntityName = 'PurchaseOrderList';
    EntitySetName = 'PurchaseOrderList';
    PageType = API;
    SourceTable = "Purchase Header";
    InsertAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(No; Rec."No.")
                {
                    Caption = 'No.';
                }
                field("Document_Date"; Rec."Document Date")
                {
                    Caption = 'Document Date.';
                }
                field("Vendor_No"; Rec."Buy-from Vendor No.")
                {
                    Caption = 'Vendor No.';
                }
                field("Vendor_Name"; Rec."Buy-from Vendor Name")
                {
                    Caption = 'Vendor Name.';
                }
                field("Vendor_Shipment_No"; Rec."Vendor Shipment No.")
                {
                    Caption = 'Vendor Shipment No.';
                }
                field("Modified"; Rec.SystemModifiedAt)
                {
                    Caption = 'Modified.';
                }
            }
        }
    }
}