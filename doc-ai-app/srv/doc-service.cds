
using { my.docai as db } from '../db/doc-ai-schema';

service DocAIService {
  entity Documents as projection on db.Documents;

  action processDocument( fileName : String, mimeType : String ) returns String;
  action getDocumentStatus(jobId: String) returns String;
};



