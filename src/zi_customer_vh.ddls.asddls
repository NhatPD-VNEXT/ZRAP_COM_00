@AbapCatalog: {
   sqlViewName:            'ZICUSTOMER',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '得意先コード検索ヘルプ'
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
  typeName:       '得意先コード検索ヘルプ',
  typeNamePlural: '得意先コード検索ヘルプ'
}
@ObjectModel.representativeKey: 'Customer'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP
define view ZI_Customer_VH as 
  select from I_Customer as _CompanyCode
  association [1..1] to I_Address_2 as _AddressAG
  on  $projection.AddressID  = _AddressAG.AddressID
{
  @ObjectModel.text.element:  [ 'OrganizationName1' ]
  @Search: {
    defaultSearchElement: true,
    ranking:              #HIGH,
    fuzzinessThreshold:   0.9
  }
  key Customer,
  @UI.hidden: true
  _CompanyCode.AddressID as AddressID,

  @Semantics.text: true
  @Search: {
    defaultSearchElement: true,
    fuzzinessThreshold: 0.9,
    ranking:            #LOW 
  }
  _AddressAG.OrganizationName1
}
