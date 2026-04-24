//************************************************************************
//*  [変更履歴]                                                          *
//*   バージョン情報 ：V1.00  2024/12/18  M.OKADA            XW2K900213  *
//*   変更内容       ：新規作成                                          *
//*----------------------------------------------------------------------*
//*   バージョン情報 ：V9.99  YYYY/MM/DD  変更者             移送番号    *
//*   変更内容       ：                                                  *
//************************************************************************
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SVF機能 ユーザ別プリンタ検索ヘルプ'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory:  #XS
@ObjectModel.dataCategory: #VALUE_HELP
@UI.presentationVariant: [{ sortOrder: [{ by: 'zzseqno', direction: #ASC }] }]
define view entity ZI_UserPrinter_VH 
  as select from ZI_UserPrinter_02
  association [1..1] to ZI_ZY200T as _PRINTMAST
  on  $projection.printer = _PRINTMAST.Printer
{
   @UI.hidden: true
   key zzseqno,
   @UI.lineItem: [ { position: 10, importance: #HIGH } ]
   @ObjectModel.text.element: [ 'printername' ]   
   key printer as printer,
   @UI.lineItem: [ { position: 20, importance: #HIGH } ]
   @Semantics.text: true
   _PRINTMAST.Printername as printername
}
