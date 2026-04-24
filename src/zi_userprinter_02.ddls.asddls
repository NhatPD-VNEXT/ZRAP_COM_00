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
@EndUserText.label: 'SVF機能 ユーザ別プリンタ検索CDS(重複削除)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory:  #XS
@ObjectModel.dataCategory: #VALUE_HELP
define view entity ZI_UserPrinter_02 
  as select distinct
  from ZI_UserPrinter_01
  association [1..1] to ZI_ZY200T as _PRINTMAST
  on  $projection.printer = _PRINTMAST.Printer
  association [1..1] to zy204t as _SEQNO
  on  $projection.printer = _SEQNO.printer
  and _SEQNO.user_id = $session.user
{
   @UI.lineItem: [ { position: 10, importance: #HIGH } ]
   @ObjectModel.text.element: [ 'printername' ]   
   key printer as printer,
   @UI.lineItem: [ { position: 20, importance: #HIGH } ]
   @Semantics.text: true
   _PRINTMAST.Printername as printername,
   case
     when _SEQNO.zzseqno is null
       or  _SEQNO.zzseqno = '0000'
       then cast( '9999' as zzseqno_04 preserving type ) 
       else _SEQNO.zzseqno
   end as zzseqno
}
