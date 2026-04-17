using { cuid } from '@sap/cds/common';

namespace db;

entity Showrooms : cuid {
    name : String;
    location : String;
}

type Carstatus : String enum { available ; reserved ; sold}

entity Cars : cuid {
    name : localized String @title : '{i18n>name}' ;
    brand : localized String @title : '{i18n>brand}' ;
    manufactured :  String @title : '{i18n>manufactured}' ;
    price : Decimal(15,2);
    showroom : Association to Showrooms;
    status: Carstatus default 'available';
    orderItems : Association to many OrderItems on orderItems.car= $self;
}
 
entity Orders : cuid {
    quantity : Integer;
    orderItems :Composition of many OrderItems on orderItems.order= $self;
    customer : Association to Customers;
}

entity OrderItems : cuid {
   key order : Association to Orders;
   key car :Association to Cars;
}

entity Customers : cuid {
    name : String;
}
