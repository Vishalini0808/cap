using { my.showroom as db } from '../db/showroom-schema';

service ShowroomService {

    entity Manufacturers as projection on db.Manufacturer;

    entity Cars as projection on db.Car;

    entity Customers as projection on db.Customer;

    entity Sales as projection on db.Sale;
};