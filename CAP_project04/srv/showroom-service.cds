// using {my.carshowroom as mcs} from '../db/showroom-schema';

// service CarShowroomService {

//     entity Manufacturers as projection on mcs.Manufacturer;
//     entity CarModels as projection on mcs.CarModel;
//     entity Cars as projection on mcs.Car;
//     entity Showrooms as projection on mcs.Showroom;
//     entity Orders as projection on mcs.Order;
//     entity StateTaxes as projection on mcs.StateTax;
    
//     // action orderCar(carID : String, quantity: Integer, showroomID:String) returns String;

//     action orderCars ( carModel_ID : UUID,showroom_ID : UUID, quantity : Integer) returns String;

//     action approveOrder ( orderID : UUID) returns String;

//     action cancelOrder ( orderID : UUID, showroomID : UUID) returns String;

//     function calculateTax ( orderID : UUID) returns Decimal(15,2);


// }