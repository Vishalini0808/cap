const cds = require('@sap/cds')

const INSERT = require("@sap/cds/lib/ql/INSERT");
const SELECT = require("@sap/cds/lib/ql/SELECT");
const UPDATE = require("@sap/cds/lib/ql/UPDATE")



module.exports = cds.service.impl( async function () {

    const { Cars,Bookings,Customers,ShowRooms } = this.entities;


    // before handler-create city if not given
    this.before('CREATE', Customers, (req) =>{
        if(!req.data.city ) {
            req.data.city = "Unknown";
        }
    });


    this.on('bookCar', async (req)=> {

        const { carID,customerID, deliveryDate, quantity} = req.data;
        
        const car = await SELECT.one.from(Cars).where({ ID : carID});

        if(!car) return  req.error(400,"Car not found");
        if( car.stock <=0) return req.error(400,"Car is out of stock");

        const customer = await SELECT.one.from(Customers).where({ ID : customerID});
        if(!customer) return req.error(400,"Customer not found");

        const booking = await INSERT.into(Bookings).entries({
            car_ID : carID,
            customer_ID : customerID,
            bookingDate : new Date(),
            deliveryDate : deliveryDate,
            totalAmount : car.price,
            quantity : quantity
        });

        await UPDATE(Cars).set({ stock: car.stock - 1}).where({ ID : carID});

        await UPDATE(Cars).set({ status : "Booked"}).where({ ID : carID})

        return {
            message : `  car booked successfully`,
            bookingID : booking.ID
        };
    });



     // before handler-Delete
    this.before ('DELETE',Bookings, async(req)=>{
        const isbooked = await SELECT(Bookings).where({ID : req.data.ID});
       if(isbooked){
         req.error(400,"Cannot Delete the Booked Car");
       }
    });



    // after handler- get totalstocks and totalcars in showroom
    this.after('READ',ShowRooms,async (data)=>{
        for( let showroom of data){
            const cars = await SELECT.from(Cars).where({showroom_ID : showroom.ID });
            showroom.totalCars = cars.length;

             showroom.totalStock = cars.reduce((sum,e)=> {
                return sum + (e.stock || 0);
            },0);
        }
    });


    // delete showroom-if booking exists no delete(deep delete)
    this.before('DELETE',ShowRooms, async (req)=> {

        const showroomId = req.data.ID;

        // fetch all cars
        const cars= await SELECT.from(Cars).where({showroom_ID: showroomId});
        if(!cars.length) return;    //no cars means delete

        const carId = cars.map(e => e.ID);

        // check that car id have bookings
        const isbooked = await SELECT.from(Bookings).where({ car_ID : {in : carId} });

        if(isbooked) {
            req.error(400, "Cannot delete the showroom. It has active bookings.")
        }
    });



    // after handler : 
    this.after ('READ',Cars, (data)=>{
        data.forEach(car => {
            car.stockStatus = car.stock < 10 ? "Low stocked" : "Available";
            
        });
    });
   

     // // beforehandler-create
    // this.before('CREATE',Bookings, async(req)=>{

    //     const { car_ID,customer_ID } = req.data;

    //     if(!car_ID || !customer_ID ){
    //         req.error(400,"Car/Customer not found");
    //     }
        
    //     const car = await SELECT.one.from(Cars).where({ID : car_ID});
    //     const customer = await SELECT.one.from(Customers).where({ID : customer_ID});

    //     if(!car){
    //         req.error(400,"Car not found")
    //     }

    //     if(!customer){
    //         req.error(400,"Customer not found")
    //     }

    //     if(car.stock <= 0){
    //         req.error(400,"Car is out of stock");
    //     }

    //     req.data.totalAmount = car.price;
        
    // });



    // this.after('CREATE',Bookings,(data)=> {
    //     if(Array.isArray(data)){
    //         data.forEach(e=>
    //             e.message = "Bookings created Successfully !!!"
    //         )
    //     }else{
    //     data.message = "Bookings created Successfully !!!"
    //     }
    // });



});

