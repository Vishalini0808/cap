const cds = require('@sap/cds');
const { executeHttpRequest } = require('@sap-cloud-sdk/http-client');
const FormData = require('form-data');

module.exports = cds.service.impl(function () {

  this.on('processDocument', async (req) => {

    try {
      const file = req.file;   // 👈 SIMPLE (no req.data, no req._.req)

      if (!file) {
        req.error(400, 'File missing');
      }

      const formData = new FormData();
      formData.append('file', file.buffer, {
        filename: file.originalname,
        contentType: file.mimetype
      });

      formData.append('options', JSON.stringify({
        clientId: "default",
        schemaName: "SAP_invoice_schema"
      }));

      const response = await executeHttpRequest(
        { destinationName: 'doc-ai-destination' },
        {
          method: 'POST',
          url: '/document-information-extraction/v1/document/jobs',
          data: formData,
          headers: {
            ...formData.getHeaders()
          }
        }
      );

      return { jobId: response.data.id };

    } catch (err) {
      console.error(err.response?.data || err.message);
      req.error(500, 'Document AI failed');
    }
  });

});