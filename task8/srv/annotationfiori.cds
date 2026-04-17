// annotate servicename.entity with @(UI :{
//     HeaderInfo : {
//         $Type : 'UI.HeaderInfoType',
//         TypeName : 'Onliine Fasion Shop', //Heading
//         TypeNamePlural : 'Omline Fashion Shop',
//         Title : { Value : 'Online Fashion shop'}
//     },

//     SelectionField : [
//         fashionType_id
//         // fileds u want
//     ],

//     LineItem : [
//         {value : fashionType.section.name},
//         {value : fashionType.typename},
//         // if we want lable name name it here as label : value,
//         {value : itemname},
//         {value : brand},
//         {value : size},
//         {value : currency_code}
//     ],

//     Facets : [ {   //odject page
//         $Type : 'UI.CollectionFacet',
//         Label : 'Fashion Details',
//         Facets : [ {
//             $Type : 'UI.ReferenceFacet',
//             Target : '@UI.FileldGroup#ItemDetails',
//         }],
//     }
//     ],

//     FieldGroup #ItemDetails : { Data : [
//         { value : fashionType_id},
//         { value : fashionType}
//     ]}
// })