sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"project1/test/integration/pages/CarsList",
	"project1/test/integration/pages/CarsObjectPage"
], function (JourneyRunner, CarsList, CarsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('project1') + '/test/flp.html#app-preview',
        pages: {
			onTheCarsList: CarsList,
			onTheCarsObjectPage: CarsObjectPage
        },
        async: true
    });

    return runner;
});

