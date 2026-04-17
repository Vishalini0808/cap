const cds = require('@sap/cds');
const { SELECT } = require('@sap/cds/lib/ql/cds-ql');
const { UPSERT } = require('@sap/cds/lib/ql/cds-ql');

module.exports = cds.service.impl( async function () {

    const {SalesOrder, SalesOrderItem }= this.entities;

    const s4 = await cds.connect.to('API_SALES_ORDER_SRV');
    
    this.on('replicateProducts', async(req)=>{
         console.log("hi");
         
        const orders = await s4.run(SELECT.from('A_SalesOrder').limit(10));
        const orderItems = await s4.run(SELECT.from('A_SalesOrderItem').limit(10));

        return orders;

        await UPSERT.into(SalesOrder).entries(orders);
        await UPSERT.into(SalesOrderItem).entries(orderItems);

//         await DELETE.from(SalesOrderItems);
// await DELETE.from(SalesOrders);

        // return `Replicated ${orders.length} orders & ${orderItems.length} orderItems`;

    })



    // this.on('READ', SalesOrders, async(req) => {
    //     console.log(req.query);
    //     const products = await s4.run(SELECT.from(SalesOrders).limit(10));
        
    //     // await UPSERT.into(ProductsLocal).entries(products);
    //     return products;
    // });

    // this.on('READ', SalesOrderItems, async(req) => {
    //     console.log(req.query);

    //     const salesOrderItem = await s4.run(SELECT.from(SalesOrderItems).limit(10));        
    //     return salesOrderItem;
    // });














    // this.on('READ',StoredProducts, async(req)=> {

    //      const data = await SELECT.from(StoredProducts)
    //      return data;
    // });



});