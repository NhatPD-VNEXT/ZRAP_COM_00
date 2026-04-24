@AbapCatalog: {
   sqlViewName:            'ZIPURDOCDELCODE',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '削除フラグ検索ヘルプ'
@Search.searchable: true
@Consumption.ranked: true
@ObjectModel:{
  usageType:{
    serviceQuality: #C, 
    sizeCategory: #XL, 
    dataClass: #MASTER
  }
}
@UI.headerInfo:{
  typeName:       '削除フラグ検索ヘルプ',
  typeNamePlural: '削除フラグ検索ヘルプ'
}
@ObjectModel.representativeKey: 'PurchasingDocumentDeletionCode'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP

define view ZI_PurDocDeletionCode_VH 
  as select distinct from I_PurchaseOrderItemAPI01 {
  
    @Search: { defaultSearchElement: true, ranking: #HIGH }
    key PurchasingDocumentDeletionCode
  
  }where PurchasingDocumentDeletionCode <> ''
  
//as select from I_ProcurementDomainValues {
//
//  @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
//   key DomainValue, 
//   DomainText 
//}where
//     Name     = 'VDM_MM_DELIND'
//    and Language = $session.system_language


