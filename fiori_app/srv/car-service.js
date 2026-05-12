const cds = require('@sap/cds');
const { SELECT, UPDATE } = require('@sap/cds/lib/ql/cds-ql');

module.exports = cds.service.impl( async function() {

    const { Cars, Sales, Customers, DashboardKPI} = this.entities;
  

   this.before(['CREATE','UPDATE'],Cars,async (req) => {
    
       const {status} = req.data;

       if(status==='available'){
        req.data.criticality=3
       }else{
        req.data.criticality=1
       }
   });



   this.after('CREATE',Cars, (res, req) => {
    req.info("Data Created Successfully")
   });

    this.after('UPDATE',Cars, (res, req) => {
    req.info("Data Updated Successfully")
   });


   this.after('READ', 'Cars', (data) => {
    const rows = Array.isArray(data) ? data : [data];

    for (let row of rows) {
        if (row.stock >= 10) {
            row.stockCritically = 3;
        }else if (row.stock > 3 && row.stock <10 ){
            row.stockCritically = 2
        }else {
            row.stockCritically = 1;
        }
    }
    });

    this.on('markAsSold',Cars, async (req) => {
        const { ID} = req.params[0];

        const car = await SELECT.one.from(Cars).where({ ID });
        if(!car){
             return req.error(400,"Car not found")
        };

         const newStatus = car.status === 'sold' ? 'available' : 'sold'
         const updateCriticality = newStatus === 'sold' ? 1 : 3;
            
            await UPDATE(Cars).set({ 
                status : newStatus,
                criticality : updateCriticality
            }).where({ ID});
            
            return `Car Status Changed`
    });

    
    this.on('createSale', async (req) => {

        const { car_ID, customer_ID, quantity } = req.data;

        const car = await SELECT.one.from(Cars).where({ ID: car_ID});
        if(!car){
           return req.error(400,"Car not found")
        };

        if(quantity > 5) {
             req.warn("Large quantity ordered - please double check!")
        }

        const total = car.price * quantity;
        
        await INSERT.into(Sales).entries({
            ID: cds.utils.uuid(),
            saleDate : new Date(),
            quantity,
            total,
            status : 'ordered',
            car_ID,
            customer_ID
        });

        const revisedStock = car.stock - quantity;

        await UPDATE(Cars).set({ stock : revisedStock }).where({ ID : car_ID });

        return `Sale Created Successfully`
    });


    // notify=>toast
    this.after('createSale', (result,req)=> {
        req.notify(`Sale Created successfully for Car ID : ${req.data.car_ID} `)
    });



    // cancel order:
    this.on('cancelOrder', Sales, async(req)=> {

        const { ID } = req.params[req.params.length - 1];
        console.log("Cancelling order ID:", ID);

        const sale = await SELECT.one.from(Sales).where({ ID });
        if(!sale) return req.error(400,"Order not found!!");

        if(sale.status === 'cancelled') return req.error(400, "Order is already cancelled");

        const car = await SELECT.one.from(Cars).where({ ID : sale.car_ID});
        if(!car) return req.error(400,"Car not found");

        const addedStock = sale.quantity + car.stock;
        await UPDATE(Cars).set({ stock : addedStock}).where({ID : sale.car_ID})
        await UPDATE(Sales).set({status : 'cancelled'}).where({ID});

        req.warn("Order cancelled - stock restored");
        
        return `Order cancelled for car : ${car.modelName}`
    });


    // draft save validation:
    this.before('SAVE',Cars.drafts,req => {
        if(req.data.status === 'sold'){
            req.error(400,"Status Cannot be Sold")
        }
        if(!req.data.price){
           return req.error(400,"Price Must be Given!")
        };
        if(req.data.stock <= 0 ) {
           return req.error(400,"stock cannot be Negative")
        }
    });


    this.on('DELETE', Sales, async (req) => {
    const { ID } = req.params[req.params.length - 1];
    await DELETE.from(Sales).where({ ID });
    return req.reply(`Sale deleted successfully`);
});

// this.on('READ', DashboardKPI, async (req) => {
    
//     const totCars = await SELECT.one.from(Cars).columns('count(*) as count');

//     return [{
//         ID : cds.utils.uuid(),
//         totalCars : totCars.count || 0
//     }]
// })

});