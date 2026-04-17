using { db } from '../db/externalserviceschema';
 

service ExternalSalesService {

    entity s4_SalesOrderItems as projection on db.SalesOrderItem;

    entity SalesOrder as projection on db.salesOrder ;
}

