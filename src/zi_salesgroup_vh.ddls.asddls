@AbapCatalog: {
   sqlViewName:            'ZISALESGROUP',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '営業グループ検索ヘルプ'
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
  typeName:       '営業グループ検索ヘルプ',
  typeNamePlural: '営業グループ検索ヘルプ'
}
@ObjectModel.representativeKey: 'SalesGroup'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP
define view ZI_SalesGroup_VH
  as select from I_SalesOfficeSalesGroup as SalesAreaSalesGroup
  
  association [0..*] to I_SalesGroupText as _Text on $projection.SalesGroup = _Text.SalesGroup
{   
    @Search: {
     defaultSearchElement: true,
     ranking: #LOW }
    @UI: {
     lineItem: [{ position: 30, importance: #HIGH }],
     selectionField: [{ position: 30 }]
    }
    @UI.hidden: true
    key SalesAreaSalesGroup.SalesOffice,
    
    @ObjectModel.text.element: ['SalesGroupName']
    @Search: {
     defaultSearchElement: true,
     ranking: #HIGH,
     fuzzinessThreshold: 0.9 
    }
    @UI: {
     lineItem: [{ position: 10, importance: #HIGH }],
     selectionField: [{ position: 10 }]
    }
    key SalesAreaSalesGroup.SalesGroup,
    
    @Semantics.text: true
    @Search: {
     defaultSearchElement: true,
     ranking: #LOW,
     fuzzinessThreshold: 0.8 
    }
    @UI: {
     lineItem: [{ position: 20, importance: #HIGH }],
     selectionField: [{ position: 20 }]
    }
    SalesAreaSalesGroup._SalesGroup._Text[1:Language=$session.system_language].SalesGroupName,
    
//  Will be removed after DC2208    
    _Text     
}   
