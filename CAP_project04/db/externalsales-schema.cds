using { API_SALES_ORDER_SRV as s4} from '../srv/external/API_SALES_ORDER_SRV';

namespace db;

entity salesOrder {
      key SalesOrder : String;
        SalesOrderType : String;
        SoldToParty : String;
        SalesOrderDate : Date;
        TotalNetAmount : Decimal(16,3);
        OverallDeliveryStatus : String;
}

@cds.persistence.table
entity SalesOrderItem as projection on s4.A_SalesOrderItem{
         key SalesOrder,
        key SalesOrderItem,
        SalesOrderItemCategory,
        PurchaseOrderByCustomer,
        RequestedQuantity,
        NetAmount,
        TaxAmount
    }


// @cds.persistence.table
//     entity SalesOrder as projection on s4.A_SalesOrder {
//         key SalesOrder,
//         SalesOrderType,
//         SoldToParty,
//         SalesOrderDate,
//         TotalNetAmount,
//         OverallDeliveryStatus,

//         orderItems : Association to many SalesOrderItem on orderItems.SalesOrder = $self.SalesOrder
//     }

  