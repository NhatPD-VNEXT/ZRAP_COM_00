@AbapCatalog: {
   sqlViewName:            'ZISALESDOCUMENT',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '販売伝票検索ヘルプ'
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
  typeName:       '販売伝票検索ヘルプ',
  typeNamePlural: '販売伝票検索ヘルプ'
}
@ObjectModel.representativeKey: 'SalesDocument'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP

define view ZI_SalesDocument_VH
 as select distinct from I_SalesDocument
{
  @Search: {
    defaultSearchElement: true,
    ranking:              #HIGH,
    fuzzinessThreshold:   0.9
  }
  key SalesDocument

}

