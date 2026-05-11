using ShowroomService as service from '../../srv/showroom-service';
annotate service.Cars with @(

    UI.LineItem : [
        { Value : modelName, Label : 'Model Type'},
        { Value : price, Label : 'Price'},
        { Value : bodyType, Label : 'Body Type'},
        { Value : stock, Label : 'Stock'},
        { Value : status, Label : 'status'}
    ],

    UI.SelectionFields : [
        modelName,
        bodyType,
        status
    ],

    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'modelName',
                Value : modelName,
            },
            
            {
                $Type : 'UI.DataField',
                Label : 'price',
                Value : price,
            },
            {
                $Type : 'UI.DataField',
                Label : 'stock',
                Value : stock,
            },
            {
                $Type : 'UI.DataField',
                Label : 'status',
                Value : status,
            },
        ],
    },

    UI.FieldGroup #DetailedGroup : {
        Data : [
            {
                $Type: 'UI.DataField',
                Label : 'CarID',
                Value :  ID
            },
            {
                $Type: 'UI.DataField',
                Label : 'Fuel Type',
                Value : fuelType
            },
            {
                $Type: 'UI.DataField',
                Label : 'Body Type',
                Value : bodyType
            },
            {
                $Type : 'UI.DataField',
                Label : 'Mileage',
                Value : mileage
            },
            
        ] 
    },


    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'DetailedFacet1',
            Label : 'Detailed Info',
            Target : '@UI.FieldGroup#DetailedGroup'
        }
    ],
);



