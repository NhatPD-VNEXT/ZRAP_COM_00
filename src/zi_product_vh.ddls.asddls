@AbapCatalog: {
   sqlViewName:            'ZIPRODUCT',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '品目検索ヘルプ'
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
  typeName:       '品目検索ヘルプ',
  typeNamePlural: '品目検索ヘルプ'
}
@ObjectModel.representativeKey: 'Product'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP
define view ZI_Product_VH
  as select from I_Product
  association [0..*] to I_ProductDescription as _Text            on $projection.Product = _Text.Product
  association [0..1] to I_Producttype        as _ProductType     on $projection.ProductType = _ProductType.ProductType
  association [0..1] to I_ProductGroup_2     as _ProductGroup    on $projection.ProductGroup = _ProductGroup.ProductGroup
  association [0..1] to I_UnitOfMeasure      as _BaseUnit        on $projection.BaseUnit = _BaseUnit.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure      as _WeightUnit      on $projection.WeightUnit = _WeightUnit.UnitOfMeasure
  association [0..*] to I_ProductPlantBasic  as _ProductPlant    on $projection.Product = _ProductPlant.Plant
//  association [0..1] to E_Product            as _ProductExt      on $projection.Product = _ProductExt.Product
//  association [0..1] to I_Productcategoryvh  as _ProductCategory on $projection.ArticleCategory = _ProductCategory.ProductCategory
  association [0..1] to I_ProductCategory  as _ProductCategory_2 on $projection.ArticleCategory = _ProductCategory_2.ProductCategory
{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
      @ObjectModel.text.association: '_Text'
  key Product        as Product,
      _Text,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
//      @EndUserText.label: 'External Product ID'
      ProductExternalID,
      @UI.hidden: true
      IndustrySector as IndustrySector,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Search.ranking: #LOW
      ProductType,
      _ProductType,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Search.ranking: #LOW
      ProductGroup,
      _ProductGroup,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_BaseUnit'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Search.ranking: #LOW
      BaseUnit,
      _BaseUnit,

      @Semantics.quantity.unitOfMeasure: 'WeightUnit'
      @DefaultAggregation: #NONE
      @UI.hidden: true
      GrossWeight,

      @Semantics.quantity.unitOfMeasure: 'WeightUnit'
      @DefaultAggregation: #NONE
      @UI.hidden: true
      NetWeight,

      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_WeightUnit'
      @UI.hidden: true
      WeightUnit,
      _WeightUnit,
      @UI.hidden: true
      ManufacturerNumber,
      @Consumption.hidden: true
      AuthorizationGroup,
      IsBatchManagementRequired,
      @UI.hidden: true
      ProductManufacturerNumber,
      @ObjectModel.foreignKey.association: '_ProductCategory_2'
      ArticleCategory,

      @Consumption.filter.hidden: true
//      _ProductCategory,
      _ProductPlant,
      _ProductCategory_2

}
where
  IsMarkedForDeletion = ''
