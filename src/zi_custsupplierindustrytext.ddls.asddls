@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '得意先/サプライヤ産業検索ヘルプ'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_CustSupplierIndustryText 
  as select from I_Customer as _Customer
  association [1..*] to I_CustomerSupplierIndustryText as _SupplierIndustryText //T016T
  on  $projection.Industry  = _SupplierIndustryText.Industry
{
   key _Customer.Customer,
   key _SupplierIndustryText.Language,
   _Customer.Industry,
   _SupplierIndustryText.CustomerSupplierIndustryName  
}
