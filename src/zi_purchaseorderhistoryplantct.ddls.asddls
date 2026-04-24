@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'T001W+ADRC+T005T 転送先国名'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_PurchaseOrderHistoryPlantCT
  as select from ZI_PurchaseOrderHistoryPlantAD as _PurchaseOrderHistoryPlantAD //EKBE+T001W+ADRC
  association [1..*] to I_CountryText as _CountryText //T005T
  on $projection.Country = _CountryText.Country
{
    key _PurchaseOrderHistoryPlantAD.PurchaseOrder                  as PurchaseOrder,
    key _PurchaseOrderHistoryPlantAD.PurchaseOrderItem              as PurchaseOrderItem,
    key _PurchaseOrderHistoryPlantAD.AccountAssignmentNumber        as AccountAssignmentNumber,
    key _PurchaseOrderHistoryPlantAD.PurchasingHistoryDocumentType  as PurchasingHistoryDocumentType,    
    key _PurchaseOrderHistoryPlantAD.PurchasingHistoryDocumentYear  as PurchasingHistoryDocumentYear,
    key _PurchaseOrderHistoryPlantAD.PurchasingHistoryDocument      as PurchasingHistoryDocument,
    key _PurchaseOrderHistoryPlantAD.PurchasingHistoryDocumentItem  as PurchasingHistoryDocumentItem,    
    key _CountryText.Language                                       as Language,   
    _PurchaseOrderHistoryPlantAD.Plant                               as Plant,
    _PurchaseOrderHistoryPlantAD.AddressID                           as AddressID,
    _PurchaseOrderHistoryPlantAD.AddressRepresentationCode           as AddressRepresentationCode,
    _PurchaseOrderHistoryPlantAD.Country                             as Country,
    _CountryText.CountryShortName                                    as CountryShortName

}
