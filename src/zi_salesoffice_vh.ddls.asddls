@AbapCatalog: {
   sqlViewName:            'ZISALESOFFICE',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '営業所検索ヘルプ'
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
  typeName:       '営業所検索ヘルプ',
  typeNamePlural: '営業所検索ヘルプ'
}
@ObjectModel.representativeKey: 'SalesOffice'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP
define view ZI_SalesOffice_VH
  as select from I_SalesAreaSalesOffice as SalesAreaSalesOffice
  
  association [0..*] to I_SalesOfficeText  as _Text on $projection.SalesOffice = _Text.SalesOffice
{   
    @Search: {
      defaultSearchElement: true,
      ranking: #LOW }
    @UI: {
      lineItem: [{ position: 30, importance: #HIGH }],
      selectionField:[{ position: 30 }]
    }
    @UI.hidden: true
    key SalesAreaSalesOffice.SalesOrganization,
    
    @Search: {
      defaultSearchElement: true,
      ranking: #LOW }
    @UI: {
      lineItem: [{ position: 40, importance: #HIGH }],
      selectionField:[{ position: 40 }]
    }
    @UI.hidden: true
    key SalesAreaSalesOffice.DistributionChannel,
    
    @Search: {
      defaultSearchElement: true,
      ranking: #LOW }
    @UI: {
      lineItem: [{ position: 50, importance: #HIGH }],
      selectionField:[{ position: 50 }]
    }
    @UI.hidden: true
    key SalesAreaSalesOffice.OrganizationDivision,
    
    @ObjectModel.text.element: ['SalesOfficeName']
    @Search: {
      defaultSearchElement: true,
      ranking: #HIGH,
      fuzzinessThreshold: 0.9  }
    @UI: {
      lineItem: [{ position: 10, importance: #HIGH }],
      selectionField:[{ position: 10 }]
    }
    key SalesAreaSalesOffice.SalesOffice,
    
    @Semantics.text: true
    @Search: {
     defaultSearchElement: true,
     ranking: #LOW,
     fuzzinessThreshold: 0.8 }
    @UI: {
      lineItem: [{ position: 20, importance: #HIGH }],
      selectionField:[{ position: 20 }]
    }
    SalesAreaSalesOffice._SalesOffice._Text[1:Language=$session.system_language].SalesOfficeName,
    
//  Will be removed after DC2208    
    _Text  
}   
