pageextension 50501 "Item List Report Extension" extends "Item List"
{
    actions
    {
        addbefore(Reports)
        {
            group(General)
            {
                Caption = 'Items Expiration Details';
                Image = Report;
                action("CustomItemReport")
                {
                    Caption = 'Items Expiration - Lot';
                    Image = Report;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReportID: Integer;
                        ItemLedgerEntry: Record "Item Ledger Entry";
                    begin
                        ReportID := 50501;
                        Report.Run(ReportID, true, true, ItemLedgerEntry);
                    end;
                }
            }
        }
    }
}
