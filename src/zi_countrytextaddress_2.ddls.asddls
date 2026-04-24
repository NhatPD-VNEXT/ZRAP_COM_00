@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ADRC+T005T 得意先国名'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_CountryTextAddress_2
  as select from I_Address_2 as _Address_2 //ADRC
  association [1..*] to I_CountryText as _CountryText //T005T
  on  $projection.Country  = _CountryText.Country
{
   key _Address_2.AddressID,
   key _CountryText.Language,
   _Address_2.AddressRepresentationCode,
   _Address_2.Country,
   _CountryText.CountryShortName
   
}
