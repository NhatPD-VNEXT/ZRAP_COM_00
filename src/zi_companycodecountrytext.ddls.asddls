@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'T001+TVKO+ADRC+T005T　自社国名'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_CompanyCodeCountryText 
  as select from ZI_CompanyCodeAddress_2 as _CompanyCodeAddress_2 //T001+TVKO+ADRC
  association [1..*] to I_CountryText as _CountryText //T005T
  on $projection.Country = _CountryText.Country
{
   key _CompanyCodeAddress_2.CompanyCode,
   key _CompanyCodeAddress_2.SalesOrganization,
   key _CountryText.Language,
   _CompanyCodeAddress_2.AddressID,
   _CompanyCodeAddress_2.AddressRepresentationCode,
   _CompanyCodeAddress_2.Country,
   _CountryText.CountryShortName

}
