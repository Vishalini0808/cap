using { cuid } from '@sap/cds/common';

namespace my.car;

entity Showrooms : cuid {
    name : String;
    location : String;
}

type Carstatus : String enum {
    available;
    reserved;
    sold;
}

entity Cars : cuid {
    name : localized String;
    brand : localized String;
    manufactured : String;
    price : Decimal(15,2);
    showroom : Association to Showrooms;
    status : Carstatus default 'available';
}