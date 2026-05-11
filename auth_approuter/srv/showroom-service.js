const cds = require ('@sap/cds');

module.exports = cds.service.impl( async function () {

    const { Manufacturers, Cars } = this.entities;

    this.on('READ',Cars, async (req) => {

        const response = await SELECT.from(Cars)
        // .where({ price : { '>' : 5000000}})
        // .columns('modelName', 'manufacturer.name');
        // .columns('modelName','manufacturer.name' ).where({ stock : { '>' : 3 } , 'manufacturer.name' : 'BMW' });
        return response;
    });

});