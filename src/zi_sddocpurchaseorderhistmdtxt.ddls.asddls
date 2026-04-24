@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VBFA+EKBE+MSEG+MKPF+T006A'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_SDDocPurchaseOrderHistMDTxt
  as select from ZI_SDDocPurchaseOrderHistoryMD as _SDDocPurchaseOrderHistoryMD

  association [1..1] to I_UnitOfMeasureText as _UnitOfMeasureText //T006A（入力単位テキスト）
  on  $projection.EntryUnit       = _UnitOfMeasureText.UnitOfMeasure
  
{
    key _SDDocPurchaseOrderHistoryMD.PurchaseOrder                 as PurchaseOrder,
    key _SDDocPurchaseOrderHistoryMD.PurchaseOrderItem             as PurchaseOrderItem,    
    key _SDDocPurchaseOrderHistoryMD.AccountAssignmentNumber       as AccountAssignmentNumber,
    key _SDDocPurchaseOrderHistoryMD.PurchasingHistoryDocumentType as PurchasingHistoryDocumentType,
    key _SDDocPurchaseOrderHistoryMD.PurchasingHistoryDocumentYear as PurchasingHistoryDocumentYear,
    key _SDDocPurchaseOrderHistoryMD.PurchasingHistoryDocument     as PurchasingHistoryDocument,
    key _SDDocPurchaseOrderHistoryMD.PurchasingHistoryDocumentItem as PurchasingHistoryDocumentItem,
    key _UnitOfMeasureText.Language                                as Language,
    _SDDocPurchaseOrderHistoryMD.PrecedingDocument                  as PrecedingDocument,
    _SDDocPurchaseOrderHistoryMD.PrecedingDocumentItem              as PrecedingDocumentItem,
    _SDDocPurchaseOrderHistoryMD.SubsequentDocumentCategory         as SubsequentDocumentCategory,
    _SDDocPurchaseOrderHistoryMD.EntryUnit                          as EntryUnit,
    _UnitOfMeasureText.UnitOfMeasureName                            as UnitOfMeasureName
    
}
