@AbapCatalog: {
   sqlViewName:            'ZISALESDOCRJCNRE',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '拒否理由検索ヘルプ'
@Search.searchable: true
@Consumption.ranked: true
@ObjectModel:{
  usageType:{
    serviceQuality: #C, 
    sizeCategory: #XL, 
    dataClass: #MASTER
  },
  resultSet.sizeCategory: #XS //リストボックス形式
}
@UI.headerInfo:{
  typeName:       '拒否理由検索ヘルプ',
  typeNamePlural: '拒否理由検索ヘルプ'
}
@ObjectModel.representativeKey: 'SalesDocumentRjcnReason'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP
define view ZI_SalesDocumentRjcnReason_VH as 
  select from I_SalesDocumentRjcnReasonText
{
  @ObjectModel.text.element:  [ 'SalesDocumentRjcnReasonName' ]
  @Search: {
    defaultSearchElement: true,
    ranking:              #HIGH,
    fuzzinessThreshold:   0.9
  }
  key SalesDocumentRjcnReason,

  @Semantics.text: true
  @Search: {
    defaultSearchElement: true,
    fuzzinessThreshold: 0.9,
    ranking:            #LOW 
  }
  SalesDocumentRjcnReasonName
}
where Language = $session.system_language
