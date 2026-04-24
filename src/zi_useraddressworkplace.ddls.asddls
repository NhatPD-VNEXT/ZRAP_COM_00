@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'USR21+ADRC+ADR2+ADR3+ADR6'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_UserAddressWorkplace 
  as select from I_User as _User //USR21

  association [1..1] to I_Address_2 as _Address_2 //ADRC
  on  $projection.AddressID  = _Address_2.AddressID
  
  association [1..1] to I_AddressPhoneNumber_2 as _AddressPhoneNumber_2 //ADR2
  on  $projection.AddressID  = _AddressPhoneNumber_2.AddressID
  and _AddressPhoneNumber_2.AddressPersonID = $projection.AddressPersonID
  and _AddressPhoneNumber_2.CommMediumSequenceNumber = '001'
  
  association [1..1] to I_AddressFaxNumber_2 as _AddressFaxNumber_2 //ADR3
  on  $projection.AddressID  = _AddressFaxNumber_2.AddressID
  and _AddressFaxNumber_2.AddressPersonID = $projection.AddressPersonID
  and _AddressFaxNumber_2.CommMediumSequenceNumber = '001'  
  
  association [1..1] to I_AddressEmailAddress_2 as _AddressEmailAddress_2 //ADR6
  on  $projection.AddressID  = _AddressEmailAddress_2.AddressID
  and _AddressEmailAddress_2.AddressPersonID = $projection.AddressPersonID
  and _AddressEmailAddress_2.CommMediumSequenceNumber = '001'
    
{
   key cast(_User.UserID as zzuserid preserving type ) as UserID,
   _User.AddressID                                        as AddressID,
   _User.AddressPersonID                                  as AddressPersonID,
   _Address_2.AddressRepresentationCode                   as AddressRepresentationCode,
   _Address_2.OrganizationName1                           as OrganizationName1,
   _Address_2.OrganizationName2                           as OrganizationName2,
   _Address_2.OrganizationName3                           as OrganizationName3,
   _Address_2.OrganizationName4                           as OrganizationName4,
   _Address_2.PostalCode                                  as PostalCode,
   _Address_2.StreetName                                  as StreetName,
   _Address_2.CityName                                    as CityName,
   _Address_2.DistrictName                                as DistrictName,   
   _Address_2.StreetPrefixName1                           as StreetPrefixName1,   
   _Address_2.StreetPrefixName2                           as StreetPrefixName2,
   _Address_2.StreetSuffixName1                           as StreetSuffixName1,
   _Address_2.Country                                     as Country,
   _AddressPhoneNumber_2.PhoneAreaCodeSubscriberNumber    as PhoneAreaCodeSubscriberNumber,
   _AddressFaxNumber_2.FaxAreaCodeSubscriberNumber        as FaxAreaCodeSubscriberNumber,
   _AddressEmailAddress_2.EmailAddress                    as EmailAddress
      
}
where IsTechnicalUser = ''
