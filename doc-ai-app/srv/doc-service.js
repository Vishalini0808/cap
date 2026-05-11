require('dotenv').config();  //load the env file

const cds = require('@sap/cds');
const axios = require('axios');
const FormData = require('form-data');
const fs = require('fs');

module.exports = cds.service.impl(function () {
    
    this.on('processDocument', async (req) => {

      const { fileName, mimeType } = req.data;
      try {
        // fetch token
        const tokenResponse = await axios.post(
          process.env.DOC_AI_TOKEN_URL,
          'grant_type=client_credentials',
          {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            auth: {
              username: process.env.DOC_AI_CLIENT_ID,
              password: process.env.DOC_AI_CLIENT_SECRET
            }
          }
        );
        const accessToken = tokenResponse.data.access_token;
        
        //  read file
        const filePath = `./uploads/${fileName}`;
        const formData = new FormData();
        
        formData.append('file', fs.createReadStream(filePath), {
          filename: fileName,
          contentType: mimeType
        });

        formData.append('options', JSON.stringify({
          clientId: "default",
          schemaName: "SAP_invoice_schema"
        }));
        
        // upload to document ai
        const response = await axios.post(
          `${process.env.DOC_AI_API_URL}/document-information-extraction/v1/document/jobs`,
          formData, {
            headers: {
              ...formData.getHeaders(),
              Authorization: `Bearer ${accessToken}`
            }
          }
        );
        
        const jobId = response.data.id;
        console.log(`job submited : ${jobId}`);
        
        return {
          message: "Job submitted",
          jobId: jobId
        };
      } catch (err) {
        console.error(err.response?.data || err.message);
        req.error(500, 'Document AI failed');
      }
    });


this.on('getDocumentStatus', async (req) => {

  const { jobId } = req.data;

  try {
    // token
    const tokenResponse = await axios.post(
      process.env.DOC_AI_TOKEN_URL,
      'grant_type=client_credentials',
      {
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        auth: {
          username: process.env.DOC_AI_CLIENT_ID,
          password: process.env.DOC_AI_CLIENT_SECRET
        }
      }
    );

    const accessToken = tokenResponse.data.access_token;

    // fetch result
    const res = await axios.get(
      `${process.env.DOC_AI_API_URL}/document-information-extraction/v1/document/jobs/${jobId}`,
      {
        headers: {
          Authorization: `Bearer ${accessToken}`
        }
      }
    );
    // If processing is not complete, return current status only
    if (res.data.status !== "DONE") {
      return {
        status: res.data.status
      };
    }
    // If DONE, return extracted data
    const extraction = res.data.extraction;
    console.log("EXTRACTION DATA :",JSON.stringify(extraction, null, 2));

    return {
      status: "DONE",
      data: extraction
    };

  } catch (err) {
    console.error(err.response?.data || err.message);
    req.error(500, 'Status check failed');
  }
});

});