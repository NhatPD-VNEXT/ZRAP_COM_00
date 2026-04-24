@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VBFA+EKBE+LIKP'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_SDDocPurchaseOrderHistory
  as select from I_SDDocumentMultiLevelProcFlow as _SDDocumentMultiLevelProcFlow   //VBFA
  association [1..1] to I_PurchaseOrderHistoryAPI01 as _PurchaseOrderHistoryAPI01  //EKBE
  on  $projection.SubsequentDocument  = _PurchaseOrderHistoryAPI01.PurchaseOrder 
  association [1..1] to I_DeliveryDocument     as _DeliveryDocument //LIKP
  on  $projection.PrecedingDocument = _DeliveryDocument.DeliveryDocument 
  
{
    key _PurchaseOrderHistoryAPI01.PurchaseOrder                 as PurchaseOrder,     //発注
    key _PurchaseOrderHistoryAPI01.PurchaseOrderItem             as PurchaseOrderItem,
    key _PurchaseOrderHistoryAPI01.AccountAssignmentNumber       as AccountAssignmentNumber,
    key _PurchaseOrderHistoryAPI01.PurchasingHistoryDocumentType as PurchasingHistoryDocumentType, //購買発注履歴取引タイプ
    key _PurchaseOrderHistoryAPI01.PurchasingHistoryDocumentYear as PurchasingHistoryDocumentYear,
    key _PurchaseOrderHistoryAPI01.PurchasingHistoryDocument     as PurchasingHistoryDocument,
    key _PurchaseOrderHistoryAPI01.PurchasingHistoryDocumentItem as PurchasingHistoryDocumentItem, 
    _SDDocumentMultiLevelProcFlow.PrecedingDocument               as PrecedingDocument, //受注
    _SDDocumentMultiLevelProcFlow.PrecedingDocumentItem           as PrecedingDocumentItem,   
    _SDDocumentMultiLevelProcFlow.SubsequentDocumentCategory      as SubsequentDocumentCategory, //継続伝票の伝票カテゴリ
    _SDDocumentMultiLevelProcFlow.SubsequentDocument              as SubsequentDocument,       //請求
    _SDDocumentMultiLevelProcFlow.SubsequentDocumentItem          as SubsequentDocumentItem,
    _SDDocumentMultiLevelProcFlow.PrecedingDocumentCategory       as PrecedingDocumentCategory, //先行 SD 伝票の伝票カテゴリ
    _DeliveryDocument.DeliveryDocument                            as DeliveryDocument,   //出荷
    _DeliveryDocument.DeliveryDocumentBySupplier                  as DeliveryDocumentBySupplier,
    _DeliveryDocument.PlannedGoodsIssueDate                       as PlannedGoodsIssueDate
    
}
