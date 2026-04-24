@AbapCatalog: {
   sqlViewName:            'ZIPURREQUISITION',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '購買依頼検索ヘルプ'
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
  typeName:       '購買依頼検索ヘルプ',
  typeNamePlural: '購買依頼検索ヘルプ'
}
@ObjectModel.representativeKey: 'PurchaseRequisition'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP
define view ZI_PurchaseRequisition_VH 
  as select distinct from I_PurchaseRequisitionItemAPI01
{
  @Search: {
    defaultSearchElement: true,
    ranking:              #HIGH,
    fuzzinessThreshold:   0.9
  }
  key PurchaseRequisition

}
