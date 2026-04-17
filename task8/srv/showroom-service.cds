using {db as ms} from '../db/showroomSchema';

service Showroom @(path:'/showroom') {

    entity Showrooms @(restrict: [
        {
            grant: '*',
            to   : 'Admin'
        },
        {
            grant: 'READ',
            to   : viewer
        }
    ]) as projection on ms.Showrooms;

    @odata.draft.enabled
    entity Cars @(restrict: [
        {
            grant: '*',
            to   : 'Admin'
        },
        {
            grant: 'READ',
            to   : viewer
        }
    ]) as projection on ms.Cars
        actions {
            action changeStatus()
        };

    entity CarsTexts as projection on ms.Cars.texts;

    entity Orders @(restrict: [
        {
            grant: '*',
            to   : 'Admin'
        },
        {
            grant: 'READ',
            to   : 'viewer'
        }
    ]) as projection on ms.Orders;

    entity OrderItems @(restrict: [
        {
            grant: '*',
            to   : 'Admin'
        },
        {
            grant: 'READ',
            to   : 'viewer'
        }
    ]) as projection on ms.OrderItems;

    entity Customers @(restrict: [
        {
            grant: '*',
            to   : 'Admin'
        },
        {
            grant: 'READ',
            to   : 'viewer'
        }
    ]) as projection on ms.Customers;

    function getAllDatas()                                                                      returns array of Cars;
    action   postCars(name: String, price: Decimal(15, 2), brand: String, manufactured: String) returns String;
}
