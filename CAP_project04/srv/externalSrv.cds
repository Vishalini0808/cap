using { db } from '../db/externalsales-schema';

service ExternalSalesService {

    entity SalesOrders as projection on db.SalesOrder;
    entity SalesOrderItems as projection on db.SalesOrderItem;

    action replicateProducts();
}

























































// using { API_PRODUCT_SRV as s4} from '../srv/external/API_PRODUCT_SRV';
// using { Products } from '../db/externalAPISchema';
// using { db } from '../db/externalAPISchema';


// service ExternalService {
//     entity A_Products as projection on s4.A_Product{
//     Product,
//     ProductType,
//     PurchaseOrderQuantityUnit,
//     NetWeight,
//     CountryOfOrigin,
//     Brand
// }
// entity ProductsLocal as projection on db.ProductsLocal;
// // entity StoredProducts as projection on Products;
// };