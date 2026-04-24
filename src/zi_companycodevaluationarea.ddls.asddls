@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'T001K+T001 評価レベル会社コード'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_CompanyCodeValuationArea
  as select from I_ValuationArea as _ValuationArea //T001K
  association [1..1] to I_CompanyCode as _CompanyCode //T001
  on  $projection.CompanyCode  = _CompanyCode.CompanyCode
{
   key _ValuationArea.ValuationArea as ValuationArea,
   _ValuationArea.CompanyCode        as CompanyCode,
   _CompanyCode.AddressID            as AddressID,
   _CompanyCode.CompanyCodeName      as CompanyCodeName
}
