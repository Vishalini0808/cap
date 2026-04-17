const cds = require('@sap/cds');

module.exports = cds.service.impl( async function () {

    
this.on('getLocation', async(req)=> {

        const { address } = req.data;
        if (!address) {
            return req.error(400, "Address is required");
        }

        try {
            const api = await cds.connect.to('MAP_URL') ;

        const connRes = await api.get(
             `/search?q=${encodeURIComponent(address)}&format=json&addressdetails=1&limit=5`
        );

        if(!connRes || connRes.length === 0 ) {
            return {
                latitude : null, 
                longitude : null,
                city: null,
                state: null,
                pincode: null,
                country: null
            }
        };

        const res = connRes[0];

        return {
            latitude : res.lat,
            longitude : res.lon,
            city: res.address.city,
            state: res.address.state,
            pincode: res.address.postcode,
            country: res.address.country
        }
            
        } catch (error) {
            console.error(error);
            return req.reject(500, "Destination- API failed");
        }
    });


});