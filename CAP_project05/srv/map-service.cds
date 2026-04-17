 service MapService {


  function getLocation(address : String) returns array of{
    latitude  : String;
    longitude : String;
    city      : String;
    state     : String;
    pincode   : String;
    country   : String;
  };
    
 
 }