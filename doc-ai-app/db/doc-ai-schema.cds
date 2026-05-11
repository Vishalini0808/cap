namespace my.docai;

entity Documents {
  key ID           : UUID;
  fileName         : String;
  mimeType         : String;
  extractedData    : LargeString;
  createdAt        : Timestamp;
}





























// entity Invoices {
//   key ID            : UUID;
//   documentNumber    : String;
//   documentDate      : Date;
//   vendorName        : String;
//   customerName      : String;
//   grossAmount       : Decimal(15,2);
//   taxAmount         : Decimal(15,2);
//   currency          : String;
// }

// entity InvoiceItems {
//   key ID        : UUID;
//   invoice       : Association to Invoices;
//   description   : String;
//   quantity      : Integer;
//   unitPrice     : Decimal(15,2);
//   amount        : Decimal(15,2);
// }