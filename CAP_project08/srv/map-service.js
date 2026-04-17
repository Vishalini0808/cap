const cds = require('@sap/cds');
const axios = require('axios');
const { Country, State, City } = require('country-state-city');

// npm package
function getCountryCode(countryName) {

        const countries = Country.getAllCountries();

        const match = countries.find (c => c.name.toLowerCase() === countryName.trim().toLowerCase());
        return match ? match.isoCode : null;
    }

// npm package
function getStateCode(stateName, countryCode) {

    const states = State.getStatesOfCountry(countryCode);

    const input = stateName.trim().toLowerCase();

    let match = states.find(s=> s.name.toLowerCase() === input);
    if (!match) {
        match = states.find(
            s => s.name.toLowerCase().includes(input)
        );
    }
    return match ? match.isoCode : null;
}




// geonames-state
async function getStatesByCountry(countryname) {
    try {
        const countryresponse = await axios.get(`http://api.geonames.org/searchJSON`, {
            params : { q : countryname, maxRows : 1, username : 'vishalini_durai'}
        });

        // console.log(countryresponse.data);
        console.log(countryresponse.data.geonames);

        const country = countryresponse.data.geonames[0];
        if(!country) return [];
        // const countryCode = country.countryCode;

        const stateresponse = await axios.get(`http://api.geonames.org/childrenJSON`,{
            params : { geonameId : country.geonameId, username : 'vishalini_durai'}
        });

        // console.log(stateresponse.data.geonames);
        

        return stateresponse.data.geonames.map(s=> ({ 
            state : s.name,
            statecode : s.adminCode1,
            latitude : s.lat,
            longitude: s.lng,
            country: s.countryName
        }));

    } catch (error) {
        console.error(error.message);
        return [];
    }
}

// geonames- district
async function getDistrictsByState(stateName) {
    try {
        const stateres = await axios.get(`http://api.geonames.org/searchJSON`, {
            params: {q: stateName, featureCode: 'ADM1', maxRows: 1, username: 'vishalini_durai' }
        });

        const state = stateres.data.geonames[0];
        if (!state) return [];

        // console.log(stateres.data);

        const districtResponse = await axios.get(`http://api.geonames.org/childrenJSON`, {
            params: { geonameId: state.geonameId, username: 'vishalini_durai'}
        });

        // console.log(districtResponse.data.geonames);
    
        return districtResponse.data.geonames.map(d => ({
            district: d.name,
            latitude : d.lat,
            longitude: d.lng,
            state : d.adminName1,
            country : d.countryName
        }));

    } catch (error) {
        console.error(error.message);
        return [];
    }
}



// geonames - cities
async function getCitiesByState(name) {
    try {
        const citiesres = await axios.get(`http://api.geonames.org/searchJSON`, {
            params: { q: name, featureClass: 'P',  maxRows: 10, username: 'vishalini_durai' }
        });

        // console.log(citiesres.data.geonames);

        return citiesres.data.geonames.map(c=> ({
            place : c.name,
            state : c.adminName1,
        }));
        
    } catch (error) {
        console.error(error.message);
        return [];
    }
}

async function getByPincode(pincode, country = 'IN') {
    try {
        const res = await axios.get(`http://api.geonames.org/postalCodeSearchJSON`, {
            params: { postalcode: pincode, country: country, username: 'vishalini_durai'
            }
        });

        return res.data.postalCodes.map(p => ({
            pincode: p.postalCode,
            city: p.placeName,
            state: p.adminName1,
            district: p.adminName2,
            country: p.countryCode
        }));

    } catch (err) {
        console.error(err.message);
        return [];
    }
}




// service implementation:
module.exports = cds.service.impl(async function () {


    // openstreetmapapi
    this.on('getLocation', async (req) => {

        const { address } = req.data;

        if (!address) {
            return req.error(400, "Address is required");
        }

        try {

            const response = await axios.get(
                'https://nominatim.openstreetmap.org/search',
                {
                    params: {
                        q: address,
                        format: 'json',
                        addressdetails: 1,
                        limit: 5
                    },
                    headers: {'User-Agent': 'cap-app'}
                }
            );

            const connRes = response.data;

            if (!connRes || connRes.length === 0) {
                return {
                    latitude: null,
                    longitude: null,
                    city: null,
                    state: null,
                    pincode: null,
                    country: null
                };
            }

            // const res = connRes[0];

            return connRes.map (res => ({
                latitude: res.lat,
                longitude: res.lon,
                city: res.address.city || res.address.town || res.address.village,
                state: res.address.state,
                pincode: res.address.postcode,
                country: res.address.country
            })); 

        } catch (error) {
            console.error(error.message);
            return req.reject(500, "External API failed");
        }

    });


    // openstreet-structured
   this.on('getStructuredLocation', async (req) => {
        const {amenity, street,city, county, state,country,postalcode} = req.data;

        if (!amenity && !street && !city && !county && !state && !country && !postalcode) {
            return req.reject(400, "Provide at least one search parameter");
        }

        try {
            const res = await axios.get('https://nominatim.openstreetmap.org/search', {
                params: {
                    amenity,street,city,county, state, country,postalcode,
                    format: 'json'
                },
                headers: {
                    'User-Agent': 'cap-app'
                }
            });
            const data = res.data;
            if (!data || data.length === 0) {
                return req.reject(404, "No results found");
            }  
            // console.log(data);
           
            return data.map(loc => ({
                latitude: loc.lat,
                longitude: loc.lon,
                display_name: loc.display_name,
                boundingbox: loc.boundingbox
            }));
        } catch (error) {
            console.error(error);
            return req.reject(500, error.message);
        }
    });


    // geonames: handlers
    this.on('getStatesByCon', async (req) => {
        const { country } = req.data;
        return await getStatesByCountry(country);
    });

    this.on('getDistrictsByCon', async (req) => {
        const { state } = req.data;
        return await getDistrictsByState(state);
    });  

    this.on('getCitiesByst', async (req) => {
        const { name } = req.data;
        return await  getCitiesByState(name);
    });
   
    this.on('getByPincode', async (req) => {
    const { pincode } = req.data;
    return await getByPincode(pincode);
});



    // npm package- country,state,city
    this.on('getStates', async (req)=> {

        const { country } = req.data;
        if(!country) req.error (400,"Country Required");

        const countryCode = getCountryCode(country);

        if(!countryCode) {
            return req.error(400,"Invalid Country")
        }

        const states = State.getStatesOfCountry(countryCode);
        // console.log(states);
        

        if (!states || states.length === 0) {
        return [];
        }
        // return states.map(s=> s.name);
        return states;
    });


    this.on('getCities',async (req)=> {

        const { state, country} = req.data;
        if (!state || !country ) {
            return req.error (400, "State and country required");
        }
        // console.log("State Input:", state);

        const countryCode = getCountryCode(country);
        if(!countryCode) {
            return req.error(400,"Invalid Country")
        }

        const stateCode = getStateCode(state, countryCode);
        if(!stateCode) req.error (400,"Invalid State");

        const cities = City.getCitiesOfState(countryCode,stateCode);

        if( !cities || cities.length === 0) {
            return [];
        }

        // return cities.map( c => c.name);
        return cities;
    });



    // geoapify:
    // const API_KEY = '020273d7315948c4806466949f4ac5fc'

    // this.on('getDistrictsByState', async (req) => {

    //     const { state } =req.data;
    //     if (!state) {
    //         return req.reject(400, "State is required");
    //     }

    //     try {
    //         const response = await axios.get('https://api.geoapify.com/v1/geocode/search', {
    //             params : {
    //                 text : state,
    //                 filter : 'countrycode:in',
    //                 format : 'json',
    //                 apiKey : API_KEY
    //             }
    //         });

    //         const data = response.data.results;

    //         const districts = data.map(d => d.country).filter((v,i,a)=> v && a.indexOf(v) === i);
    //         return districts.map(di => ({
    //             district : di,
    //             state : state
    //         }));

    //     } catch (error) {
    //         return req.reject(500, error.message);
    //     }


    // })




});