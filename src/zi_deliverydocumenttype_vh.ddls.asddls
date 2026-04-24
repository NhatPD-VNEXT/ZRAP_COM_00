@AbapCatalog: {
   sqlViewName:            'ZIDELIVERYDOCTY',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '出荷タイプ検索ヘルプ'
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
  typeName:       '出荷タイプ検索ヘルプ',
  typeNamePlural: '出荷タイプ検索ヘルプ'
}
@ObjectModel.representativeKey: 'DeliveryDocumentType'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP

define view ZI_DeliveryDocumentType_VH
   as select from I_DeliveryDocumentTypeText {
   
    @ObjectModel.text.element:  [ 'DeliveryDocumentTypeName' ]
    @Search: {
      defaultSearchElement: true,
      ranking:              #HIGH,
      fuzzinessThreshold:   0.9
    }
    key DeliveryDocumentType,
    @Semantics.text: true
    @Search: {
      defaultSearchElement: true,
      fuzzinessThreshold: 0.9,
      ranking:            #LOW 
    }   
    DeliveryDocumentTypeName
}
where Language = $session.system_language

