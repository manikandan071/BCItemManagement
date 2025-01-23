report 50501 "Item Expiration Details"
{
    ApplicationArea = All;
    Caption = 'Item Expiration Details';
    UsageCategory = ReportsAndAnalysis;
    ExcelLayout = 'ItemLotExpiration/Item Expiration Details.xlsx';
    DefaultLayout = Excel;
    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            DataItemTableView = WHERE(Open = FILTER(TRUE));
            column(ItemNo; "Item No.")
            {
            }
            dataitem(Items_Description; "Item")
            {

                DataItemTableView = sorting("No.");
                DataItemLink = "No." = field("Item No.");
                column(Description; "Description")
                {

                }
                column(UnitCost; "Unit Cost")
                {

                }
                column(SalesPrice; "Unit Price")
                {

                }
            }
            column(Inventory; "Remaining Quantity")
            {
            }
            column(UnitofMeasure; "Unit of Measure Code")
            {
            }
            column(LotNo; "Lot No.")
            {
            }
            column(ExpirationDate; "Expiration Date")
            {
            }

            trigger OnPreDataItem()
            begin
                // Apply the Expiration Date filter if provided
                if ExpirationDateFilter <> 0D then begin
                    SetRange("Expiration Date", ExpirationDateFilter);
                end
                else begin
                    // SixMonthsLater := WorkDate + 6 * 30;
                    // SetRange("Expiration Date", WorkDate, SixMonthsLater);
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Group)
                {
                    Caption = 'Filter Options';
                    field("Expiration Date Filter"; ExpirationDateFilter)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Enter the date range for which you want to view expiring items.';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    labels
    {
        Label1 = 'Items Expiration Details Report';
    }

    var
        ExpirationDateFilter: Date;
        SixMonthsLater: Date;
        ReportName: Label 'Items Expiration Details';
}
