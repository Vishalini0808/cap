using { my.showroom as db } from '../db/car-schema';

service ShowroomService  {
    @odata.draft.enabled
    entity Manufacturers as projection on db.Manufacturer;
    @odata.draft.enabled
    entity Cars as projection on db.Car {
    *,
    virtual stockCritically : Integer}
    actions {
        action markAsSold() returns String;
    };
    @odata.draft.enabled
    entity Customers as projection on db.Customer;
    @odata.draft.enabled
    entity Sales as projection on db.Sale actions{
         action cancelOrder() returns String;
    }

    action createSale(car_ID: UUID, customer_ID : UUID, quantity: Integer) returns String;

    
    entity KPIDashboard {
        Key ID  : UUID;
        totalCars : Integer;
        availableCars : Integer;
        soldCars : Integer;
        totalCustomers : Integer;
        totalRevenue : Decimal(15,2);
        lowStockCars : Integer;
    }
};