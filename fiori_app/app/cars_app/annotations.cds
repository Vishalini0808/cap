using ShowroomService as service from '../../srv/car-service';
annotate service.Cars with @(


    UI.SelectionFields : [
        stock,
        bodyType,
        fuelType,
        status,
        manufacturer_ID
    ],

      UI.LineItem : [
         {
            $Type : 'UI.DataField',
            // Label : 'Product Image',
            Value : imageUrl,
            @HTML5.CssDefaults:{width:'150px'}
        },
        {
            $Type : 'UI.DataFieldWithUrl',
            Value : modelName,
            Url : imageUrl,
            @HTML5.CssDefaults:{width:'150px'}

        },
        {
            $Type : 'UI.DataField',
            Value : bodyType,
            @HTML5.CssDefaults:{width:'150px'}
        },
        {
            $Type : 'UI.DataField',
            Value : manufacturer.name,
            @HTML5.CssDefaults:{width:'150px'}
        },
        {
            $Type : 'UI.DataField',
            Value  : stock,
            Criticality : stockCritically,
            @HTML5.CssDefaults:{width:'100px'}
        },
        {
            $Type : 'UI.DataField',
            Value : price,
            @HTML5.CssDefaults:{width:'150px'}
        },
        {
            $Type : 'UI.DataField',
            Value : status,
            Criticality : criticality,
            @HTML5.CssDefaults:{width:'150px'}
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'ShowroomService.markAsSold',
            Label : 'Change Status',
            Inline : true,
            @HTML5.CssDefaults:{width:'150px'}
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'ShowroomService.EntityContainer/createSale',
            Label : 'Create Sale'
        }
    ],

    UI.HeaderInfo : {
        TypeName : 'Car',
        TypeNamePlural : 'Cars' ,
        Title  :{
            Value : modelName
        },
        Description : {
            Value : ''
        },
        ImageUrl: imageUrl
    },

    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Label : 'Change Status',
            Action : 'ShowroomService.markAsSold'
        },
        // { Value : to}
    ],

    // UI.HeaderFacets : [
    //     {
    //         $Type : 'UI.ReferenceFacet',
    //         ID :  'headerFacet',
    //         Label : 'Header Info',
    //         Target : '@'
    //     }
    // ],

    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : ID
            },
            {
                $Type : 'UI.DataField',
                Value : status
            },
            {
                $Type : 'UI.DataFieldWithUrl',
                Value : modelName,
                Url : imageUrl
            },
            {
                $Type : 'UI.DataField',
                Value : price,
            },
            {
                $Type : 'UI.DataField',
                Value : stock,
            },
            
        ]
    },

    UI.FieldGroup #SpecificationGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                // Label : 'Body Type',
                Value : bodyType
            },
            {
                $Type : 'UI.DataField',
                // Label : 'Fuel Type',
                Value : fuelType
            },
            {
                $Type : 'UI.DataField',
                // Label : 'Mileage',
                Value : mileage
            },
            {
                $Type : 'UI.DataField',
                // Label : 'Manufacturer',
                Value : manufacturer_ID,
            },
            // {
            //     $Type : 'UI.DataField',
            //     Label : 'Image URL',
            //     Value : imageUrl
            // },
        ]
    },

    UI.FieldGroup #manufacturersdetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Manufacturer ID',
                Value : manufacturer.ID
            },
            {
                $Type : 'UI.DataFieldWithNavigationPath',
                Label : 'Manufacturer Name',
                Value : manufacturer.name,
                Target : 'manufacturer'
            },
            {
                $Type : 'UI.DataField',
                Label : 'Founded Year',
                Value : manufacturer.foundedYear
            },
            {
                $Type : 'UI.DataField',
                Label : 'Country',
                Value : manufacturer.country
            },
        ]
    },


    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Car Details',

            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    ID : 'GeneratedFacet1',
                    Label : 'General Information',
                    Target : '@UI.FieldGroup#GeneratedGroup',
                },
                {
                   $Type : 'UI.ReferenceFacet',
                   ID : 'SpecificationFacet1',
                   Label : 'Specifications',
                   Target : '@UI.FieldGroup#SpecificationGroup'
                }
            ]
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'ManufacturerFacet1',
            Label : 'Manufacturer Details',
            Target : '@UI.FieldGroup#manufacturersdetails'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Sales Info',
            Target : 'sales/@UI.LineItem'
        }
    ],

// pagination
    UI.PresentationVariant : {
        SortOrder : [
            { Property : manufacturer_ID},
            { Property : bodyType},
            { Property : price}
        ],
        MaxItems : 4,
        Visualizations : [ '@UI.LineItem']
    }
);


// status dropdown
annotate service.Cars with {
    status @Common.ValueList : {
        CollectionPath  : 'Cars',
        Parameters : [
         {
            $Type : 'Common.ValueListParameterInOut',
            LocalDataProperty : status,
            ValueListProperty : 'status'
         }
        ]
    };
    status @Common.ValueListWithFixedValues : true;
    status @Common.ValueListShowValuesImmediately:true
}

annotate service.Cars with {
    modelName   @title: '{@i18n>modelName}';
    price       @title: '{@i18n>price}';
    stock       @title: '{@i18n>stock}';
    status      @title: '{@i18n>status}';
    bodyType    @title: '{@i18n>bodyType}';
    fuelType    @title: '{@i18n>fuelType}';
    mileage     @title: '{@i18n>mileage}';
    imageUrl    @title: '{@i18n>imageUrl}';
    criticality @title: '{@i18n>criticality}';
};


// bodytype dropdown
annotate service.Cars with {
    bodyType @Common.ValueList : {
        CollectionPath : 'Cars',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterOut',
                LocalDataProperty : bodyType,
                ValueListProperty : 'bodyType'
            }
        ]
    }
    @Common.ValueListWithFixedValues : true
};


// fueltype dropdown
annotate service.Cars with {
    fuelType @Common.ValueList : {
        CollectionPath : 'Cars',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : fuelType,
                ValueListProperty : 'fuelType'
            }
        ]
    };
    fuelType @Common.ValueListWithFixedValues : true
}


// work aagala
// annotate service.Cars with {
//     fuelType @Common.ValueListWithFixedValues : true;
// }


// imageUrl:- because URL cannot be given to create 
annotate service.Cars with{
    imageUrl @UI.IsImageURL : true;
} ;


// dialog for confirmation
annotate service.Cars with actions {
    markAsSold @(
        Common.IsActionCritical : true
    );
}

//currency
annotate service.Cars with{
    price @Measures.ISOCurrency : 'INR';
} ;
 

// auto refresh
annotate service.Cars with actions {
    markAsSold @Common.SideEffects : {
        // TargetEntities : ['Cars']
        TargetProperties : ['status', 'criticality']
    }
};


annotate service.Cars with {
    manufacturer_ID @Common.ValueList : {
        $Type : 'Common.ValueListType',
        Label : 'Manufacturer',
        CollectionPath : 'Manufacturers',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : manufacturer_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'country',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'foundedYear',
            },
        ],
    }
};


// manufacturer Popover
annotate service.Cars with {
    manufacturer @Common.SemanticObject : 'Manufacturer'
};


annotate service.Manufacturers with  @(

    UI.QuickViewFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Manufacturer Info',
            Target : '@UI.FieldGroup#quickView'
        }
    ],

    UI.FieldGroup #quickView : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : name
            },
            {
                $Type : 'UI.DataField',
                Value : country
            },
            {
                $Type : 'UI.DataField',
                Value : foundedYear
            }
        ]
    }
);




// manufacture entity
annotate service.Manufacturers with @(

     UI.HeaderInfo : {
        TypeName : 'Manufacturer',
        TypeNamePlural : 'Manufacturers',
        Title : { Value : ID},
        Description : { Value : name}
    },

    UI.LineItem : [
        {
                $Type : 'UI.DataField',
                // Label : 'Manufacturer ID',
                Value : ID
            },
            {
                $Type : 'UI.DataField',
                // Label : 'Name',
                Value : name
            },
            {
                $Type : 'UI.DataField',
                // Label : 'Country',
                Value : country
            },
             {
                $Type : 'UI.DataField',
                // Label : 'Founded year',
                Value : foundedYear
            }
    ],

    UI.FieldGroup #general : {

        $Type : 'UI.FieldGroupType',
        Data : [
            { 
                $Type : 'UI.DataField',
                // Label : 'Manufacturer ID',
                Value : ID
            },
            { 
                $Type : 'UI.DataField',
                // Label : 'Name',
                Value : name
            },
            { 
                $Type : 'UI.DataField',
                // Label : 'Country',
                Value : country
            },
            { 
                $Type : 'UI.DataField',
                // Label : 'Founded Year',
                Value : foundedYear
            }
        ]
    },

    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'General Info',
            Target : '@UI.FieldGroup#general'
        }
    ]
);

// i18n properties - Manufacturers
annotate service.Manufacturers with {
    ID          @title: '{@i18n>manufacturerId}';
    name        @title: '{@i18n>manufacturerName}';
    country     @title: '{@i18n>country}';
    foundedYear @title: '{@i18n>foundedYear}';
    manufacturerUrl @title: '{@i18n>manufacturerUrl}';
};


// sales entity
annotate service.Sales with @(

    UI.HeaderInfo : {
        TypeName : 'Sale',
        TypeNamePlural : 'Sales',
        Title : { Value : ID},
        Description : { Value : saleDate}
    },

    UI.LineItem : [
         {
                $Type : 'UI.DataField',
                // Label : 'Sales ID',
                Value : ID,
                @HTML5.CssDefaults:{width:'200px'}
            },
            {
                $Type : 'UI.DataField',
                // Label : 'Sales Date',
                Value : saleDate,
                @HTML5.CssDefaults:{width:'100px'}
            },
            {
                $Type : 'UI.DataField',
                // Label : 'Quantity',
                Value : quantity,
                @HTML5.CssDefaults:{width:'100px'}
            },
            {
                $Type : 'UI.DataField',
                // Label : 'Total',
                Value : total,
                @HTML5.CssDefaults:{width:'100px'}
            },
            {
                $Type : 'UI.DataField',
                Label : 'Status',
                Value : status,
                @HTML5.CssDefaults:{width:'100px'}
            },
            {
                $Type : 'UI.DataField',
                Label : 'Customer Name',
                Value : customer.name,
                @HTML5.CssDefaults:{width:'100px'}
            },
            {
            $Type : 'UI.DataFieldForAction',
            Label : 'Cancel Order',
            Action : 'ShowroomService.cancelOrder',
            ![Importance] : #high,
            Inline : true,
            ![@UI.Hidden] : {
                $edmJson : {
                    $Eq : [
                        { $Path : 'status'},
                        'cancelled'
                    ]
                }
            }
        }
    ],

    UI.FieldGroup #SaleDetails : {
        Label : 'Sales Details',
        Data : [
            { 
                $Type : 'UI.DataField',
                // Label : 'Sale Date',
                Value : saleDate
            },
            { 
                $Type : 'UI.DataField',
                // Label : 'Quantity',
                Value : quantity
            },
            { 
                $Type : 'UI.DataField',
                // Label : 'Total',
                Value : total
            }
        ]
    },

    UI.FieldGroup #customerdetails : {
         Label : 'Sales Details',
         Data : [
            { 
                $Type : 'UI.DataField',
                Label : 'Customer Name',
                Value : customer.name
            },
            { 
                $Type : 'UI.DataField',
                Label : 'Customer City',
                Value : customer.city
            },
            { 
                $Type : 'UI.DataField',
                Label : 'Customer Email',
                Value : customer.email,
                
            },
         ]
    },

    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Sale Details',
            Target : '@UI.FieldGroup#SaleDetails'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Customer Details',
            Target : '@UI.FieldGroup#customerdetails'
        }
    ]
);

annotate service.Sales with @(
    Capabilities.DeleteRestrictions : {
        Deletable : true
    }
);


// action confirmation dialog
annotate service.Sales with actions {
    cancelOrder @(
        Common.IsActionCritical  : true
    )
}

annotate service.Sales with {
    ID       @title: '{@i18n>saleId}';
    saleDate @title: '{@i18n>saleDate}';
    quantity @title: '{@i18n>quantity}';
    total    @title: '{@i18n>total}' ;
};


// not working
// "createMode": "creationRow", 