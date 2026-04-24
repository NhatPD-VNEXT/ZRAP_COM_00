//************************************************************************
//*  [変更履歴]                                                          *
//*   バージョン情報 ：V1.00  2024/12/06  M.SHIOMI           NWFK900043  *
//*   変更内容       ：新規作成                                          *
//*----------------------------------------------------------------------*
//*   バージョン情報 ：V1.01  2024/12/06  M.SHIOMI           NWFK900043  *
//*   変更内容       ：ATCチェック対応のため                             *
//*----------------------------------------------------------------------*
//*   バージョン情報 ：V9.99  YYYY/MM/DD  変更者             移送番号    *
//*   変更内容       ：                                                  *
//************************************************************************
@AbapCatalog: {
sqlViewName: 'ZIPURDOCTYPE',
compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '購買依頼伝票タイプ検索ヘルプ'
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
typeName: '購買依頼伝票タイプ検索ヘルプ',
typeNamePlural: '購買依頼伝票タイプ検索ヘルプ'
}
@ObjectModel.representativeKey: 'PurchasingDocumentType'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP

define view ZI_PurchaseRequisitionType_VH 
  as select from I_PurchasingDocumentTypeText
//*-< DEL V1.01 (S) >-*
//  association        to parent I_PurchasingDocumentType as _PurchasingDocumentType     on  $projection.PurchasingDocumentCategory = _PurchasingDocumentType.PurchasingDocumentCategory
//                                                                                       and $projection.PurchasingDocumentType     = _PurchasingDocumentType.PurchasingDocumentType
//*-< DEL V1.01 (E) >-*
  association [1..1] to I_PurchasingDocumentCategory    as _PurchasingDocumentCategory on  $projection.PurchasingDocumentCategory = _PurchasingDocumentCategory.PurchasingDocumentCategory

  association [0..1] to I_Language                      as _Language                   on  $projection.Language = _Language.Language


{
      @ObjectModel.foreignKey.association: '_PurchasingDocumentType'
      @ObjectModel.text.element: ['PurchasingDocumentTypeName']
  key PurchasingDocumentType as PurchasingDocumentType,
      @ObjectModel.foreignKey.association: '_PurchasingDocumentCategory'
  key PurchasingDocumentCategory as PurchasingDocumentCategory,
      @ObjectModel.foreignKey.association: '_Language'
      @Semantics.language: true
      @UI.hidden: true
  key Language as Language,

      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      @Semantics.text: true
//      @EndUserText.label: '購買伝票タイプテキスト'
      PurchasingDocumentTypeName as PurchasingDocumentTypeName,

      _PurchasingDocumentType,
      _PurchasingDocumentCategory,
      _Language

}where Language = $session.system_language 
 and PurchasingDocumentCategory = 'B'
 
