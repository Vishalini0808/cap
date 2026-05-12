

namespace my.showroom;

entity Manufacturer  {
    Key ID : UUID ;
    name        : String ;
    country     : String;
    foundedYear : Integer ;

    manufacturerUrl : String ;

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
    saleCriticality : Integer;

    car      : Association to Car;
    customer : Association to Customer;
    salesExecutive : Association to Employee;
}

entity Employee {
    key ID        : UUID;
    name          : String;
    designation   : String;
    email         : String;
}

type TestDriveStatus : String enum {
        Requested;
        Approved;
        Completed;
        Cancelled ;
}

entity TestDriveBooking {
    key ID          : UUID;
    bookingDate     : Timestamp @UI.DateTimeStyle : 'medium';
    preferredTime   : String;
    status          : TestDriveStatus;
    TestDriveCriticallity : Integer;

    customer        : Association to Customer;
    car             : Association to Car;

}

type paymentMethodtype : String enum  {
        Cash;
        Card;
        UPI;
        Loan;
        }
type paymentStatusType    : String enum {
        Pending;
        Paid;
        Failed;
    };
entity Payment {
    key ID           : UUID;
    paymentDate      : Timestamp @UI.DateTimeStyle : 'medium';
    amount           : Decimal(15,2);
    paymentMethod    : paymentMethodtype ;
    paymentStatus    : paymentStatusType ;

    paymentMethodCriticallity : Integer;
    paymentStatusCriticallity  : Integer;
    sale             : Association to Sale;
}