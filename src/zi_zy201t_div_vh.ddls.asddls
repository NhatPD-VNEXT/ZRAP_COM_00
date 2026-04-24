@AbapCatalog: {
   sqlViewName:            'ZIZY201TDIVHELP',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '区分検索ヘルプ'
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
  typeName:       '区分検索ヘルプ',
  typeNamePlural: '区分検索ヘルプ'
}
@ObjectModel.representativeKey: 'div'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP

define view ZI_ZY201T_DIV_VH
  as select distinct from zy201t
{
    @Search: {
      defaultSearchElement: true,
      ranking:              #HIGH,
      fuzzinessThreshold:   0.9
    }
    key div
}
