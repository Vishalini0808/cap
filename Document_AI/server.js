const cds = require('@sap/cds');
const multer = require('multer');

const upload = multer(); // memory

cds.on('bootstrap', (app) => {
  app.post('/processDocument', upload.single('file'), async (req, res) => {
    try {
      const srv = await cds.connect.to('DocumentService');

      const result = await srv.processDocument({
        file: req.file   // 👈 pass file
      });

      res.json(result);
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: err.message });
    }
  });
});

module.exports = cds.server;