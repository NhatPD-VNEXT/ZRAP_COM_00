@AbapCatalog: {
   sqlViewName:            'ZISALESDOCTYPE',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '販売伝票タイプ検索ヘルプ'
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
  typeName:       '販売伝票タイプ検索ヘルプ',
  typeNamePlural: '販売伝票タイプ検索ヘルプ'
}
@ObjectModel.representativeKey: 'SalesDocumentType'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP
define view ZI_SalesDocumentType_VH
  as select distinct from I_SalesDocumentType as SalesDocumentType

  association [0..*] to I_SalesDocumentTypeText as _Text on $projection.SalesDocumentType = _Text.SalesDocumentType 
  association [0..*] to I_SDDocumentCategoryText as _SDDocumentCategoryText on $projection.SDDocumentCategory = _SDDocumentCategoryText.SDDocumentCategory
{
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  @Search.ranking: #HIGH
  @ObjectModel.text.association: '_Text'
  key SalesDocumentType,
  

//  @Search.defaultSearchElement: true
//  @UI.hidden: true
//  cast(_Text[1: Language=$session.system_language].SalesDocumentTypeName as tvakt_bezei) as SalesDocumentTypeName,

  @Search.defaultSearchElement: true
  SDDocumentCategory,
  
//  @UI.hidden: true
//  cast(_SDDocumentCategoryText[1: Language=$session.system_language].SDDocumentCategoryName as bezei) as SDDocumentCategoryName,
  
  @Search.defaultSearchElement: true
  RetsMgmtIsActive,
  
  @UI.hidden: true
  SalesDocumentType._SalesDocumentTypeLangDepdnt[1:Language=$session.system_language].SalesDocumentTypeLangDepdnt,
  
  /*Associations*/
  _Text,
  _SDDocumentCategoryText
}
