@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'T001K+T001+ADRC+ADR2+ADR3+ADR6'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_CompanyCodeAddress_2_VArea
  as select from ZI_CompanyCodeValuationArea as _CompanyCodeValuationArea //T001K+T001
  association [1..1] to I_Address_2 as _Address_2 //ADRC
  on  $projection.AddressID  = _Address_2.AddressID
  association [1..1] to I_AddressPhoneNumber_2 as _AddressPhoneNumber_2 
  on  $projection.AddressID  = _AddressPhoneNumber_2.AddressID
  association [1..1] to I_AddressFaxNumber_2 as _AddressFaxNumber_2 
  on  $projection.AddressID  = _AddressFaxNumber_2.AddressID
  association [1..1] to I_AddressEmailAddress_2 as _AddressEmailAddress_2 
  on  $projection.AddressID  = _AddressEmailAddress_2.AddressID

{
   key _CompanyCodeValuationArea.ValuationArea,
   _CompanyCodeValuationArea.CompanyCode,
   _CompanyCodeValuationArea.AddressID,
   _Address_2.AddressRepresentationCode,
   _Address_2.OrganizationName1,
   _Address_2.OrganizationName2,
   _Address_2.OrganizationName3,
   _Address_2.OrganizationName4,
   _Address_2.PostalCode,
   _Address_2.StreetName,
   _Address_2.CityName,
   _Address_2.DistrictName,   
   _Address_2.StreetPrefixName1,   
   _Address_2.StreetPrefixName2,
   _Address_2.StreetSuffixName1,
   _Address_2.Country,   
   _AddressPhoneNumber_2.PhoneAreaCodeSubscriberNumber,
   _AddressFaxNumber_2.FaxAreaCodeSubscriberNumber,
   _AddressEmailAddress_2.EmailAddress
   
}
