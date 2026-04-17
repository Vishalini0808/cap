using {my.showroom as ms} from '../db/showroom-schema';

service ShowRoom {

    entity ShowRooms as projection on ms.Showroom {
        *,
        virtual totalCars : Integer,
        virtual totalStock : Integer
    };

    entity Cars as projection on ms.Car {
        ID,
        name,
        colour,
        price,
        varient,
        stock,
        fuelType,
        manufactured,
        showroom,
        booking,
        // status,
        employees,
        virtual stockStatus : String
    };

    entity Customers as projection on ms.Customer;
    entity Bookings as projection on ms.Booking{
        *,
        virtual message : String
    };

    entity Employees as projection on ms.Employee;
    entity CarEmployees as projection on ms.CarEmployee;
    entity BookingEmployees as projection on ms.BookingEmployee;



    action bookCar (
        carID : UUID,
        customerID : UUID,
        deliveryDate : Date,
        quantity : Integer
    ) returns Bookings;

};