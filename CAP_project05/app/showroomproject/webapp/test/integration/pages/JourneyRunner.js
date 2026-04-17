sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/showroomproject/test/integration/pages/CarModelsList",
	"ns/showroomproject/test/integration/pages/CarModelsObjectPage"
], function (JourneyRunner, CarModelsList, CarModelsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/showroomproject') + '/test/flp.html#app-preview',
        pages: {
			onTheCarModelsList: CarModelsList,
			onTheCarModelsObjectPage: CarModelsObjectPage
        },
        async: true
    });

    return runner;
});

