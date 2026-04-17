const cds = require('@sap/cds');
const { SELECT } = require('@sap/cds/lib/ql/cds-ql');

module.exports = cds.service.impl( async function () {

    const { Cars } = this.entities;

    this.before('CREATE', Cars, async (req)=> {

        const { name, brand} = req.data;
        
        const bundle = cds.i18n.bundle4(req);
        
        if(!name){
            const msg = bundle.at('REQUIRED_NAME')
            req.error(400,msg);
        }
        if(!brand){
            const msg = bundle.at('INVALID_BRAND')
            req.error(400,msg)
        }
    });

    this.on('READ',Cars, async (req)=> {
        const cars = await cds.run(req.query);
        return cars;
    })

    this.on('postCars', async (req)=> {

        const { name, brand, manufactured } = req.data;

        if(!name || !brand || !manufactured){
            req.error(400,'Details required')
        }

        const car = await INSERT.into(Cars).entries({
            name,
            brand,
            manufactured
        });
        return car; 
    });


    this.on('getAllDatas', async(req)=>{

        const activedata = await SELECT.from(Cars);
        const draftdata = await SELECT.from(Cars.drafts);

        // console.log(draftdata);
        // console.log(Cars.drafts);
        console.log("------triggered-------");
        
        
        const datas = [...activedata,...draftdata]
        return datas;
    });


    this.on('changeStatus',Cars, async (req)=> {

        const carID = req.params[0].ID;
        const car = await SELECT.one.from(Cars).where({ ID : carID });

        const newStatus = car.status === 'available' ? 'sold' : 'available';
        await UPDATE(Cars).set({ status : newStatus }).where({ ID : carID});

        return 'Status changed';

    });
    


    this.before('CREATE','Cars.drafts', async(req)=> {
        console.log('Draft Created:', req.data);
    });

    this.before('UPDATE','Cars.drafts', (req) =>{
        console.log('Draft Update:', req.data);
    });

})