@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'EKBE+EKPO+T001L'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_PurchaseOrderHistorySTRLoc
  as select from ZI_PurchaseOrderHistoryPlant as _PurchaseOrderHistoryPlant //EKBE
  association [1..1] to I_StorageLocation as _StorageLocation //T001L
  on  $projection.Plant            = _StorageLocation.Plant
  and $projection.StorageLocation  = _StorageLocation.StorageLocation  
  
{
   key _PurchaseOrderHistoryPlant.PurchaseOrder                  as PurchaseOrder,
   key _PurchaseOrderHistoryPlant.PurchaseOrderItem              as PurchaseOrderItem,
   key _PurchaseOrderHistoryPlant.AccountAssignmentNumber        as AccountAssignmentNumber,
   key _PurchaseOrderHistoryPlant.PurchasingHistoryDocumentType  as PurchasingHistoryDocumentType,
   key _PurchaseOrderHistoryPlant.PurchasingHistoryDocumentYear  as PurchasingHistoryDocumentYear,
   key _PurchaseOrderHistoryPlant.PurchasingHistoryDocument      as PurchasingHistoryDocument,
   key _PurchaseOrderHistoryPlant.PurchasingHistoryDocumentItem  as PurchasingHistoryDocumentItem,
   _PurchaseOrderHistoryPlant.Plant                               as Plant,
   _PurchaseOrderHistoryPlant.StorageLocation                     as StorageLocation,
   _StorageLocation.StorageLocationName                           as StorageLocationName
   
   
}
