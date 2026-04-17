using { API_BUSINESS_PARTNER as ext} from './external/API_BUSINESS_PARTNER';

service ExternalService @(requires : 'authenticated-user') {

    entity EmailAddress @(restrict : [
        { grant : '*', to : 'ExtAdmin'}
    ]) as projection on ext.A_AddressEmailAddress;
    entity PhoneNumber @(restrict : [
        { grant : '*', to : 'ExtDeveloper'}
    ])
     as projection on ext.A_AddressPhoneNumber;
    entity BusinessPartner as projection on ext.A_BusinessPartner;

}