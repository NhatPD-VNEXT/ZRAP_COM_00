@AbapCatalog: {
   sqlViewName:            'ZICOSTCENTER',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '原価センタ検索ヘルプ'
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
  typeName:       '原価センタ検索ヘルプ',
  typeNamePlural: '原価センタ検索ヘルプ'
}
@ObjectModel.representativeKey: 'CostCenter'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP

define view ZI_CostCenter_VH
  as select from I_CostCenter as CostCenter
  association[0..*] to I_CostCenterText           as _Text    on  $projection.ControllingArea    = _Text.ControllingArea and
                                                                  $projection.CostCenter         = _Text.CostCenter and
                                                                  $projection.ValidityEndDate    = _Text.ValidityEndDate
{
       @ObjectModel.text.association: '_Text'
       @Search: { defaultSearchElement: true, ranking: #HIGH }
  key  CostCenter.CostCenter                                                   as CostCenter,

       @UI.hidden: true
  key  CostCenter.ControllingArea                                              as ControllingArea,

       @Search: { defaultSearchElement: true, ranking: #HIGH }
       @Semantics.businessDate.to: true
       @Consumption.filter.multipleSelections: false
       @Consumption.filter.selectionType: #INTERVAL
  key  CostCenter.ValidityEndDate                                              as ValidityEndDate,

//       @Consumption.valueHelpDefinition: [{ entity: { name : 'ZI_CostCenter_VH', element : 'CompanyCode' } }]
       @Search: { defaultSearchElement: true, ranking: #LOW, fuzzinessThreshold: 0.8 }
       CostCenter.CompanyCode                                                  as CompanyCode,
//
       @Search: { defaultSearchElement: true, ranking: #LOW, fuzzinessThreshold: 0.8 }
       CostCenter.CostCtrResponsiblePersonName                                 as CostCtrResponsiblePersonName,

       @Search: { defaultSearchElement: true, ranking: #LOW, fuzzinessThreshold: 0.8 }
       @Semantics.businessDate.from: true
       @Consumption.filter.multipleSelections: false
       @Consumption.filter.selectionType: #INTERVAL
       CostCenter.ValidityStartDate                                            as ValidityStartDate,

 // associations
       _Text
}
