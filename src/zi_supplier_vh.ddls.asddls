@AbapCatalog: {
sqlViewName: 'ZISUPPLIER',
compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'サプライヤ検索ヘルプ'
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
typeName: 'サプライヤ検索ヘルプ',
typeNamePlural: 'サプライヤ検索ヘルプ'
}
@ObjectModel.representativeKey: 'Supplier'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP

define view ZI_Supplier_VH
  as select from I_SupplierPurchasingOrg as _SupplierPurchasingOrg
  
  association [0..1] to I_PurchasingOrganization as _PurchasingOrgValueHelp               
    on  _PurchasingOrgValueHelp.PurchasingOrganization = $projection.PurchasingOrganization  

  {
  
      //--[ GENERATED:012:GFBfhxvv7kY4ijgX00lwx0
      @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_Supplier',
                     element: 'Supplier' }
        }]
      // ]--GENERATED
      @ObjectModel.text.element:  [ 'SupplierName' ]
      @Search: { defaultSearchElement: true, ranking: #HIGH }
//      @UI.lineItem: { position: 10, importance: #HIGH }
  key Supplier,
  
//      @ObjectModel.mandatory: true
//      @UI.lineItem: { position: 20, importance: #HIGH }  
      @Consumption.valueHelpDefinition: [{ entity : { name: 'I_PurchasingOrganization', element: 'PurchasingOrganization' } }]
  key PurchasingOrganization                                                    as PurchasingOrganization,
      
//      @UI.lineItem: { position: 30, importance: #HIGH }
      @Semantics.text: true
      _Supplier.SupplierName  as SupplierName,
      
//      @UI.lineItem: { position: 40, importance: #HIGH }
//      _Supplier._StandardAddress.Country                                        as Country,
      
//      @UI.lineItem: { position: 50, importance: #HIGH }
//      _Supplier._StandardAddress.CityName                                       as CityName,

//      @UI.lineItem: { position: 60, importance: #HIGH }
//      _Supplier._StandardAddress.PostalCode                                     as PostalCode,

//      @UI.lineItem: { position: 70, importance: #HIGH }
//      _Supplier._StandardAddress.Region                                         as Region,

      @UI.hidden: true
      @Search: { defaultSearchElement: true, ranking: #LOW, fuzzinessThreshold: 0.7 }
      _Supplier._SupplierToBusinessPartner._BusinessPartner.FirstName           as FirstName,

      @Search: { defaultSearchElement: true, ranking: #LOW, fuzzinessThreshold: 0.7 }
      _Supplier._SupplierToBusinessPartner._BusinessPartner.LastName            as LastName,

      @Search: { defaultSearchElement: true, ranking: #LOW, fuzzinessThreshold: 0.7 }
      _Supplier._SupplierToBusinessPartner._BusinessPartner.OrganizationBPName1 as OrganizationBPName1,

      @Search: { defaultSearchElement: true, ranking: #LOW, fuzzinessThreshold: 0.7 }
      _Supplier._SupplierToBusinessPartner._BusinessPartner.OrganizationBPName2 as OrganizationBPName2,

      @Search: { defaultSearchElement: true, ranking: #LOW, fuzzinessThreshold: 0.7 }
      _Supplier._SupplierToBusinessPartner._BusinessPartner.OrganizationBPName3 as OrganizationBPName3,

      @Search: { defaultSearchElement: true, ranking: #LOW, fuzzinessThreshold: 0.7 }
      _Supplier._SupplierToBusinessPartner._BusinessPartner.OrganizationBPName4 as OrganizationBPName4,
      
      @Consumption.hidden: true
      AuthorizationGroup,
      
      /*Associations*/
      @Consumption.hidden: true
      _Supplier,
      _PurchasingOrgValueHelp
           
  } 
