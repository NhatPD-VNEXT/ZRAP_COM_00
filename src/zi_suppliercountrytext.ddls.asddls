@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LFA1+ADRC+T005T　仕入先国名'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_SupplierCountryText 
  as select from ZI_SupplierAddress_2 as _SupplierAddress_2 //LFA1+ADRC
  association [1..*] to I_CountryText as _CountryText //T005T
  on $projection.Country = _CountryText.Country
{
   key _SupplierAddress_2.Supplier,
   key _CountryText.Language,
   _SupplierAddress_2.AddressID,
   _SupplierAddress_2.AddressRepresentationCode,
   _SupplierAddress_2.Country,
   _CountryText.CountryShortName

}
