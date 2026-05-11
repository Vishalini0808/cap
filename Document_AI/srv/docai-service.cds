// using { my.car as db } from '../db/docai-schema';

service DocumentService {

    // entity Cars as projection on db.Cars;
    // entity Showrooms as projection on db.Showrooms;

    action processDocument() returns String;
    action getDocumentStatus(jobId: String) returns String;
};