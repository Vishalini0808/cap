// using { cuid, managed } from '@sap/cds/common';

// namespace my.carshowroom;

// entity Manufacturer : cuid,managed {

//     name : String;
//     location : String;

//     carModels : Composition of many CarModel on carModels.manufacturer = $self;

// }

// entity CarModel :cuid,managed {

//     name : String;
//     stock : Integer;
//     baseprice : Decimal(15,2);
//     // orders : Composition of many Order on orders.carModel = $self;
//     manufacturer : Association to Manufacturer;
//     showrooms : Association to many CarModelShowroom on showrooms.carModel = $self;
// }


// entity Showroom : cuid,managed {

//     name : String;
//     city : String;

//     state : Association to StateTax;
//     manufacturer : Association to  Manufacturer;

//     carModels : Association to many CarModelShowroom on carModels.showroom = $self;
   
// }

// entity CarModelShowroom {
//     key carModel : Association to CarModel;
//     key showroom : Association to Showroom;
// }


// type carOrderStatus : String enum { pending ; approved ; rejected; cancelled }

// entity Order : cuid,managed {

//     quantity : Integer;
//     totalPrice : Decimal(15, 2);
//     taxAmount : Decimal(15, 2);
//     status : carOrderStatus default 'pending' ;

//     showroom : Association to Showroom;
//     carModel : Association to CarModel;
//     }

// type carStatus : String enum { available ; booked ; cancelled }

// entity Car  {

//     key ID : String;
//     name : String;
//     price : Decimal(15,2);
//     status : carStatus default 'available' ;

//     model : Association to CarModel;
//     showroom : Association to Showroom;
// }


// entity StateTax {

//    key state : String;
//     stateSF : String(2);
//     taxRate : Decimal(5,2);
// }



