@AbapCatalog: {
   sqlViewName:            'ZISALESORG',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '販売組織検索ヘルプ'
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
  typeName:       '販売組織検索ヘルプ',
  typeNamePlural: '販売組織検索ヘルプ'
}
@ObjectModel.representativeKey: 'SalesOrganization'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP

define view ZI_SalesOrganization_VH
   as select from I_SalesOrganization {
   
       @ObjectModel.text.association: '_Text'
       @Search:{
        defaultSearchElement: true,
        fuzzinessThreshold: 0.9,
        ranking: #HIGH
       }
   key SalesOrganization,
   
       _Text
  
}
