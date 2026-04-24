@AbapCatalog: {
sqlViewName: 'ZISTORAGELOC',
compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '保管場所検索ヘルプ'
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
typeName: '保管場所検索ヘルプ',
typeNamePlural: '保管場所検索ヘルプ'
}
@ObjectModel.representativeKey: 'StorageLocation'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP

define view ZI_StorageLocation_VH
  as select from I_StorageLocation as StorageLocation
{

      @ObjectModel.text.element:  [ 'StorageLocationName' ]
      @Search: { defaultSearchElement: true, ranking: #HIGH }
  key StorageLocation.StorageLocation     as StorageLocation,

      @ObjectModel.text.element:  [ 'PlantName' ]
      @Search: { defaultSearchElement: true, ranking: #MEDIUM }
      @ObjectModel.foreignKey.association: '_Plant'
  key StorageLocation.Plant               as Plant,

      @Semantics.text: true
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      StorageLocation.StorageLocationName as StorageLocationName,

      @Semantics.text: true
      @Search: { defaultSearchElement: true, ranking: #MEDIUM, fuzzinessThreshold: 0.7 }
      StorageLocation._Plant.PlantName    as PlantName,

      _Plant

} 
