
using my.carshowroom as cdsview from './showroom-schema';

view CarModelManufacturer as select from cdsview.Manufacturer as m inner join cdsview.CarModel as c  on c.manufacturer.ID = m.ID {
    key m.ID,
    m.name as ManufacturerName,
    m.location as Location,
    c.name as CarModelName,
    c.stock as Stock
};


