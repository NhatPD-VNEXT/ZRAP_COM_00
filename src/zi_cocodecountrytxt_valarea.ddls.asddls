@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'T001K+T001+ADRC+T005T'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_CoCodeCountryTxt_ValArea
  as select from ZI_CompanyCodeAddress_2_VArea as _CompanyCodeAddress_2 //T001K+T001+ADRC
  association [1..*] to I_CountryText as _CountryText //T005T
  on $projection.Country = _CountryText.Country
{
   key _CompanyCodeAddress_2.ValuationArea,
   key _CountryText.Language,
   _CompanyCodeAddress_2.CompanyCode,
   _CompanyCodeAddress_2.AddressID,
   _CompanyCodeAddress_2.AddressRepresentationCode,
   _CompanyCodeAddress_2.Country,
   _CountryText.CountryShortName

}
