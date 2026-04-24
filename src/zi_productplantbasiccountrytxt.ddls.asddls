@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MARC+T005T'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_ProductPlantBasicCountryTxt
  as select from I_ProductPlantBasic as _ProductPlantBasic //MARC
  association [1..*] to I_CountryText as _CountryText //T005T
  on  $projection.CountryOfOrigin  = _CountryText.Country

{
   key _ProductPlantBasic.Product       as Product,
   key _ProductPlantBasic.Plant         as Plant,
   key _CountryText.Language            as Language,
   _ProductPlantBasic.CountryOfOrigin    as CountryOfOrigin,
   _CountryText.CountryShortName         as CountryShortName
   
}
