report 50502 "Expiring Items Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ItemLotExpiration/ItemLotExpiration.rdl';
    ApplicationArea = All;
    Caption = 'Item Expiry Details';
    UsageCategory = ReportsAndAnalysis;
    DataAccessIntent = ReadOnly;


    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            DataItemTableView = WHERE(Open = FILTER(TRUE)); // Filter Open = true
            // DataItemTableView = SORTING("Lot No.");

            column("Item_No"; "Item No.")
            {
                // CaptionML = 'Item No.';
            }

            column("Lot_No"; "Lot No.")
            {
                // Caption = 'Description';
            }

            column("Inventory"; "Remaining Quantity")
            {
                // Caption = 'Expiration Date';
            }
            column("Unit_Of_Measure"; "Unit of Measure Code")
            {
                // Caption = 'Expiration Date';
            }
            column("Expiration_Date"; "Expiration Date")
            {
                // Caption = 'Expiration Date';
            }
            column("Company_Name"; companyInfo.Name)
            {
                // Caption = 'Expiration Date';
            }
            column("Company_picture"; companyInfo."Picture")
            {
                // Caption = 'Expiration Date';
            }
            column("Report_Name"; ReportName)
            {
                // Caption = 'Expiration Date';
            }
            trigger OnPreDataItem()
            begin
                // Apply the Expiration Date filter if provided
                if ExpirationDateFilter <> 0D then begin
                    SetRange("Expiration Date", ExpirationDateFilter);
                end
                else begin
                    SixMonthsLater := WorkDate + 6 * 30;
                    SetRange("Expiration Date", WorkDate, SixMonthsLater);
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
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
            area(processing)
            {
                action("Preview Report")
                {
                    ApplicationArea = All;
                    Caption = 'Preview Report';
                    ToolTip = 'Preview the report to view expiring items.';
                }
            }
        }
    }
    labels
    {
        Label1 = 'Items Expiration Details Report';
    }
    trigger OnPreReport()
    begin
        companyInfo.Get;
        companyInfo.CalcFields(Picture)
    end;

    var
        ExpirationDateFilter: Date;
        SixMonthsLater: Date;
        companyInfo: Record "Company Information";
        ReportName: Label 'Items Expiration Details';
}
