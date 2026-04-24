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
@EndUserText.label: 'SVF機能 ユーザ別プリンタ検索CDS(結合)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory:  #XS
@ObjectModel.dataCategory: #VALUE_HELP
@UI.presentationVariant: [{ sortOrder: [{ by: 'zzseqno', direction: #DESC }] }]
define view entity ZI_UserPrinter_01 
  as select from zy204t
  association [1..1] to ZI_ZY200T as _PRINTMAST
  on  $projection.printer = _PRINTMAST.Printer
{
   @UI.lineItem: [ { position: 10, importance: #HIGH } ]
   @ObjectModel.text.element: [ 'printername' ]   
   key printer as printer,
   @UI.lineItem: [ { position: 20, importance: #HIGH } ]
   @Semantics.text: true
   _PRINTMAST.Printername as printername,
   @UI.hidden: true
   zzdefault as zzdefault,
   @UI.hidden: true
   zzseqno as zzseqno
}
where user_id = $session.user

union 
  select from ZI_ZY200T
  
{
   key Printer as printer,
   Printername as printername,
   cast( 'P' as abap.char( 1 )) as zzdefault,
   cast( '9999' as zzseqno_04 preserving type ) as zzseqno
}
where 
  //環境毎のPDF・IDに変更する必要がある
  //Printer = 'PDF_1'
  Printer = 'PDF'
  
