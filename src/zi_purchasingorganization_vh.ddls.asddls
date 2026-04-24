@AbapCatalog: {
   sqlViewName:            'ZIPURCHASINGORG',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '購買組織検索ヘルプ'
@Search.searchable: true
@Consumption.ranked: true
@ObjectModel:{
  usageType:{
    serviceQuality: #C, 
    sizeCategory: #XL, 
    dataClass: #MASTER
  }
}
@UI.headerInfo:{
  typeName:       '購買組織検索ヘルプ',
  typeNamePlural: '購買組織検索ヘルプ'
}
@ObjectModel.representativeKey: 'PurchasingOrganization'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP

define view ZI_PurchasingOrganization_VH
  as select from I_PurchasingOrganization as PurchasingOrganization

  //association [0..*] to I_SupplierPurchasingOrg as _SupplierPurchasingOrg
  //    on $projection.PurchasingOrganization = _SupplierPurchasingOrg.PurchasingOrganization

  association [0..1] to I_CompanyCode as _CompanyCode on $projection.CompanyCode = _CompanyCode.CompanyCode

{

      @ObjectModel.text.element:  [ 'PurchasingOrganizationName' ]
      @Search: { defaultSearchElement:true, ranking: #HIGH, fuzzinessThreshold: 0.8 }
      @EndUserText.quickInfo: 'Purchasing Organization'
  key PurchasingOrganization.PurchasingOrganization     as PurchasingOrganization,

      //  Purchasing Organization is denormalized by supplier
      //    @Search: { defaultSearchElement: true, ranking: #MEDIUM }
      //    key _SupplierPurchasingOrg.Supplier as Supplier,

      @Semantics.text: true
//      @EndUserText.label: 'Purchasing Organization Name'
      @Search: { defaultSearchElement: true, ranking: #LOW, fuzzinessThreshold: 0.7  }
      @EndUserText.quickInfo: 'Purchasing Organization Name'
      PurchasingOrganization.PurchasingOrganizationName as PurchasingOrganizationName,

      @ObjectModel.foreignKey.association: '_CompanyCode'
      @ObjectModel.text.element:  [ 'CompanyCodeName' ]
      @Search: { defaultSearchElement:true, ranking: #LOW, fuzzinessThreshold: 0.7  }
      @EndUserText.quickInfo: 'Company Code'
      PurchasingOrganization.CompanyCode                as CompanyCode,
      _CompanyCode,

      @Semantics.text: true
      @Search: { defaultSearchElement: true, ranking: #LOW, fuzzinessThreshold: 0.7  }
      _CompanyCode.CompanyCodeName                      as CompanyCodeName,
      
      PurchasingOrganization.ConfigDeprecationCode      as ConfigDeprecationCode
      
} where
  ConfigDeprecationCode <> 'E'
