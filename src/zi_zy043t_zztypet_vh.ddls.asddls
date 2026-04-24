@AbapCatalog: {
   sqlViewName:            'ZIZY043ZZTYPET',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '種別名称検索ヘルプ'
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
  typeName:       '種別名称検索ヘルプ',
  typeNamePlural: '種別名称検索ヘルプ'
}
@ObjectModel.representativeKey: 'zztype'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP

define view ZI_ZY043T_ZZTYPET_VH
  as select distinct from zy043t
{
    @ObjectModel.text.element:  [ 'zztypename' ]
    @Search: {
      defaultSearchElement: true,
      ranking:              #HIGH,
      fuzzinessThreshold:   0.9
    }
    key zztype,
    @Semantics.text: true
    @Search: {
      defaultSearchElement: true,
      fuzzinessThreshold: 0.9,
      ranking:            #LOW 
    }   
    key zztypename
}
