@AbapCatalog: {
   sqlViewName:            'ZIZY201THELP',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'フォームID検索ヘルプ'
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
  typeName:       'フォームID検索ヘルプ',
  typeNamePlural: 'フォームID検索ヘルプ'
}
@ObjectModel.representativeKey: 'formid'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP

define view ZI_ZY201T_VH
  as select distinct from zy201t
{
    @ObjectModel.text.element:  [ 'formname' ]
    @Search: {
      defaultSearchElement: true,
      ranking:              #HIGH,
      fuzzinessThreshold:   0.9
    }
    key formid,
    @Semantics.text: true
    @Search: {
      defaultSearchElement: true,
      fuzzinessThreshold: 0.9,
      ranking:            #LOW 
    }   
    formname
}
