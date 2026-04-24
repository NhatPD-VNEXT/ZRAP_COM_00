@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'EKBE+T001W+ADRC+ADR2+ADR3+ADR6 転送先用'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_PurchaseOrderHistoryPlantAD
  as select distinct from ZI_PurchaseOrderHistoryPlant as _PurchaseOrderHistoryPlant
  association [1..1] to I_Address_2 as _Address_2 //ADRC
  on  $projection.AddressID  = _Address_2.AddressID
  association [1..1] to I_AddressPhoneNumber_2 as _AddressPhoneNumber_2 //ADR2
  on  $projection.AddressID  = _AddressPhoneNumber_2.AddressID
  association [1..1] to I_AddressFaxNumber_2 as _AddressFaxNumber_2 //ADR3
  on  $projection.AddressID  = _AddressFaxNumber_2.AddressID
  association [1..1] to I_AddressEmailAddress_2 as _AddressEmailAddress_2 //ADR6
  on  $projection.AddressID  = _AddressEmailAddress_2.AddressID
 
{
   key _PurchaseOrderHistoryPlant.PurchaseOrder                  as PurchaseOrder,
   key _PurchaseOrderHistoryPlant.PurchaseOrderItem              as PurchaseOrderItem,
   key _PurchaseOrderHistoryPlant.AccountAssignmentNumber        as AccountAssignmentNumber,
   key _PurchaseOrderHistoryPlant.PurchasingHistoryDocumentType  as PurchasingHistoryDocumentType, 
   key _PurchaseOrderHistoryPlant.PurchasingHistoryDocumentYear  as PurchasingHistoryDocumentYear,  
   key _PurchaseOrderHistoryPlant.PurchasingHistoryDocument      as PurchasingHistoryDocument,
   key _PurchaseOrderHistoryPlant.PurchasingHistoryDocumentItem  as PurchasingHistoryDocumentItem,
   _PurchaseOrderHistoryPlant.Plant                               as Plant,
   _PurchaseOrderHistoryPlant.AddressID                           as AddressID,
   _Address_2.AddressRepresentationCode                           as AddressRepresentationCode,
   _Address_2.OrganizationName1                                   as OrganizationName1,
   _Address_2.OrganizationName2                                   as OrganizationName2,
   _Address_2.OrganizationName3                                   as OrganizationName3,
   _Address_2.OrganizationName4                                   as OrganizationName4,
   _Address_2.PostalCode                                          as PostalCode,
   _Address_2.StreetName                                          as StreetName,
   _Address_2.CityName                                            as CityName,
   _Address_2.DistrictName                                        as DistrictName,   
   _Address_2.StreetPrefixName1                                   as StreetPrefixName1,   
   _Address_2.StreetPrefixName2                                   as StreetPrefixName2,
   _Address_2.StreetSuffixName1                                   as StreetSuffixName1,
   _Address_2.Country                                             as Country,   
   _AddressPhoneNumber_2.PhoneAreaCodeSubscriberNumber            as PhoneAreaCodeSubscriberNumber,
   _AddressFaxNumber_2.FaxAreaCodeSubscriberNumber                as FaxAreaCodeSubscriberNumber,
   _AddressEmailAddress_2.EmailAddress                            as EmailAddress
     
}
