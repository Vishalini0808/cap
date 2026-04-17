 service MapService  {


  function getLocation(address : String) returns array of{
    latitude  : String;
    longitude : String;
    city      : String;
    state     : String;
    pincode   : String;
    country   : String;
  };

  
  function getStates(country : String) returns array of String;

  function getCities(state : String, country : String) returns array of String;


  function getStatesByCon( country : String) returns array of String;

  function getDistrictsByCon ( state : String) returns array of String;

  function getCitiesByst (name : String) returns array of String;

  function getByPincode (pincode : String) returns array of String;

  // function getDistrictsByState( state : String ) returns array of {
  //       district : String;
  //       state    : String;
  //   };


}