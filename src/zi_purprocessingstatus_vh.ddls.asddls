@AbapCatalog: {
   sqlViewName:            'ZIPURPROCSTATUS',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '処理状況検索ヘルプ'
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
  typeName:       '処理状況検索ヘルプ',
  typeNamePlural: '処理状況検索ヘルプ'
}
@ObjectModel.representativeKey: 'PurchasingProcessingStatus'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP

define view ZI_PurProcessingStatus_VH 
  as select distinct from I_PurchaseOrderAPI01

{
  @Search: { defaultSearchElement: true, ranking: #HIGH }
  key PurchasingProcessingStatus

}
