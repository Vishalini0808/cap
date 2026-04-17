using { cuid, managed } from '@sap/cds/common';

namespace my.carshowroom;

entity Manufacturer : cuid,managed {

    name : localized String;
    location : String;
    carModels : Association to many CarModel on carModels.manufacturer = $self;
}


entity CarModel :cuid,managed {

    name : localized String;
    stock : Integer;
    baseprice : Decimal(15,2);
    oldprice : Decimal(15,2);
    manufacturer : Association to Manufacturer;
    showrooms : Association to many CarModelShowroom on showrooms.carModel = $self;
}

entity StateTax : managed{

   key state : String;
    stateSF : String(2);
    taxRate : Decimal(5,2);
}


entity Showroom : cuid,managed {

    name : localized String;
    city : localized  String;
    state : Association to StateTax;
    manufacturer : Association to  Manufacturer;
    carModels : Association to many CarModelShowroom on carModels.showroom = $self;
    employees : Composition of many Employee on employees.showroom = $self;
}


entity CarModelShowroom : managed{
    key carModel : Association to CarModel;
    key showroom : Association to Showroom;
}


type carOrderStatus : String enum { pending ; approved ; rejected; cancelled }

entity Order : cuid,managed {

    quantity : Integer;
    totalPrice : Decimal(15, 2);
    taxAmount : Decimal(15, 2);
    status : carOrderStatus default 'pending' ;
    showroom : Association to Showroom;
    carModel : Association to CarModel;
    shipments : Composition of many Shipment on shipments.order = $self;
}

entity Shipment : cuid, managed {

    shipmentDate : Date;
    deliveryDate : Date;
    status : String;
    order : Association to Order;
}


type carStatus : String enum { available ; booked ; cancelled }

entity Car :managed {

    key ID : String;
    name : String;
    price : Decimal(15,2);
    oldprice : Decimal(15,2);
    status : carStatus default 'available' ;
    model : Association to CarModel;
    showroom : Association to Showroom;
    carBooking : Composition of many CarBooking on carBooking.car = $self;
}

type ContactNumber : String(15) @assert.format: '^[0-9]{10}$';

type Details {
    Name : String;
    Age: Integer;
    Contact : ContactNumber;
    mailId: String;
}

type Address {
    street: String;
    city :String;
    state : String;
    pincode : Integer;
}

entity Employee : cuid, managed {
    personalDetails : Details;
    address : Address;
    department   : String;
    designation    : String;
    salary : Decimal(15,2);
    showroom : Association to Showroom;
    manager : Association to Employee;  
}


entity Customer : cuid, managed {
    personalDetails : Details;
    address : Address;
}

type carBookingStatus : String enum { pending ; booked ; cancelled }


entity CarBooking : cuid, managed {
    car : Association to Car;       
    customer : Association to Customer; 
    bookingDate : Date;
    status : carBookingStatus default 'pending';
}






