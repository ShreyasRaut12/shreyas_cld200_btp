using { shreyas.db } from '../db/database';
using { shreyas.cds } from '../db/CDSViews';
service CatalogService @(path : 'CatalogServ', requires: 'authenticated-user') {
    entity BusinessPartnerSet as projection on db.master.businesspartner;
    entity AddressSet as projection on db.master.address;
     entity EmployeeSet @(restrict: [ 
                        { grant: ['READ'], to: 'mycapapp_Viewer', where: 'bankName = $user.BankName' },
                        { grant: ['WRITE'], to: 'mycapapp_Admin' }
                        ]) as projection on db.master.employees;
   // entity PurchaseOrder as projection on db.transaction.purchaseorder;
   entity PurchaseOrderItems as projection on db.transaction.poitems;
   //entity PurchaseOrderSet as projection on cds.CDSViews.POWorklist;
   entity PurchaseOrder@(
        odata.draft.enabled: true
    ) as projection on db.transaction.purchaseorder{
        *,
        case OVERALL_STATUS
            when 'N' then 'New'
            when 'P' then 'Paid'
            when 'B' then 'Blocked'
            else 'Delivered' end as OVERALL_STATUS: String(20),
        case OVERALL_STATUS
            when 'N' then 0
            when 'P' then 1
            when 'B' then 2
            else 3 end as Criticality: Integer
    }
    actions{
        @cds.odata.bindingparameter.name : '_anubhav'
        @Common.SideEffects : {
                TargetProperties : ['_anubhav/GROSS_AMOUNT']
            }
          
        action boost() returns PurchaseOrder;
        @cds.odata.bindingparameter.name : '_ananya'
        @Common.SideEffects : {
                TargetProperties : ['_ananya/OVERALL_STATUS']
            }  
        action setOrderProcessing();
        function largestOrder() returns array of PurchaseOrder;
    };
    // actions{
    //     action boost();
    //     function largestOrder() returns array of PurchaseOrder;
    // };
     function getOrderDefaults() returns PurchaseOrder;
     entity ProductSet as projection on db.master.product; 
   //entity ItemView as projection on cds.CDSViews.ItemView;
    //entity ProductView as projection on cds.CDSViews.ProductView;
     //entity ProductSales as projection on cds.CDSViews.CProductValuesView;

}