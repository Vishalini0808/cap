sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"manufacturersapp/test/integration/pages/ManufacturersList",
	"manufacturersapp/test/integration/pages/ManufacturersObjectPage"
], function (JourneyRunner, ManufacturersList, ManufacturersObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('manufacturersapp') + '/test/flp.html#app-preview',
        pages: {
			onTheManufacturersList: ManufacturersList,
			onTheManufacturersObjectPage: ManufacturersObjectPage
        },
        async: true
    });

    return runner;
});

