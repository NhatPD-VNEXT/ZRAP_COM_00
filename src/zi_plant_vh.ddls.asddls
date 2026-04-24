@AbapCatalog: {
sqlViewName: 'ZIPLANT',
compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'プラント検索ヘルプ'
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
typeName: 'プラント検索ヘルプ',
typeNamePlural: 'プラント検索ヘルプ'
}
@ObjectModel.representativeKey: 'Plant'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP

define view ZI_Plant_VH
  as select from I_Plant as Plant

  association [1..*] to I_PlantPurchasingOrganization as _PlantPurchasingOrganization on $projection.Plant = _PlantPurchasingOrganization.Plant

  //association [0..*] to I_MaterialPlant as _MaterialPlant
  //    on $projection.Plant = _MaterialPlant.Plant

  //association [0..*] to I_MaterialText as _MaterialText
  //   on $projection.Material = _MaterialText.Material

{

      @ObjectModel.text.element:  [ 'PlantName' ]
      @Search: { defaultSearchElement: true, ranking: #HIGH }
  key Plant.Plant                                                                     as Plant,

      @ObjectModel.text.element:  [ 'PurchasingOrganizationName' ]
      @ObjectModel.foreignKey.association: '_PurchasingOrganization'
      @Search: { defaultSearchElement: true, ranking: #MEDIUM }
//      @EndUserText.quickInfo: 'Purchasing Organization'
//      @EndUserText.label: 'Purchasing Organization'
  key _PlantPurchasingOrganization.PurchasingOrganization                             as PurchasingOrganization,

      //@Search: { defaultSearchElement: true, ranking: #MEDIUM }
      //@ObjectModel.foreignKey.association: '_MaterialPlant'
      //@ObjectModel.text.association: '_MaterialText'
      //key _MaterialPlant.Material as Material,
      //_MaterialPlant,
      //  _MaterialText,

      @Semantics.text: true
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      Plant.PlantName                                                                 as PlantName,

     // @Semantics.text: true
      @Search: { defaultSearchElement: true, ranking: #MEDIUM }
//       @EndUserText.quickInfo: 'Purchasing Organization Name'
//       @EndUserText.label: 'Purchasing Organization Name'
      _PlantPurchasingOrganization._PurchasingOrganization.PurchasingOrganizationName as PurchasingOrganizationName,

//      @Search: { defaultSearchElement: true, ranking: #LOW }
//      _Address.CityName,

//      @Search: { defaultSearchElement: true, ranking: #LOW }
//      _Address.PostalCode,

      _PlantPurchasingOrganization,

      _PlantPurchasingOrganization._PurchasingOrganization                            as _PurchasingOrganization

}
