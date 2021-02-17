// page 50013 "Item Availability By Color"
// {
//     PageType = Card;
//     ApplicationArea = All;
//     UsageCategory = Administration;
//     SourceTable = "Item Color";
//     DataCaptionFields = "Item No.", "Color Description";

//     layout
//     {
//         area(Content)
//         {
//             group(GroupName)
//             {
//                 field("Item No."; "Item No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Item Description"; Item.Description)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Color Description"; "Color Description")
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(Processing)
//         {
//             action(ActionName)
//             {
//                 ApplicationArea = All;

//                 trigger OnAction()
//                 begin

//                 end;
//             }
//         }
//     }

//     var
//         Item: Record Item;
// }