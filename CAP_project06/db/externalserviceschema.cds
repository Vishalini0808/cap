using { API_SALES_ORDER_SRV as s4 } from '../srv/external/API_SALES_ORDER_SRV';

namespace db;

entity salesOrder {
    key SalesOrder : String;
    SalesOrderType : String;
    SoldToParty : String;
    SalesOrderDate : Date;
    TotalNetAmount : Decimal(16,3);
    OverallDeliveryStatus : String;

    orderItems : association to SalesOrderItem on orderItems.SalesOrder = $self.SalesOrder;
    }

@cds.persistence.table
 entity SalesOrderItem as projection on s4.A_SalesOrderItem {
        key SalesOrder,
        key SalesOrderItem,
        SalesOrderItemCategory,
        PurchaseOrderByCustomer,
        RequestedQuantity,
        NetAmount,
        TaxAmount
    } 

// entity salesOrderItemRel {
//     key id : UUID;
//     // note : String;
//     orderItem : Association to s4.A_SalesOrderItem on orderItem.SalesOrder = $self.SalesOrder;
//     SalesOrder : String;
// }