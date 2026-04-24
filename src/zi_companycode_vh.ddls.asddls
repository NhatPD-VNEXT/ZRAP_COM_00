@AbapCatalog: {
   sqlViewName:            'ZICOMPANYCODE',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '会社コード検索ヘルプ'
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
  typeName:       '会社コード検索ヘルプ',
  typeNamePlural: '会社コード検索ヘルプ'
}
@ObjectModel.representativeKey: 'CompanyCode'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP
define view ZI_CompanyCode_VH
  as select from I_CompanyCode as CompanyCode

  //association [0..1] to I_SupplierCompany as _SupplierCompany
  //    on $projection.Supplier = _SupplierCompany.Supplier
  //   and $projection.CompanyCode = _SupplierCompany.CompanyCode

{

      @ObjectModel.text.element:  [ 'CompanyCodeName' ]
      @Search: { defaultSearchElement: true, ranking: #HIGH }
  key CompanyCode.CompanyCode     as CompanyCode,

      //  is denormalized by supplier
      //    @Search: { defaultSearchElement: true, ranking: #MEDIUM }
      //    key _SupplierCompany.Supplier as Supplier,
      //    _SupplierCompany,

      @Semantics.text: true
      @Search: { defaultSearchElement: true, ranking: #LOW, fuzzinessThreshold: 0.8 }
      CompanyCode.CompanyCodeName as CompanyCodeName

}
