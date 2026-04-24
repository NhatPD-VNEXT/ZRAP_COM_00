//************************************************************************
//*  [変更履歴]                                                          *
//*   バージョン情報 ：V1.00  2024/06/18  M.OKADA            XW2K900213  *
//*   変更内容       ：新規作成                                          *
//*----------------------------------------------------------------------*
//*   バージョン情報 ：V9.99  YYYY/MM/DD  変更者             移送番号    *
//*   変更内容       ：                                                  *
//************************************************************************

//以下のブロクをの内容を元に作成
//https://community.sap.com/t5/technology-blogs-by-sap/how-to-create-a-value-help-for-custom-and-released-domain-fixed-values/ba-p/13605706
//※ドラフトの入力画面では動作しない

@EndUserText.label: 'ドメイン値検索ヘルプ'
@ObjectModel.resultSet.sizeCategory: #XS
@ObjectModel.query.implementedBy: 'ABAP:ZCL_ZI_DOMAIN_FIX_VAL_VH'
define custom entity ZI_DOMAIN_FIX_VAL_VH
{
  @EndUserText.label     : 'domain name'
  @UI.hidden : true 
  key domain_name : sxco_ad_object_name;
  @UI.hidden  : true
  key pos         : abap.numc( 4 );
  @EndUserText.label     : 'lower_limit'
  low         : abap.char( 10 );
  @EndUserText.label     : 'upper_limit'
  high        : abap.char(10);
  @EndUserText.label     : 'Description'
  description : abap.char(60);
}
