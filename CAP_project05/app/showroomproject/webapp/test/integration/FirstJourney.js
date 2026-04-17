sap.ui.define([
    "sap/ui/test/opaQunit",
    "./pages/JourneyRunner"
], function (opaTest, runner) {
    "use strict";

    function journey() {
        QUnit.module("First journey");

        opaTest("Start application", function (Given, When, Then) {
            Given.iStartMyApp();

            Then.onTheCarModelsList.iSeeThisPage();
            Then.onTheCarModelsList.onTable().iCheckColumns(4, {"name":{"header":"Car Model"},"stock":{"header":"Stock"},"baseprice":{"header":"Base Price"},"manufacturer/name":{"header":"Manufacturer"}});

        });


        opaTest("Navigate to ObjectPage", function (Given, When, Then) {
            // Note: this test will fail if the ListReport page doesn't show any data
            
            When.onTheCarModelsList.onFilterBar().iExecuteSearch();
            
            Then.onTheCarModelsList.onTable().iCheckRows();

            When.onTheCarModelsList.onTable().iPressRow(0);
            Then.onTheCarModelsObjectPage.iSeeThisPage();

        });

        opaTest("Teardown", function (Given, When, Then) { 
            // Cleanup
            Given.iTearDownMyApp();
        });
    }

    runner.run([journey]);
});