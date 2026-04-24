@AbapCatalog: {
   sqlViewName:            'ZIPRODUCTGROUP',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '品目グループ検索ヘルプ'
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
  typeName:       '品目グループ検索ヘルプ',
  typeNamePlural: '品目グループ検索ヘルプ'
}
@ObjectModel.representativeKey: 'ProductGroup'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP

define view ZI_ProductGroup_VH
  as select from I_ProductGroup_2 as ProductGroup
//  association [0..*] to I_ProductGroupText_2 as _Text on $projection.ProductGroup = _Text.ProductGroup
//                                                      and Language = $session.system_language
  association [1..1] to I_ProductGroupText_2 as _Text 
    on  $projection.ProductGroup = _Text.ProductGroup
    and _Text.Language = $session.system_language

{
//      @EndUserText.label: 'Product Group'
//      @EndUserText.label: '品目グループ'
      @ObjectModel.text.element:  [ 'ProductGroupName' ]
      @Search: { defaultSearchElement: true, ranking: #HIGH }
  key ProductGroup.ProductGroup,

//      @EndUserText.label: 'Product Group Text'
//      @EndUserText.label: '品目グループテキスト'
      @Search: { defaultSearchElement: true, ranking: #LOW, fuzzinessThreshold: 0.7 }
      _Text.ProductGroupText,

//      @EndUserText.label: 'Product Group Description'
//      @EndUserText.label: '品目グループテキスト'
      @Semantics.text: true
      @Search: { defaultSearchElement: true, ranking: #LOW, fuzzinessThreshold: 0.7 }
      _Text[1: Language = $session.system_language].ProductGroupName as ProductGroupName

//      ProductAuthorizationGroup // 3120323

}
