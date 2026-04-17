using { cuid, managed } from '@sap/cds/common';

namespace my.showroom;


entity Showroom : cuid, managed {

    name : String (50);
    location : String(20) ;
    email: String(50);
    contact: String;

    car : Composition of many Car on car.showroom = $self;
}
  
type carstatus : String enum {Available ; Booked; Cancelled}

entity Car : cuid,managed {

    name : String;
    varient : String;
    fuelType : String;
    manufactured : Date;
    price : Decimal;
    colour : String;
    stock: Integer;
    // status : carstatus default 'Available';

    showroom : Association to Showroom;
    booking : composition of many Booking on booking.car = $self;

    employees : Association to many CarEmployee on employees.car = $self;
}



entity Customer : cuid {

    name : String (30);
    contact : String ;
    email :String (50);
    city : String ;

    booking : Composition of many Booking on booking.customer = $self;
}


entity Booking : cuid,managed {

    bookingDate :Date;
    deliveryDate :Date;
    totalAmount : Decimal;
    quantity : Integer;

    customer: Association to Customer;
    car : Association to Car;

    employees : Association to many BookingEmployee on employees.booking = $self;
}


entity Employee : cuid,managed {

    name : String;
    role : String;
}


//mapping entities

entity CarEmployee : managed {
   key car : Association to Car;
   key employee : Association to Employee;
}

entity BookingEmployee : managed {
   key booking : Association to Booking;
   key employee : Association to Employee;
}

