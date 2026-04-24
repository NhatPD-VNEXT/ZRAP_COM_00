@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LFA1+ADRC+TSAD3T 仕入先敬称'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_SupplierFormOfAddressText
  as select from ZI_SupplierAddress_2 as _SupplierAddress_2 //LFA1+ADRC
  association [1..1] to I_FormOfAddressText as _FormOfAddressText //TSAD3T
  on  $projection.FormOfAddress  = _FormOfAddressText.FormOfAddress

{
   key _SupplierAddress_2.Supplier,
   key _FormOfAddressText.Language,
   _SupplierAddress_2.AddressRepresentationCode,
   _SupplierAddress_2.FormOfAddress,
   _FormOfAddressText.FormOfAddressName
  
}
