using {sap.capire.incidents as my} from '../db/schema';

/**
 * Service used by support personell, i.e. the incidents' 'processors'.
 */
service ProcessorService @(requires: 'authenticated-user') {
    @odata.draft.enabled
    @requires: 'support'
    entity Incidents as projection on my.Incidents;

    @readonly
    @requires: 'support'
    entity Customers as projection on my.Customers;
}

/**
 * Service used by administrators to manage customers and incidents.
 */
service AdminService @(requires:['authenticated-user','admin']) {
    entity Customers as projection on my.Customers;
    entity Incidents as projection on my.Incidents;
}
