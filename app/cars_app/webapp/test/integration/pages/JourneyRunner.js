sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"carsapp/test/integration/pages/CarsList",
	"carsapp/test/integration/pages/CarsObjectPage"
], function (JourneyRunner, CarsList, CarsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('carsapp') + '/test/flp.html#app-preview',
        pages: {
			onTheCarsList: CarsList,
			onTheCarsObjectPage: CarsObjectPage
        },
        async: true
    });

    return runner;
});

