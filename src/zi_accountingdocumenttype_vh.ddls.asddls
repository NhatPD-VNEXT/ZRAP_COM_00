@AbapCatalog: {
   sqlViewName:            'ZIACCOUNTDOCTY',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '仕訳タイプ検索ヘルプ'
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
  typeName:       '仕訳タイプ検索ヘルプ',
  typeNamePlural: '仕訳タイプ検索ヘルプ'
}
@ObjectModel.representativeKey: 'AccountingDocumentType'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP

define view ZI_AccountingDocumentType_VH
   as select from I_AccountingDocumentTypeText {
   
    @ObjectModel.text.element:  [ 'AccountingDocumentTypeName' ]
    @Search: {
      defaultSearchElement: true,
      ranking:              #HIGH,
      fuzzinessThreshold:   0.9
    }
    key AccountingDocumentType,
    @Semantics.text: true
    @Search: {
      defaultSearchElement: true,
      fuzzinessThreshold: 0.9,
      ranking:            #LOW 
    }   
    AccountingDocumentTypeName
}
where Language = $session.system_language

