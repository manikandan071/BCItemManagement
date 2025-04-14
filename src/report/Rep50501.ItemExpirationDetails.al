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

            // trigger OnPreDataItem()
            // begin
            //     // Apply the Expiration Date filter if provided
            //     if ExpirationDateFilter <> 0D then begin
            //         SetRange("Expiration Date", ExpirationDateFilter);
            //     end
            //     else begin
            //         // SixMonthsLater := WorkDate + 6 * 30;
            //         // SetRange("Expiration Date", WorkDate, SixMonthsLater);
            //     end;
            // end;
            trigger OnPreDataItem()
            begin
                if (StartDate <> 0D) and (EndDate <> 0D) then
                    SetRange("Expiration Date", StartDate, EndDate)
                else
                    Clear("Expiration Date"); // No filter if both dates are blank
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
                    field("Expiration From Date"; startDate)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Enter the date range for which you want to view expiring items.';
                    }
                    field("Expiration To Date"; endDate)
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
    trigger OnInitReport()
    begin
        StartDate := WorkDate;
        EndDate := CalcDate('<6M>', WorkDate); // 6 months ahead
    end;

    var
        startDate: Date;
        endDate: Date;
        SixMonthsLater: Date;
        ReportName: Label 'Items Expiration Details';
}
