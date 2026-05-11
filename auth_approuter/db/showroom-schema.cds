using { cuid } from '@sap/cds/common';

namespace my.showroom;

entity Manufacturer : cuid {
    name        : String;
    country     : String;
    foundedYear : Integer;

    cars        : Association to many Car on cars.manufacturer = $self;
}

type availablestatus :  String enum { available; sold }

type FuelType : String enum {
    Petrol;
    Diesel;
    Hybrid;
    Electric;
}

entity Car : cuid {
    modelName    : String;   
    bodyType     : String;
    price        : Decimal(15,2);
    stock        : Integer;
    fuelType     : FuelType;
    mileage      : Decimal(5,2);
    status : availablestatus default 'available';

    manufacturer : Association to Manufacturer;
    sales        : Association to many Sale on sales.car = $self;
}

entity Customer : cuid {
    name    : String;
    city    : String;
    email   : String;

    purchases : Association to many Sale on purchases.customer = $self;
}

entity Sale : cuid {
    saleDate : Date;
    quantity : Integer;
    total    : Decimal(15,2);

    car      : Association to Car;
    customer : Association to Customer;
}