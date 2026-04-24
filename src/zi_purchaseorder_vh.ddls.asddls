@AbapCatalog: {
   sqlViewName:            'ZIPURCHASEORDER',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '購買発注検索ヘルプ'
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
  typeName:       '購買発注検索ヘルプ',
  typeNamePlural: '購買発注検索ヘルプ'
}
@ObjectModel.representativeKey: 'PurchaseOrder'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP
define view ZI_PurchaseOrder_VH 
  as select distinct from I_PurchaseOrderAPI01
{
  @Search: {
    defaultSearchElement: true,
    ranking:              #HIGH,
    fuzzinessThreshold:   0.9
  }
  key PurchaseOrder

}

