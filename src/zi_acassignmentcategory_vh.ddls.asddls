@AbapCatalog: {
   sqlViewName:            'ZIACASGCATEGORY',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '勘定設定カテゴリ検索ヘルプ'
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
  typeName:       '勘定設定カテゴリ検索ヘルプ',
  typeNamePlural: '勘定設定カテゴリ検索ヘルプ'
}
@ObjectModel.representativeKey: 'AccountAssignmentCategory'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP

define view ZI_AcAssignmentCategory_VH
  as select from I_AccountAssignmentCategory
{

//      @EndUserText.label: 'Account Assignment Category'
      @EndUserText.label: '勘定設定カテゴリ'
      @ObjectModel.text.element:  [ 'AcctAssignmentCategoryName' ]
  key AccountAssignmentCategory,

      @Semantics.text: true
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
//      @EndUserText.label: 'Account Assignment Category Description'
      @EndUserText.label: '勘定設定カテゴリテキスト'
      _Text[1: Language = $session.system_language].AcctAssignmentCategoryName as AcctAssignmentCategoryName

}
