@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VBFA+EKBE+MSEG+MKPF'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_SDDocPurchaseOrderHistoryMD
  as select from ZI_SDDocPurchaseOrderHistory as _SDDocPurchaseOrderHistory //VBFA+EKBE

  association [1..1] to I_MaterialDocumentItem_2 as _MaterialDocumentItem_2       //MSEG
  on  $projection.PurchasingHistoryDocument     = _MaterialDocumentItem_2.MaterialDocument
  and $projection.PurchasingHistoryDocumentYear = _MaterialDocumentItem_2.MaterialDocumentYear 
  and $projection.PurchasingHistoryDocumentItem = _MaterialDocumentItem_2.MaterialDocumentItem 

  association [1..1] to I_MaterialDocumentHeader_2 as _MaterialDocumentHeader_2   //MKPF
  on  $projection.PurchasingHistoryDocument     = _MaterialDocumentHeader_2.MaterialDocument
  and $projection.PurchasingHistoryDocumentYear = _MaterialDocumentHeader_2.MaterialDocumentYear 
  
{
    key _SDDocPurchaseOrderHistory.PurchaseOrder                 as PurchaseOrder,     //発注
    key _SDDocPurchaseOrderHistory.PurchaseOrderItem             as PurchaseOrderItem,    
    key _SDDocPurchaseOrderHistory.AccountAssignmentNumber       as AccountAssignmentNumber,
    key _SDDocPurchaseOrderHistory.PurchasingHistoryDocumentType as PurchasingHistoryDocumentType, //購買発注履歴取引タイプ
    key _SDDocPurchaseOrderHistory.PurchasingHistoryDocumentYear as PurchasingHistoryDocumentYear,
    key _SDDocPurchaseOrderHistory.PurchasingHistoryDocument     as PurchasingHistoryDocument,
    key _SDDocPurchaseOrderHistory.PurchasingHistoryDocumentItem as PurchasingHistoryDocumentItem, 
    _SDDocPurchaseOrderHistory.PrecedingDocument                  as PrecedingDocument, //受注
    _SDDocPurchaseOrderHistory.PrecedingDocumentItem              as PrecedingDocumentItem,   
    _SDDocPurchaseOrderHistory.SubsequentDocumentCategory         as SubsequentDocumentCategory, //継続伝票の伝票カテゴリ
    _SDDocPurchaseOrderHistory.SubsequentDocument                 as SubsequentDocument,
    _MaterialDocumentItem_2.MaterialDocument                      as MaterialDocument,
    _MaterialDocumentItem_2.MaterialDocumentYear                  as MaterialDocumentYear,    
    _MaterialDocumentItem_2.EntryUnit                             as EntryUnit,
    _MaterialDocumentHeader_2.MaterialDocumentHeaderText          as MaterialDocumentHeaderText

}
