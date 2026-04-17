const cds = require('@sap/cds');

module.exports = cds.service.impl(function () {

  // Before creating an Incident
  this.before('CREATE', 'Incidents', (req) => {
    const data = req.data;

    // If title contains "urgent", set urgency to High
    if (data.title && data.title.toLowerCase().includes('urgent')) {
      data.urgency_code = 'H';
    }
  });

  // Before updating an Incident
  this.before('UPDATE', 'Incidents', async (req) => {

    // Check if the incident is already closed
    const result = await SELECT.one.from('Incidents')
      .where({ ID: req.data.ID, status_code: 'C' });

    // If closed, stop the update
    if (result) {
      req.reject("Can't modify a closed incident!");
    }
  });

});