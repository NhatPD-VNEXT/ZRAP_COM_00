@AbapCatalog: {
   sqlViewName:            'ZIDELIVERYDOC',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '出荷伝票検索ヘルプ'
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
  typeName:       '出荷伝票検索ヘルプ',
  typeNamePlural: '出荷伝票検索ヘルプ'
}
@ObjectModel.representativeKey: 'DeliveryDocument'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP
define view ZI_DeliveryDocument_VH
 as select distinct from I_DeliveryDocument
{
  @Search: {
    defaultSearchElement: true,
    ranking:              #HIGH,
    fuzzinessThreshold:   0.9
  }
  key DeliveryDocument

}


