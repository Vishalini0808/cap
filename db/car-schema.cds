

namespace my.showroom;

entity Manufacturer  {
    Key ID : UUID @title: '{i18n>manufacturerId}';
    name        : String @title: '{i18n>manufacturerName}';
    country     : String @title: '{i18n>country}';
    foundedYear : Integer @title: '{i18n>foundedYear}';

    manufacturerUrl : String @title: '{i18n>manufacturerUrl}';

    cars        : Association to many Car on cars.manufacturer = $self;
}

type availablestatus :  String enum { available; sold }

type FuelType : String enum {
    Petrol;
    Diesel;
    Hybrid;
    Electric;
    CNG;
}

entity Car  {
    Key ID : UUID ;
    modelName    : String ;   
    bodyType     : String ;
    price        : Decimal(15,2) ;
    stock        : Integer;
    fuelType     : FuelType ;
    mileage      : Decimal(5,2) ;
    status : availablestatus ;

    manufacturer_ID : UUID ;
    manufacturer : Association to Manufacturer on manufacturer.ID = manufacturer_ID;
    sales        : Association to many Sale on sales.car = $self;

    criticality : Integer ;
    imageUrl : String ;
}

entity Customer  {
    Key ID : UUID ;
    name    : String ;
    city    : String ;
    email   : String ;

    purchases : Association to many Sale on purchases.customer = $self;
}

type SaleStatus : String enum {
    ordered;
    cancelled;
}

entity Sale  {
    Key ID : UUID ;
    saleDate : Timestamp  @UI.DateTimeStyle : 'medium';
    quantity : Integer ;
    total    : Decimal(15,2);
    status : SaleStatus;

    car      : Association to Car;
    customer : Association to Customer;
}

