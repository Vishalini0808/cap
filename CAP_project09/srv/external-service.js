const cds = require ('@sap/cds');

module.exports = cds.service.impl( async function () {

    const ext = await cds.connect.to('API_BUSINESS_PARTNER');

    this.on('READ', 'BusinessPartner', async (req) => {
        return ext.run(req.query)
    });

     this.on('READ', 'EmailAddress', async (req) => {
        return ext.run(req.query)
    });

    this.on('READ', 'PhoneNumber', async (req) => {
        return ext.run(req.query)
    });

    
});