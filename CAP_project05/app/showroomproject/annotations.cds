using CarShowroomService as service from '../../srv/showroom-service';
using from '../UI-annotations';

annotate service.CarModels with {
    manufacturer @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
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
                    ValueListProperty : 'location',
                },
            ],
        },
        Common.Label : '{i18n>Manufacturerid}',
    )
};

annotate service.CarModels with @(
    UI.HeaderInfo : {
        TypeName : 'Car Model',
        TypeNamePlural : 'Car Models',
        Title : {
            $Type : 'UI.DataField',
            Value : name,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : createdAt,
        },
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>Overview}',
            ID : 'i18nOverview',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>GeneralInformation}',
                    ID : 'GeneralInformation',
                    Target : '@UI.Identification',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>Details}',
                    ID : 'i18nDetails',
                    Target : '@UI.FieldGroup#i18nDetails',
                },
            ],
        },
    ],
    UI.FieldGroup #i18nStock : {
        $Type : 'UI.FieldGroupType',
        Data : [
        ],
    },
    UI.FieldGroup #Details : {
        $Type : 'UI.FieldGroupType',
        Data : [
        ],
    },
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : '{i18n>Id}',
        },
        {
            $Type : 'UI.DataField',
            Value : name,
            Label : '{i18n>Name}',
        },
        {
            $Type : 'UI.DataField',
            Value : stock,
            Label : '{i18n>Stock}',
        },
        {
            $Type : 'UI.DataField',
            Value : manufacturer_ID,
            Label : '{i18n>Manufacturerid}',
        },
        {
            $Type : 'UI.DataField',
            Value : baseprice,
            Label : '{i18n>Price}',
        },
    ],
    UI.SelectionFields : [
        name,
        manufacturer_ID,
    ],
    UI.FieldGroup #i18nDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
        ],
    },
    UI.Identification : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : '{i18n>Id}',
        },
        {
            $Type : 'UI.DataField',
            Value : baseprice,
        },
        {
            $Type : 'UI.DataField',
            Value : oldprice,
            Label : '{i18n>Oldprice}',
        },
        {
            $Type : 'UI.DataField',
            Value : stock,
            Label : '{i18n>Stock}',
        },
        {
            $Type : 'UI.DataField',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Value : manufacturer_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : createdBy,
        },
        {
            $Type : 'UI.DataField',
            Value : createdAt,
        },
    ],
);

annotate service.CarModels with {
    name @Common.Label : '{i18n>Name}'
};

annotate service.CarModels with {
    baseprice @Common.Label : '{i18n>Price}'
};

annotate service.CarModels with {
    ID @(
        Common.Text : name,
        Common.Text.@UI.TextArrangement : #TextOnly,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'CarModels',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
            ],
            Label : 'ID',
        },
        Common.ValueListWithFixedValues : false,
    )
};

