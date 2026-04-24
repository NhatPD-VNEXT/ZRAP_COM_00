@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'EKBE+T001W'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_PurchaseOrderHistoryPlant
  as select from I_PurchaseOrderItemAPI01 as _PurchaseOrderItemAPI01 //EKPO
  association [1..1] to I_Plant as _Plant //T001W
  on  $projection.Plant  = _Plant.Plant
  association [1..1] to I_PurchaseOrderHistoryAPI01 as _PurchaseOrderHistoryAPI01 //EKBE
  on  $projection.PurchaseOrder_EKPO      = _PurchaseOrderHistoryAPI01.PurchaseOrder
  and $projection.PurchaseOrderItem_EKPO  = _PurchaseOrderHistoryAPI01.PurchaseOrderItem  
  
{
   key _PurchaseOrderHistoryAPI01.PurchaseOrder                  as PurchaseOrder,
   key _PurchaseOrderHistoryAPI01.PurchaseOrderItem              as PurchaseOrderItem,
   key _PurchaseOrderHistoryAPI01.AccountAssignmentNumber        as AccountAssignmentNumber,
   key _PurchaseOrderHistoryAPI01.PurchasingHistoryDocumentType  as PurchasingHistoryDocumentType,
   key _PurchaseOrderHistoryAPI01.PurchasingHistoryDocumentYear  as PurchasingHistoryDocumentYear,
   key _PurchaseOrderHistoryAPI01.PurchasingHistoryDocument      as PurchasingHistoryDocument,
   key _PurchaseOrderHistoryAPI01.PurchasingHistoryDocumentItem  as PurchasingHistoryDocumentItem,    
   _PurchaseOrderItemAPI01.PurchaseOrder                          as PurchaseOrder_EKPO, //association考慮
   _PurchaseOrderItemAPI01.PurchaseOrderItem                      as PurchaseOrderItem_EKPO,
   _PurchaseOrderItemAPI01.Plant                                  as Plant,
   _PurchaseOrderItemAPI01.StorageLocation                        as StorageLocation,
   _Plant.AddressID                                               as AddressID
   
}
