using CatalogService as service from '../../srv/Catalogservice';

annotate CatalogService.PurchaseOrder with @(
    Common.DefaultValuesFunction : 'getOrderDefaults',
    UI.SelectionFields:[
        PO_ID,
        GROSS_AMOUNT,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY
    ],
    UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.BP_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        
        {
            $Type : 'UI.DataField',
            Value : OVERALL_STATUS,
            Criticality: Criticality,
            CriticalityRepresentation : #WithIcon,
        },{
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.boost',
            Label : 'Boost',
            Inline: true
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        }
    ] ,
    UI.HeaderInfo:{
        TypeName : 'PO',
        TypeNamePlural: 'POs',
        Title : {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        Description: {
            $Type : 'UI.DataField',
            Value : LIFECYCLE_STATUS,
        },
        ImageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/IBM_logo.svg/2560px-IBM_logo.svg.png'
    },
    UI.Facets:[
        {
            $Type : 'UI.CollectionFacet',
            Label : 'PO Details',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'More Info',
                    Target : '@UI.FieldGroup#MoreInfo',
                },{
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Pricing Details',
                    Target : '@UI.FieldGroup#Spiderman',
                },{
                    $Type : 'UI.ReferenceFacet',
                    Label : 'PO Line Items',
                    Target : 'Items/@UI.LineItem',
        }
            ],
        },
    ],
    UI.FieldGroup #MoreInfo: {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PO_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID_NODE_KEY,
            },
            {
                $Type : 'UI.DataField',
                Value : OVERALL_STATUS,
            }
        ],
    },
    UI.FieldGroup #Spiderman:{
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },{
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },{
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },
        ],
    },
    UI.Identification:[{
        $Type         : 'UI.DataFieldForAction',
        Label         : 'Set to Delivered',
        Action        : 'CatalogService.setOrderProcessing'
    }]         
);

annotate CatalogService.PurchaseOrder with {
    PARTNER_GUID@(
        Common : { 
            Text : PARTNER_GUID.COMPANY_NAME,
         },
         ValueList.entity: CatalogService.BusinessPartnerSet
    )
};
annotate CatalogService.PurchaseOrderItems with {
    PRODUCT_GUID@(
        Common : { 
            Text : PRODUCT_GUID.DESCRIPTION,
         },
         ValueList.entity: CatalogService.ProductSet
    )
};
@cds.odata.valuelist
annotate CatalogService.BusinessPartnerSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : COMPANY_NAME,
    }]
);
@cds.odata.valuelist
annotate CatalogService.ProductSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : DESCRIPTION,
    }]
);


annotate CatalogService.PurchaseOrderItems with @(
    UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },{
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        },{
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },{
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },{
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT,
        },{
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        }
    ],
    UI.HeaderInfo:{
        TypeName : 'Item',
        TypeNamePlural : 'Items',
        Title : {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        }
    },
    UI.Facets:[
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Item Details',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Item Data',
                    Target : '@UI.FieldGroup#ItemData',
                },{
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Product Data',
                    Target : '@UI.FieldGroup#ProductData',
                }
            ],
        },
    ],
    UI.FieldGroup #ItemData:{
        Label : 'Item Data',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID_NODE_KEY,
            },{
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },{
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },{
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },{
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },
        ],
    },
    UI.FieldGroup #ProductData:{
        Label: 'Product Details',
        Data: [
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.PRODUCT_ID,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.DESCRIPTION,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.PRICE,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.CURRENCY_CODE,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.CATEGORY,
            }
        ]
    }
);

