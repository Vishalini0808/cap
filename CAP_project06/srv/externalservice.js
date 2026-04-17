const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {

    const { SalesOrder, s4_SalesOrderItems } = this.entities;
    const s4 = await cds.connect.to('API_SALES_ORDER_SRV');

   
   this.on('READ', s4_SalesOrderItems, async (req) => {
        const s4Data = await s4.run(req.query);

        for (const item of s4Data) {
            await UPSERT.into(s4_SalesOrderItems).entries({
                SalesOrder: item.SalesOrder,
                SalesOrderItem: item.SalesOrderItem,
                SalesOrderItemCategory: item.SalesOrderItemCategory,
                PurchaseOrderByCustomer: item.PurchaseOrderByCustomer,
                RequestedQuantity: item.RequestedQuantity,
                NetAmount: item.NetAmount,
                TaxAmount: item.TaxAmount
            });

            await UPSERT.into(SalesOrder).entries({
                SalesOrder: item.SalesOrder
            });
        }

        return s4Data;
    });

});