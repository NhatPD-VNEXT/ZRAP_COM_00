************************************************************************
*  [変更履歴]                                                          *
*   バージョン情報 ：V1.00  2024/04/10  M.OKADA            XW2K900367  *
*   変更内容       ：新規作成                                          *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.01  2024/04/18  T.MIURA            XW2K900373  *
*   変更内容       ：Job IDを出力処理パラメータに追加                  *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.02  2024/04/30  T.MIURA            XW2K900373  *
*   変更内容       ：起動タイプを出力処理パラメータに追加              *
*                  ：フィールド数を50→100に更新                       *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.03  2024/05/17  T.MIURA            XW2K900373  *
*   変更内容       ：起動スクリプトのパラメータを追加                  *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.04  2024/05/23  T.MIURA            XW2K900373  *
*   変更内容       ：パラメータ「文字コード」、「区切り文字」を追加    *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.05  2024/06/12  M.OKADA            XW2K900213  *
*   変更内容       ：Application Log Objectsの固定値を追加             *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.06  2024/06/14  T.MIURA            XW2K900373  *
*   変更内容       ：ヘッダーフラグを追加                              *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.07  2024/06/28  T.MIURA            XW2K900373  *
*   変更内容       ：出力ファイル名変更によるパラメータを追加          *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.08  2024/07/17  T.MIURA            XW2K900373  *
*   変更内容       ：サーバーファイル取込機能のパラメータを追加        *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.09  2025/01/30  M.OKADA            NWFK900043  *
*   変更内容       ：PJ固有・業務帳票の区分IDを追加                    *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.10  2025/02/04  M.OKADA            NWFK900043  *
*   変更内容       ：200項目対応の改修を追加                           *
*                    - gts_svf_field_2(200項目版)を追加                *
*                    - gts_svf_data_2(200項目版)を追加                 *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.11  2025/02/06  M.SHIOMI           NWFK900043  *
*   変更内容       ：DWH連携_受注登録VA01のパラメータを追加            *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.12  2025/02/13  M.OKADA            NWFK900043  *
*   変更内容       ：PJ固有・IFの区分IDを追加                          *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.13  2025/03/21  IPS.VINHNQ         NWFK900043  *
*   変更内容       ：PJ固有・IFの区分IDを追加(APS連携)                 *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.14  2025/09/25  IPS.HOADT          NWFK900043  *
*   変更内容       ：PJ固有・IFの区分IDを追加(APS連携)                 *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.14  2025/12/04  IPS.AnhNN          NWFK900043  *
*   変更内容       ：PJ固有・FUNの区分IDを追加(APS連携)                 *
*----------------------------------------------------------------------*
*   バージョン情報 ：V9.99  YYYY/MM/DD  変更者             移送番号    *
*   変更内容       ：                                                  *
************************************************************************
INTERFACE zif_zrap_com_00
  PUBLIC .
*** 【T Y P E S宣言】 ***
  "出力処理 パラメータ_構造体.
  TYPES: BEGIN OF gts_out_parameter,
*-< ADD V1.01 (S) >-*
           svfjobid    TYPE c LENGTH 100,
*-< ADD V1.03 (S) >-*
           "DataSpiderで起動するスクリプト名
           scriptname  TYPE c LENGTH 100,
*-< ADD V1.03 (E) >-*
           filedir     TYPE c LENGTH 100,
*-< ADD V1.01 (E) >-*
*-< ADD V1.02 (S) >-*
           processtype TYPE c LENGTH 100,
*-< ADD V1.02 (E) >-*
*-< ADD V1.04 (S) >-*
           charcode    TYPE c LENGTH 100,
           delimiter   TYPE c LENGTH 100,
*-< ADD V1.04 (E) >-*
*-< ADD V1.06 (S) >-*
           headerflg   TYPE c LENGTH 100,
*-< ADD V1.06 (E) >-*
*-< ADD V1.07 (S) >-*
           docname     TYPE c LENGTH 100,
           mailaddress TYPE c LENGTH 100,
           sapsystime  TYPE c LENGTH 100,
*-< ADD V1.07 (E) >-*
           filename    TYPE c LENGTH 100.
  TYPES: END   OF gts_out_parameter.

*-< ADD V1.08 (S) >-*
  "サーバーファイル取込機能 パラメータ_構造体.
  TYPES: BEGIN OF gts_import_parameter,
           delimiter   TYPE c LENGTH 100,
           charcode    TYPE c LENGTH 100,
           filedir     TYPE c LENGTH 100,
           filename    TYPE c LENGTH 100,
           tempfiledir TYPE c LENGTH 100.
  TYPES: END   OF gts_import_parameter.

  "サーバーファイル取込機能（ファイルリスト取得処理）処理結果_構造体 .
  TYPES: BEGIN OF gts_import_file_list,
           filename TYPE c LENGTH 100,
           errcode  TYPE c LENGTH 100,
           errtype  TYPE c LENGTH 100,
           errmsg   TYPE c LENGTH 100.
  TYPES: END   OF gts_import_file_list.
*-< ADD V1.08 (E) >-*

  "SVF API関数_構造体.
  TYPES: BEGIN OF gts_svf_api,
           value TYPE c LENGTH 100.
  TYPES: END   OF gts_svf_api.
  TYPES:
    gtt_svf_api TYPE STANDARD TABLE OF gts_svf_api.

  "SVF 項目名_構造体.
  "※数を増やす場合、DataSpider側の上限の見直も必要
  "  →24/4/4時点で50.
  TYPES: BEGIN OF gts_svf_field,
           field001 TYPE c LENGTH 30,
           field002 TYPE c LENGTH 30,
           field003 TYPE c LENGTH 30,
           field004 TYPE c LENGTH 30,
           field005 TYPE c LENGTH 30,
           field006 TYPE c LENGTH 30,
           field007 TYPE c LENGTH 30,
           field008 TYPE c LENGTH 30,
           field009 TYPE c LENGTH 30,
           field010 TYPE c LENGTH 30,
           field011 TYPE c LENGTH 30,
           field012 TYPE c LENGTH 30,
           field013 TYPE c LENGTH 30,
           field014 TYPE c LENGTH 30,
           field015 TYPE c LENGTH 30,
           field016 TYPE c LENGTH 30,
           field017 TYPE c LENGTH 30,
           field018 TYPE c LENGTH 30,
           field019 TYPE c LENGTH 30,
           field020 TYPE c LENGTH 30,
           field021 TYPE c LENGTH 30,
           field022 TYPE c LENGTH 30,
           field023 TYPE c LENGTH 30,
           field024 TYPE c LENGTH 30,
           field025 TYPE c LENGTH 30,
           field026 TYPE c LENGTH 30,
           field027 TYPE c LENGTH 30,
           field028 TYPE c LENGTH 30,
           field029 TYPE c LENGTH 30,
           field030 TYPE c LENGTH 30,
           field031 TYPE c LENGTH 30,
           field032 TYPE c LENGTH 30,
           field033 TYPE c LENGTH 30,
           field034 TYPE c LENGTH 30,
           field035 TYPE c LENGTH 30,
           field036 TYPE c LENGTH 30,
           field037 TYPE c LENGTH 30,
           field038 TYPE c LENGTH 30,
           field039 TYPE c LENGTH 30,
           field040 TYPE c LENGTH 30,
           field041 TYPE c LENGTH 30,
           field042 TYPE c LENGTH 30,
           field043 TYPE c LENGTH 30,
           field044 TYPE c LENGTH 30,
           field045 TYPE c LENGTH 30,
           field046 TYPE c LENGTH 30,
           field047 TYPE c LENGTH 30,
           field048 TYPE c LENGTH 30,
           field049 TYPE c LENGTH 30,
*-< DEL V1.02 (S) >-*
*       FIELD050  TYPE c LENGTH 30.
*-< DEL V1.02 (E) >-*
*-< ADD V1.02 (S) >-*
           field050 TYPE c LENGTH 30,
           field051 TYPE c LENGTH 30,
           field052 TYPE c LENGTH 30,
           field053 TYPE c LENGTH 30,
           field054 TYPE c LENGTH 30,
           field055 TYPE c LENGTH 30,
           field056 TYPE c LENGTH 30,
           field057 TYPE c LENGTH 30,
           field058 TYPE c LENGTH 30,
           field059 TYPE c LENGTH 30,
           field060 TYPE c LENGTH 30,
           field061 TYPE c LENGTH 30,
           field062 TYPE c LENGTH 30,
           field063 TYPE c LENGTH 30,
           field064 TYPE c LENGTH 30,
           field065 TYPE c LENGTH 30,
           field066 TYPE c LENGTH 30,
           field067 TYPE c LENGTH 30,
           field068 TYPE c LENGTH 30,
           field069 TYPE c LENGTH 30,
           field070 TYPE c LENGTH 30,
           field071 TYPE c LENGTH 30,
           field072 TYPE c LENGTH 30,
           field073 TYPE c LENGTH 30,
           field074 TYPE c LENGTH 30,
           field075 TYPE c LENGTH 30,
           field076 TYPE c LENGTH 30,
           field077 TYPE c LENGTH 30,
           field078 TYPE c LENGTH 30,
           field079 TYPE c LENGTH 30,
           field080 TYPE c LENGTH 30,
           field081 TYPE c LENGTH 30,
           field082 TYPE c LENGTH 30,
           field083 TYPE c LENGTH 30,
           field084 TYPE c LENGTH 30,
           field085 TYPE c LENGTH 30,
           field086 TYPE c LENGTH 30,
           field087 TYPE c LENGTH 30,
           field088 TYPE c LENGTH 30,
           field089 TYPE c LENGTH 30,
           field090 TYPE c LENGTH 30,
           field091 TYPE c LENGTH 30,
           field092 TYPE c LENGTH 30,
           field093 TYPE c LENGTH 30,
           field094 TYPE c LENGTH 30,
           field095 TYPE c LENGTH 30,
           field096 TYPE c LENGTH 30,
           field097 TYPE c LENGTH 30,
           field098 TYPE c LENGTH 30,
           field099 TYPE c LENGTH 30,
           field100 TYPE c LENGTH 30.
*-< ADD V1.02 (E) >-*
  TYPES: END   OF gts_svf_field.

*-< ADD V1.10 (S) >-*
  TYPES: BEGIN OF gts_svf_field_2,
           field001 TYPE c LENGTH 30,
           field002 TYPE c LENGTH 30,
           field003 TYPE c LENGTH 30,
           field004 TYPE c LENGTH 30,
           field005 TYPE c LENGTH 30,
           field006 TYPE c LENGTH 30,
           field007 TYPE c LENGTH 30,
           field008 TYPE c LENGTH 30,
           field009 TYPE c LENGTH 30,
           field010 TYPE c LENGTH 30,
           field011 TYPE c LENGTH 30,
           field012 TYPE c LENGTH 30,
           field013 TYPE c LENGTH 30,
           field014 TYPE c LENGTH 30,
           field015 TYPE c LENGTH 30,
           field016 TYPE c LENGTH 30,
           field017 TYPE c LENGTH 30,
           field018 TYPE c LENGTH 30,
           field019 TYPE c LENGTH 30,
           field020 TYPE c LENGTH 30,
           field021 TYPE c LENGTH 30,
           field022 TYPE c LENGTH 30,
           field023 TYPE c LENGTH 30,
           field024 TYPE c LENGTH 30,
           field025 TYPE c LENGTH 30,
           field026 TYPE c LENGTH 30,
           field027 TYPE c LENGTH 30,
           field028 TYPE c LENGTH 30,
           field029 TYPE c LENGTH 30,
           field030 TYPE c LENGTH 30,
           field031 TYPE c LENGTH 30,
           field032 TYPE c LENGTH 30,
           field033 TYPE c LENGTH 30,
           field034 TYPE c LENGTH 30,
           field035 TYPE c LENGTH 30,
           field036 TYPE c LENGTH 30,
           field037 TYPE c LENGTH 30,
           field038 TYPE c LENGTH 30,
           field039 TYPE c LENGTH 30,
           field040 TYPE c LENGTH 30,
           field041 TYPE c LENGTH 30,
           field042 TYPE c LENGTH 30,
           field043 TYPE c LENGTH 30,
           field044 TYPE c LENGTH 30,
           field045 TYPE c LENGTH 30,
           field046 TYPE c LENGTH 30,
           field047 TYPE c LENGTH 30,
           field048 TYPE c LENGTH 30,
           field049 TYPE c LENGTH 30,
           field050 TYPE c LENGTH 30,
           field051 TYPE c LENGTH 30,
           field052 TYPE c LENGTH 30,
           field053 TYPE c LENGTH 30,
           field054 TYPE c LENGTH 30,
           field055 TYPE c LENGTH 30,
           field056 TYPE c LENGTH 30,
           field057 TYPE c LENGTH 30,
           field058 TYPE c LENGTH 30,
           field059 TYPE c LENGTH 30,
           field060 TYPE c LENGTH 30,
           field061 TYPE c LENGTH 30,
           field062 TYPE c LENGTH 30,
           field063 TYPE c LENGTH 30,
           field064 TYPE c LENGTH 30,
           field065 TYPE c LENGTH 30,
           field066 TYPE c LENGTH 30,
           field067 TYPE c LENGTH 30,
           field068 TYPE c LENGTH 30,
           field069 TYPE c LENGTH 30,
           field070 TYPE c LENGTH 30,
           field071 TYPE c LENGTH 30,
           field072 TYPE c LENGTH 30,
           field073 TYPE c LENGTH 30,
           field074 TYPE c LENGTH 30,
           field075 TYPE c LENGTH 30,
           field076 TYPE c LENGTH 30,
           field077 TYPE c LENGTH 30,
           field078 TYPE c LENGTH 30,
           field079 TYPE c LENGTH 30,
           field080 TYPE c LENGTH 30,
           field081 TYPE c LENGTH 30,
           field082 TYPE c LENGTH 30,
           field083 TYPE c LENGTH 30,
           field084 TYPE c LENGTH 30,
           field085 TYPE c LENGTH 30,
           field086 TYPE c LENGTH 30,
           field087 TYPE c LENGTH 30,
           field088 TYPE c LENGTH 30,
           field089 TYPE c LENGTH 30,
           field090 TYPE c LENGTH 30,
           field091 TYPE c LENGTH 30,
           field092 TYPE c LENGTH 30,
           field093 TYPE c LENGTH 30,
           field094 TYPE c LENGTH 30,
           field095 TYPE c LENGTH 30,
           field096 TYPE c LENGTH 30,
           field097 TYPE c LENGTH 30,
           field098 TYPE c LENGTH 30,
           field099 TYPE c LENGTH 30,
           field100 TYPE c LENGTH 30,
           field101 TYPE c LENGTH 30,
           field102 TYPE c LENGTH 30,
           field103 TYPE c LENGTH 30,
           field104 TYPE c LENGTH 30,
           field105 TYPE c LENGTH 30,
           field106 TYPE c LENGTH 30,
           field107 TYPE c LENGTH 30,
           field108 TYPE c LENGTH 30,
           field109 TYPE c LENGTH 30,
           field110 TYPE c LENGTH 30,
           field111 TYPE c LENGTH 30,
           field112 TYPE c LENGTH 30,
           field113 TYPE c LENGTH 30,
           field114 TYPE c LENGTH 30,
           field115 TYPE c LENGTH 30,
           field116 TYPE c LENGTH 30,
           field117 TYPE c LENGTH 30,
           field118 TYPE c LENGTH 30,
           field119 TYPE c LENGTH 30,
           field120 TYPE c LENGTH 30,
           field121 TYPE c LENGTH 30,
           field122 TYPE c LENGTH 30,
           field123 TYPE c LENGTH 30,
           field124 TYPE c LENGTH 30,
           field125 TYPE c LENGTH 30,
           field126 TYPE c LENGTH 30,
           field127 TYPE c LENGTH 30,
           field128 TYPE c LENGTH 30,
           field129 TYPE c LENGTH 30,
           field130 TYPE c LENGTH 30,
           field131 TYPE c LENGTH 30,
           field132 TYPE c LENGTH 30,
           field133 TYPE c LENGTH 30,
           field134 TYPE c LENGTH 30,
           field135 TYPE c LENGTH 30,
           field136 TYPE c LENGTH 30,
           field137 TYPE c LENGTH 30,
           field138 TYPE c LENGTH 30,
           field139 TYPE c LENGTH 30,
           field140 TYPE c LENGTH 30,
           field141 TYPE c LENGTH 30,
           field142 TYPE c LENGTH 30,
           field143 TYPE c LENGTH 30,
           field144 TYPE c LENGTH 30,
           field145 TYPE c LENGTH 30,
           field146 TYPE c LENGTH 30,
           field147 TYPE c LENGTH 30,
           field148 TYPE c LENGTH 30,
           field149 TYPE c LENGTH 30,
           field150 TYPE c LENGTH 30,
           field151 TYPE c LENGTH 30,
           field152 TYPE c LENGTH 30,
           field153 TYPE c LENGTH 30,
           field154 TYPE c LENGTH 30,
           field155 TYPE c LENGTH 30,
           field156 TYPE c LENGTH 30,
           field157 TYPE c LENGTH 30,
           field158 TYPE c LENGTH 30,
           field159 TYPE c LENGTH 30,
           field160 TYPE c LENGTH 30,
           field161 TYPE c LENGTH 30,
           field162 TYPE c LENGTH 30,
           field163 TYPE c LENGTH 30,
           field164 TYPE c LENGTH 30,
           field165 TYPE c LENGTH 30,
           field166 TYPE c LENGTH 30,
           field167 TYPE c LENGTH 30,
           field168 TYPE c LENGTH 30,
           field169 TYPE c LENGTH 30,
           field170 TYPE c LENGTH 30,
           field171 TYPE c LENGTH 30,
           field172 TYPE c LENGTH 30,
           field173 TYPE c LENGTH 30,
           field174 TYPE c LENGTH 30,
           field175 TYPE c LENGTH 30,
           field176 TYPE c LENGTH 30,
           field177 TYPE c LENGTH 30,
           field178 TYPE c LENGTH 30,
           field179 TYPE c LENGTH 30,
           field180 TYPE c LENGTH 30,
           field181 TYPE c LENGTH 30,
           field182 TYPE c LENGTH 30,
           field183 TYPE c LENGTH 30,
           field184 TYPE c LENGTH 30,
           field185 TYPE c LENGTH 30,
           field186 TYPE c LENGTH 30,
           field187 TYPE c LENGTH 30,
           field188 TYPE c LENGTH 30,
           field189 TYPE c LENGTH 30,
           field190 TYPE c LENGTH 30,
           field191 TYPE c LENGTH 30,
           field192 TYPE c LENGTH 30,
           field193 TYPE c LENGTH 30,
           field194 TYPE c LENGTH 30,
           field195 TYPE c LENGTH 30,
           field196 TYPE c LENGTH 30,
           field197 TYPE c LENGTH 30,
           field198 TYPE c LENGTH 30,
           field199 TYPE c LENGTH 30,
           field200 TYPE c LENGTH 30.
  TYPES: END   OF gts_svf_field_2.
*-< ADD V1.10 (E) >-*

  "SVF 項目値_構造体.
  "※数を増やす場合、DataSpider側の上限の見直も必要
  "  →24/4/4時点で50.
  TYPES: BEGIN OF gts_svf_data,
           field001 TYPE string,
           field002 TYPE string,
           field003 TYPE string,
           field004 TYPE string,
           field005 TYPE string,
           field006 TYPE string,
           field007 TYPE string,
           field008 TYPE string,
           field009 TYPE string,
           field010 TYPE string,
           field011 TYPE string,
           field012 TYPE string,
           field013 TYPE string,
           field014 TYPE string,
           field015 TYPE string,
           field016 TYPE string,
           field017 TYPE string,
           field018 TYPE string,
           field019 TYPE string,
           field020 TYPE string,
           field021 TYPE string,
           field022 TYPE string,
           field023 TYPE string,
           field024 TYPE string,
           field025 TYPE string,
           field026 TYPE string,
           field027 TYPE string,
           field028 TYPE string,
           field029 TYPE string,
           field030 TYPE string,
           field031 TYPE string,
           field032 TYPE string,
           field033 TYPE string,
           field034 TYPE string,
           field035 TYPE string,
           field036 TYPE string,
           field037 TYPE string,
           field038 TYPE string,
           field039 TYPE string,
           field040 TYPE string,
           field041 TYPE string,
           field042 TYPE string,
           field043 TYPE string,
           field044 TYPE string,
           field045 TYPE string,
           field046 TYPE string,
           field047 TYPE string,
           field048 TYPE string,
           field049 TYPE string,
*-< DEL V1.02 (S) >-*
*       FIELD050  TYPE string,
*-< DEL V1.02 (E) >-*
*-< ADD V1.02 (S) >-*
           field050 TYPE string,
           field051 TYPE string,
           field052 TYPE string,
           field053 TYPE string,
           field054 TYPE string,
           field055 TYPE string,
           field056 TYPE string,
           field057 TYPE string,
           field058 TYPE string,
           field059 TYPE string,
           field060 TYPE string,
           field061 TYPE string,
           field062 TYPE string,
           field063 TYPE string,
           field064 TYPE string,
           field065 TYPE string,
           field066 TYPE string,
           field067 TYPE string,
           field068 TYPE string,
           field069 TYPE string,
           field070 TYPE string,
           field071 TYPE string,
           field072 TYPE string,
           field073 TYPE string,
           field074 TYPE string,
           field075 TYPE string,
           field076 TYPE string,
           field077 TYPE string,
           field078 TYPE string,
           field079 TYPE string,
           field080 TYPE string,
           field081 TYPE string,
           field082 TYPE string,
           field083 TYPE string,
           field084 TYPE string,
           field085 TYPE string,
           field086 TYPE string,
           field087 TYPE string,
           field088 TYPE string,
           field089 TYPE string,
           field090 TYPE string,
           field091 TYPE string,
           field092 TYPE string,
           field093 TYPE string,
           field094 TYPE string,
           field095 TYPE string,
           field096 TYPE string,
           field097 TYPE string,
           field098 TYPE string,
           field099 TYPE string,
           field100 TYPE string.
*-< ADD V1.02 (E) >-*
  TYPES: END   OF gts_svf_data.

*-< ADD V1.10 (S) >-*
  TYPES: BEGIN OF gts_svf_data_2,
           field001 TYPE string,
           field002 TYPE string,
           field003 TYPE string,
           field004 TYPE string,
           field005 TYPE string,
           field006 TYPE string,
           field007 TYPE string,
           field008 TYPE string,
           field009 TYPE string,
           field010 TYPE string,
           field011 TYPE string,
           field012 TYPE string,
           field013 TYPE string,
           field014 TYPE string,
           field015 TYPE string,
           field016 TYPE string,
           field017 TYPE string,
           field018 TYPE string,
           field019 TYPE string,
           field020 TYPE string,
           field021 TYPE string,
           field022 TYPE string,
           field023 TYPE string,
           field024 TYPE string,
           field025 TYPE string,
           field026 TYPE string,
           field027 TYPE string,
           field028 TYPE string,
           field029 TYPE string,
           field030 TYPE string,
           field031 TYPE string,
           field032 TYPE string,
           field033 TYPE string,
           field034 TYPE string,
           field035 TYPE string,
           field036 TYPE string,
           field037 TYPE string,
           field038 TYPE string,
           field039 TYPE string,
           field040 TYPE string,
           field041 TYPE string,
           field042 TYPE string,
           field043 TYPE string,
           field044 TYPE string,
           field045 TYPE string,
           field046 TYPE string,
           field047 TYPE string,
           field048 TYPE string,
           field049 TYPE string,
           field050 TYPE string,
           field051 TYPE string,
           field052 TYPE string,
           field053 TYPE string,
           field054 TYPE string,
           field055 TYPE string,
           field056 TYPE string,
           field057 TYPE string,
           field058 TYPE string,
           field059 TYPE string,
           field060 TYPE string,
           field061 TYPE string,
           field062 TYPE string,
           field063 TYPE string,
           field064 TYPE string,
           field065 TYPE string,
           field066 TYPE string,
           field067 TYPE string,
           field068 TYPE string,
           field069 TYPE string,
           field070 TYPE string,
           field071 TYPE string,
           field072 TYPE string,
           field073 TYPE string,
           field074 TYPE string,
           field075 TYPE string,
           field076 TYPE string,
           field077 TYPE string,
           field078 TYPE string,
           field079 TYPE string,
           field080 TYPE string,
           field081 TYPE string,
           field082 TYPE string,
           field083 TYPE string,
           field084 TYPE string,
           field085 TYPE string,
           field086 TYPE string,
           field087 TYPE string,
           field088 TYPE string,
           field089 TYPE string,
           field090 TYPE string,
           field091 TYPE string,
           field092 TYPE string,
           field093 TYPE string,
           field094 TYPE string,
           field095 TYPE string,
           field096 TYPE string,
           field097 TYPE string,
           field098 TYPE string,
           field099 TYPE string,
           field100 TYPE string,
           field101 TYPE string,
           field102 TYPE string,
           field103 TYPE string,
           field104 TYPE string,
           field105 TYPE string,
           field106 TYPE string,
           field107 TYPE string,
           field108 TYPE string,
           field109 TYPE string,
           field110 TYPE string,
           field111 TYPE string,
           field112 TYPE string,
           field113 TYPE string,
           field114 TYPE string,
           field115 TYPE string,
           field116 TYPE string,
           field117 TYPE string,
           field118 TYPE string,
           field119 TYPE string,
           field120 TYPE string,
           field121 TYPE string,
           field122 TYPE string,
           field123 TYPE string,
           field124 TYPE string,
           field125 TYPE string,
           field126 TYPE string,
           field127 TYPE string,
           field128 TYPE string,
           field129 TYPE string,
           field130 TYPE string,
           field131 TYPE string,
           field132 TYPE string,
           field133 TYPE string,
           field134 TYPE string,
           field135 TYPE string,
           field136 TYPE string,
           field137 TYPE string,
           field138 TYPE string,
           field139 TYPE string,
           field140 TYPE string,
           field141 TYPE string,
           field142 TYPE string,
           field143 TYPE string,
           field144 TYPE string,
           field145 TYPE string,
           field146 TYPE string,
           field147 TYPE string,
           field148 TYPE string,
           field149 TYPE string,
           field150 TYPE string,
           field151 TYPE string,
           field152 TYPE string,
           field153 TYPE string,
           field154 TYPE string,
           field155 TYPE string,
           field156 TYPE string,
           field157 TYPE string,
           field158 TYPE string,
           field159 TYPE string,
           field160 TYPE string,
           field161 TYPE string,
           field162 TYPE string,
           field163 TYPE string,
           field164 TYPE string,
           field165 TYPE string,
           field166 TYPE string,
           field167 TYPE string,
           field168 TYPE string,
           field169 TYPE string,
           field170 TYPE string,
           field171 TYPE string,
           field172 TYPE string,
           field173 TYPE string,
           field174 TYPE string,
           field175 TYPE string,
           field176 TYPE string,
           field177 TYPE string,
           field178 TYPE string,
           field179 TYPE string,
           field180 TYPE string,
           field181 TYPE string,
           field182 TYPE string,
           field183 TYPE string,
           field184 TYPE string,
           field185 TYPE string,
           field186 TYPE string,
           field187 TYPE string,
           field188 TYPE string,
           field189 TYPE string,
           field190 TYPE string,
           field191 TYPE string,
           field192 TYPE string,
           field193 TYPE string,
           field194 TYPE string,
           field195 TYPE string,
           field196 TYPE string,
           field197 TYPE string,
           field198 TYPE string,
           field199 TYPE string,
           field200 TYPE string.
  TYPES: END   OF gts_svf_data_2.
*-< ADD V1.10 (E) >-*

*-< ADD V1.08 (S) >-*
  "取込ファイル項目
  "項目数のMAXは100個
  TYPES: BEGIN OF gts_import_file_field,
           field001 TYPE string,
           field002 TYPE string,
           field003 TYPE string,
           field004 TYPE string,
           field005 TYPE string,
           field006 TYPE string,
           field007 TYPE string,
           field008 TYPE string,
           field009 TYPE string,
           field010 TYPE string,
           field011 TYPE string,
           field012 TYPE string,
           field013 TYPE string,
           field014 TYPE string,
           field015 TYPE string,
           field016 TYPE string,
           field017 TYPE string,
           field018 TYPE string,
           field019 TYPE string,
           field020 TYPE string,
           field021 TYPE string,
           field022 TYPE string,
           field023 TYPE string,
           field024 TYPE string,
           field025 TYPE string,
           field026 TYPE string,
           field027 TYPE string,
           field028 TYPE string,
           field029 TYPE string,
           field030 TYPE string,
           field031 TYPE string,
           field032 TYPE string,
           field033 TYPE string,
           field034 TYPE string,
           field035 TYPE string,
           field036 TYPE string,
           field037 TYPE string,
           field038 TYPE string,
           field039 TYPE string,
           field040 TYPE string,
           field041 TYPE string,
           field042 TYPE string,
           field043 TYPE string,
           field044 TYPE string,
           field045 TYPE string,
           field046 TYPE string,
           field047 TYPE string,
           field048 TYPE string,
           field049 TYPE string,
           field050 TYPE string,
           field051 TYPE string,
           field052 TYPE string,
           field053 TYPE string,
           field054 TYPE string,
           field055 TYPE string,
           field056 TYPE string,
           field057 TYPE string,
           field058 TYPE string,
           field059 TYPE string,
           field060 TYPE string,
           field061 TYPE string,
           field062 TYPE string,
           field063 TYPE string,
           field064 TYPE string,
           field065 TYPE string,
           field066 TYPE string,
           field067 TYPE string,
           field068 TYPE string,
           field069 TYPE string,
           field070 TYPE string,
           field071 TYPE string,
           field072 TYPE string,
           field073 TYPE string,
           field074 TYPE string,
           field075 TYPE string,
           field076 TYPE string,
           field077 TYPE string,
           field078 TYPE string,
           field079 TYPE string,
           field080 TYPE string,
           field081 TYPE string,
           field082 TYPE string,
           field083 TYPE string,
           field084 TYPE string,
           field085 TYPE string,
           field086 TYPE string,
           field087 TYPE string,
           field088 TYPE string,
           field089 TYPE string,
           field090 TYPE string,
           field091 TYPE string,
           field092 TYPE string,
           field093 TYPE string,
           field094 TYPE string,
           field095 TYPE string,
           field096 TYPE string,
           field097 TYPE string,
           field098 TYPE string,
           field099 TYPE string,
           field100 TYPE string,
           field101 TYPE string,
           field102 TYPE string,
           field103 TYPE string,
           field104 TYPE string.
  TYPES: END   OF gts_import_file_field.
*-< ADD V1.08 (E) >-*

*** 【CONSTANTS宣言】 ***
  CONSTANTS:
*-< ADD V1.05 (S) >-*
    "Application Log Objects.
    gcf_app_log_object    TYPE  if_bali_object_handler=>ty_object
                          VALUE 'ZRAP_COM_00',
*-< ADD V1.05 (E) >-*

    "パッケージ・区分ID 固定値構造.
    BEGIN OF gcs_div,
      zrap_tpl_vi901      TYPE zzdiv VALUE 'VI901',
      zrap_tpl_ft001      TYPE zzdiv VALUE 'FT001',
      zrap_tpl_ft002      TYPE zzdiv VALUE 'FT002',
*-< ADD V1.08 (S) >-*
      zrap_tpl_vt001      TYPE zzdiv VALUE 'VT001',
*-< ADD V1.08 (E) >-*
      zrap_tpl_vt002      TYPE zzdiv VALUE 'VT002',
      zrap_tpl_vt003      TYPE zzdiv VALUE 'VT003',
      zrap_tpl_vt004      TYPE zzdiv VALUE 'VT004',
      zrap_tpl_mt001      TYPE zzdiv VALUE 'MT001',
      zrap_tpl_mt002      TYPE zzdiv VALUE 'MT002',
      zrap_tpl_mr001      TYPE zzdiv VALUE 'MR001',
      zrap_tpl_pt001      TYPE zzdiv VALUE 'PT001',
*-< ADD V1.09 (S) >-*
      zrap_rep_fr901      TYPE zzdiv VALUE 'FR901',  "請求内訳書
      zrap_rep_fr902      TYPE zzdiv VALUE 'FR902',  "財務諸表の出力
      zrap_rep_fr902_bs   TYPE zzdiv VALUE 'FR902_BS',  "財務諸表の出力(BS)
      zrap_rep_fr902_pl   TYPE zzdiv VALUE 'FR902_PL',  "財務諸表の出力(PL)
      zrap_rep_fr903      TYPE zzdiv VALUE 'FR903',  "まとめ出荷ID別顧客仕入先請求書
      zrap_rep_mr901      TYPE zzdiv VALUE 'MR901',  "注文書印刷（注文書兼納品書）
      zrap_rep_mr902      TYPE zzdiv VALUE 'MR902',  "Packing List
      zrap_rep_mr903      TYPE zzdiv VALUE 'MR903',  "PO一覧
      zrap_rep_mr904      TYPE zzdiv VALUE 'MR904',  "支給伝票
      zrap_rep_mr905      TYPE zzdiv VALUE 'MR905',  "納品書帳票作成
      zrap_rep_mr906      TYPE zzdiv VALUE 'MR906',  "内示
      zrap_rep_pr901      TYPE zzdiv VALUE 'PR901',  "製造手順書兼チェックシート兼実績入力
      zrap_rep_pr902      TYPE zzdiv VALUE 'PR902',  "オーダキットラベル/部品キットラベル
      zrap_rep_pr903      TYPE zzdiv VALUE 'PR903',  "部品出庫一覧
      zrap_rep_vr901      TYPE zzdiv VALUE 'VR901',  "海外出荷帳票
      zrap_rep_vr902      TYPE zzdiv VALUE 'VR902',  "Invoice
      zrap_rep_vr903      TYPE zzdiv VALUE 'VR903',  "納品書一覧
*-< ADD V1.09 (E) >-*
*-< ADD V1.11 (S) >-*
      zrap_tpl_vi910_1    TYPE zzdiv VALUE 'VI910_1',
      zrap_tpl_vi910_2    TYPE zzdiv VALUE 'VI910_2',
*-< ADD V1.11 (E) >-*
*-< ADD V1.12 (S) >-*
      zrap_fun_yf001      TYPE zzdiv VALUE 'YF001',   "パラメータテーブル.

      zrap_if_vi902       TYPE zzdiv VALUE 'VI902',   "代理店Web_品目情報
      zrap_if_vi903       TYPE zzdiv VALUE 'VI903',   "代理店Web_価格マスタ
      zrap_if_vi904       TYPE zzdiv VALUE 'VI904',   "代理店Web_納期回答
      zrap_if_vi905       TYPE zzdiv VALUE 'VI905',   "代理店Web_出荷検収データ（出荷）
      zrap_if_vi906       TYPE zzdiv VALUE 'VI906',   "代理店Web_出荷検収データ（経費）
      zrap_if_vi907       TYPE zzdiv VALUE 'VI907',   "代理店Web_出荷検収データ（返品）
      zrap_if_vi908       TYPE zzdiv VALUE 'VI908',   "代理店Web_カレンダーマスタ
      zrap_if_vi909       TYPE zzdiv VALUE 'VI909',   "代理店Web_代理店_受注
      zrap_if_vi911       TYPE zzdiv VALUE 'VI911',   "代理店Web_代理店_値引
      zrap_if_yi920       TYPE zzdiv VALUE 'YI920',   "作業工程管理（HHT）.
      zrap_if_yi921       TYPE zzdiv VALUE 'YI921',   "3PL：出荷指示CSV出力IF.
      zrap_if_yi922       TYPE zzdiv VALUE 'YI922',   "3PL：品名マスタCSV出力IF.
      zrap_if_yi923       TYPE zzdiv VALUE 'YI923',   "3PL：出荷先マスタCSV出力IF.
      zrap_if_yi924       TYPE zzdiv VALUE 'YI924',   "3PL：出荷指示情報タCSV出力IF.

      zrap_if_yi926_1     TYPE zzdiv VALUE 'YI926_1', "DWH連携_1.品目(基本).
      zrap_if_yi926_2     TYPE zzdiv VALUE 'YI926_2', "DWH連携_1.品目(プラント).
      zrap_if_yi926_3     TYPE zzdiv VALUE 'YI926_3', "DWH連携_1.品目(販売組織).
      zrap_if_yi926_4     TYPE zzdiv VALUE 'YI926_4', "DWH連携_1.品目(保管場所).
      zrap_if_yi926_5     TYPE zzdiv VALUE 'YI926_5', "DWH連携_1.品目(言語).
      zrap_if_yi926_6     TYPE zzdiv VALUE 'YI926_6', "DWH連携_1.品目(代替数量).
      zrap_if_yi926_7     TYPE zzdiv VALUE 'YI926_7', "DWH連携_1.品目(標準原価).
      zrap_if_yi926_8     TYPE zzdiv VALUE 'YI926_8', "DWH連携_1.品目(税分類).

      zrap_if_yi927_1     TYPE zzdiv VALUE 'YI927_1', "DWH連携_2.ビジネスパートナ(共通).
      zrap_if_yi927_2     TYPE zzdiv VALUE 'YI927_2', "DWH連携_2.ビジネスパートナ(得意先：一般).
      zrap_if_yi927_3     TYPE zzdiv VALUE 'YI927_3', "DWH連携_2.ビジネスパートナ(得意先：会社/販売組織).
      zrap_if_yi927_4     TYPE zzdiv VALUE 'YI927_4', "DWH連携_2.ビジネスパートナ(得意先：取引先機能).
      zrap_if_yi927_5     TYPE zzdiv VALUE 'YI927_5', "DWH連携_2.ビジネスパートナ(サプライヤ：一般).
      zrap_if_yi927_6     TYPE zzdiv VALUE 'YI927_6', "DWH連携_2.ビジネスパートナ(サプライヤ：会社/購買組織).
      zrap_if_yi927_7     TYPE zzdiv VALUE 'YI927_7', "DWH連携_2.ビジネスパートナ(サプライヤ：取引先機能).
      zrap_if_yi927_8     TYPE zzdiv VALUE 'YI927_8', "DWH連携_2.ビジネスパートナ(サプライヤ：テキスト).
      zrap_if_yi927_9     TYPE zzdiv VALUE 'YI927_9', "DWH連携_2.ビジネスパートナ(共通：BPロール).
      zrap_if_yi927_A     TYPE zzdiv VALUE 'YI927_A', "DWH連携_2.ビジネスパートナ(得意先：税分類).
      zrap_if_yi927_B     TYPE zzdiv VALUE 'YI927_B', "DWH連携_2.ビジネスパートナ(共通：ID).
      zrap_if_yi927_C     TYPE zzdiv VALUE 'YI927_C', "DWH連携_2.ビジネスパートナ(共通：税番号).

      zrap_if_yi928_1     TYPE zzdiv VALUE 'YI928_1', "DWH連携_3.価格（販売）(条件).
      zrap_if_yi928_2     TYPE zzdiv VALUE 'YI928_2', "DWH連携_3.価格（販売）(スケール).

      zrap_if_yi929_1     TYPE zzdiv VALUE 'YI929_1', "DWH連携_4.得意先品目情報.

      zrap_if_yi930_1     TYPE zzdiv VALUE 'YI930_1', "DWH連携_6.購買情報(一般).
      zrap_if_yi930_2     TYPE zzdiv VALUE 'YI930_2', "DWH連携_6.購買情報(購買組織).
      zrap_if_yi930_3     TYPE zzdiv VALUE 'YI930_3', "DWH連携_6.購買情報(条件).
      zrap_if_yi930_4     TYPE zzdiv VALUE 'YI930_4', "DWH連携_6.購買情報(スケール).

      zrap_if_yi931_1     TYPE zzdiv VALUE 'YI931_1', "DWH連携_8.BOM(ヘッダ).
      zrap_if_yi931_2     TYPE zzdiv VALUE 'YI931_2', "DWH連携_8.BOM(明細).

      zrap_if_yi932_1     TYPE zzdiv VALUE 'YI932_1', "DWH連携_8.BOM(ヘッダ).
      zrap_if_yi932_2     TYPE zzdiv VALUE 'YI932_2', "DWH連携_8.BOM(原価計算明細).

      zrap_if_yi933_1     TYPE zzdiv VALUE 'YI933_1', "DWH連携_10.作業手順(ヘッダ).
      zrap_if_yi933_2     TYPE zzdiv VALUE 'YI933_2', "DWH連携_10.作業手順(作業手順).

      zrap_if_yi934_1     TYPE zzdiv VALUE 'YI934_1', "DWH連携_11.製造バージョン.

      zrap_if_yi935_1     TYPE zzdiv VALUE 'YI935_1', "DWH連携_17.支払条件(言語).
      zrap_if_yi935_2     TYPE zzdiv VALUE 'YI935_2', "DWH連携_17.支払条件(支払条件).

      zrap_if_yi936_1     TYPE zzdiv VALUE 'YI936_1', "DWH連携_18.通貨換算レート.

      zrap_if_yi937_1     TYPE zzdiv VALUE 'YI937_1', "DWH連携_20.原価センタ(一般).
      zrap_if_yi937_2     TYPE zzdiv VALUE 'YI937_2', "DWH連携_20.原価センタ(言語).

      zrap_if_yi938_1     TYPE zzdiv VALUE 'YI938_1', "DWH連携_21.利益センタ(一般).
      zrap_if_yi938_2     TYPE zzdiv VALUE 'YI938_2', "DWH連携_21.利益センタ(会社).
      zrap_if_yi938_3     TYPE zzdiv VALUE 'YI938_3', "DWH連携_21.利益センタ(言語).

      zrap_if_yi939_1     TYPE zzdiv VALUE 'YI939_1', "DWH連携_23.統計品目コード.

      zrap_if_yi942_1     TYPE zzdiv VALUE 'YI942_1', "DWH連携_26.品目リビジョン_アドオンテーブル.
      zrap_if_yi943_1     TYPE zzdiv VALUE 'YI943_1', "DWH連携_27.外注先安全在庫_アドオンテーブル.

      zrap_if_yi944_1     TYPE zzdiv VALUE 'YI944_1', "DWH連携_28.プロジェクト.

      zrap_if_yi946_1     TYPE zzdiv VALUE 'YI946_1', "DWH連携_30.環境管理コード_アドオンテーブル.
      zrap_if_yi947_1     TYPE zzdiv VALUE 'YI947_1', "DWH連携_31.荷姿区分_アドオンテーブル.
      zrap_if_yi948_1     TYPE zzdiv VALUE 'YI948_1', "DWH連携_32.出荷時注意コード_アドオンテーブル.
      zrap_if_yi949_1     TYPE zzdiv VALUE 'YI949_1', "DWH連携_33.在庫区分_アドオンテーブル.
      zrap_if_yi950_1     TYPE zzdiv VALUE 'YI950_1', "DWH連携_34.製造ライン_アドオンテーブル.
      zrap_if_yi951_1     TYPE zzdiv VALUE 'YI951_1', "DWH連携_35.流程カードNo_アドオンテーブル.

      zrap_if_yi952_1     TYPE zzdiv VALUE 'YI952_1', "DWH連携_14.勘定(勘定).
      zrap_if_yi952_2     TYPE zzdiv VALUE 'YI952_2', "DWH連携_14.勘定(言語).
      zrap_if_yi952_3     TYPE zzdiv VALUE 'YI952_3', "DWH連携_14.勘定(会社).

      zrap_if_yi953_1     TYPE zzdiv VALUE 'YI953_1', "DWH連携_15.銀行.

      zrap_if_yi954_1     TYPE zzdiv VALUE 'YI954_1', "DWH連携_コード・名称.

      zrap_if_mi901_1     TYPE zzdiv VALUE 'MI901_1', "DWH連携_購買依頼ME59N(ヘッダ).
      zrap_if_mi901_2     TYPE zzdiv VALUE 'MI901_2', "DWH連携_購買依頼ME59N(明細).

      zrap_if_mi902_1     TYPE zzdiv VALUE 'MI902_1', "DWH連携_発注登録ME21N(ヘッダ).
      zrap_if_mi902_2     TYPE zzdiv VALUE 'MI902_2', "DWH連携_発注登録ME21N(明細).
      zrap_if_mi902_3     TYPE zzdiv VALUE 'MI902_3', "DWH連携_発注登録ME21N(構成品目).

      zrap_if_mi903_1     TYPE zzdiv VALUE 'MI903_1', "DWH連携_入庫MIGO(ヘッダ).
      zrap_if_mi903_2     TYPE zzdiv VALUE 'MI903_2', "DWH連携_入庫MIGO(明細).

      zrap_if_mi904_1     TYPE zzdiv VALUE 'MI904_1', "DWH連携_サプライヤ請求書MIRO(ヘッダ).
      zrap_if_mi904_2     TYPE zzdiv VALUE 'MI904_2', "DWH連携_サプライヤ請求書MIRO(発注明細).
      zrap_if_mi904_3     TYPE zzdiv VALUE 'MI904_3', "DWH連携_サプライヤ請求書MIRO(品目明細).
      zrap_if_mi904_4     TYPE zzdiv VALUE 'MI904_4', "DWH連携_サプライヤ請求書MIRO(勘定明細).

      zrap_if_mi905_1     TYPE zzdiv VALUE 'MI905_1', "購買発注受入管理_アドオンテーブル.

      zrap_if_mi906_1     TYPE zzdiv VALUE 'MI906_1', "DWH連携_if手配引当状況.

      zrap_if_vi910_1     TYPE zzdiv VALUE 'VI910_1', "DWH連携_受注登録VA01(ヘッダ).
      zrap_if_vi910_2     TYPE zzdiv VALUE 'VI910_2', "DWH連携_受注登録VA01(明細).

      zrap_if_vi912_1     TYPE zzdiv VALUE 'VI912_1', "DWH連携_出荷登録VL01N(ヘッダ).
      zrap_if_vi912_2     TYPE zzdiv VALUE 'VI912_2', "DWH連携_出荷登録VL01N(明細).

      zrap_if_vi913_1     TYPE zzdiv VALUE 'VI913_1', "DWH連携_請求登録VF01(ヘッダ).
      zrap_if_vi913_2     TYPE zzdiv VALUE 'VI913_2', "DWH連携_請求登録VF01(明細).

      zrap_if_vi914_1     TYPE zzdiv VALUE 'VI914_1', "DWH連携_まとめ出荷_アドオンテーブル(ヘッダ).
      zrap_if_vi914_2     TYPE zzdiv VALUE 'VI914_2', "DWH連携_まとめ出荷_アドオンテーブル(明細).
      zrap_if_vi914_3     TYPE zzdiv VALUE 'VI914_3', "DWH連携_まとめ出荷_アドオンテーブル(カートン).
      zrap_if_vi914_4     TYPE zzdiv VALUE 'VI914_4', "DWH連携_まとめ出荷_アドオンテーブル(カートン明細).

      zrap_if_pi902_1     TYPE zzdiv VALUE 'PI902_1', "DWH連携_計画独立所要量登録(ヘッダ).
      zrap_if_pi902_2     TYPE zzdiv VALUE 'PI902_2', "DWH連携_計画独立所要量登録(明細).

      zrap_if_pi903_1     TYPE zzdiv VALUE 'PI903_1', "DWH連携_計画手配登録(ヘッダ).
      zrap_if_pi903_2     TYPE zzdiv VALUE 'PI903_2', "DWH連携_計画手配登録(構成品目).

      zrap_if_pi904_1     TYPE zzdiv VALUE 'PI904_1', "DWH連携_製造指図登録(ヘッダ).
      zrap_if_pi904_2     TYPE zzdiv VALUE 'PI904_2', "DWH連携_製造指図登録(作業).
      zrap_if_pi904_3     TYPE zzdiv VALUE 'PI904_3', "DWH連携_製造指図登録(構成明細).

      zrap_if_pi905_1     TYPE zzdiv VALUE 'PI905_1', "DWH連携_製造指図作業確認.

      zrap_if_ci901_1     TYPE zzdiv VALUE 'CI901_1', "DWH連携_財務計画データ.

      zrap_if_ci902_1     TYPE zzdiv VALUE 'CI902_1', "DWH連携_原価計算データ_原価率・計画.
      zrap_if_ci902_2     TYPE zzdiv VALUE 'CI902_2', "DWH連携_原価計算データ_原価率・実際.

      zrap_if_ci903_1     TYPE zzdiv VALUE 'CI903_1', "DWH連携_原価計算データ_原価積上・ヘッダ.
      zrap_if_ci903_2     TYPE zzdiv VALUE 'CI903_2', "DWH連携_原価計算データ_原価積上・明細.

      zrap_if_ci904_1     TYPE zzdiv VALUE 'CI904_1', "DWH連携_原価計算データ_指図別原価・実際原価/計画原価/目標原価.
      zrap_if_ci904_2     TYPE zzdiv VALUE 'CI904_2', "DWH連携_原価計算データ_指図別原価・仕掛品/差異.

      zrap_if_ci905_1     TYPE zzdiv VALUE 'CI905_1', "DWH連携_原価計算データ_品目元帳 品目別原価.

      zrap_if_ci906_1     TYPE zzdiv VALUE 'CI906_1', "DWH連携_原価計算データ_品目元帳_品目別原価の明細.

      zrap_if_fi901_1     TYPE zzdiv VALUE 'FI901_1', "DWH連携_会計伝票(ヘッダ).
      zrap_if_fi901_2     TYPE zzdiv VALUE 'FI901_2', "DWH連携_会計伝票(明細).
*-< ADD V1.12 (E) >-*
*-< ADD V1.13 (S) >-*
      zrap_if_pi907       TYPE zzdiv VALUE 'PI907',   "APS連携_品目マスタ送信.
      zrap_if_pi908       TYPE zzdiv VALUE 'PI908',   "APS連携_BOMマスタ送信.
      zrap_if_pi909       TYPE zzdiv VALUE 'PI909',   "APS連携_稼働日カレンダ送信.
      zrap_if_pi910       TYPE zzdiv VALUE 'PI910',   "APS連携_購買情報マスタ送信処理.
      zrap_if_pi911       TYPE zzdiv VALUE 'PI911',   "APS連携_受注伝票送信.
      zrap_if_pi912       TYPE zzdiv VALUE 'PI912',   "APS連携_受注伝票受信.
      zrap_if_pi913       TYPE zzdiv VALUE 'PI913',   "APS連携_購買依頼送信.
      zrap_if_pi914       TYPE zzdiv VALUE 'PI914',   "APS連携_購買依頼受信.
      zrap_if_pi915       TYPE zzdiv VALUE 'PI915',   "APS連携_購買発注送信.
      zrap_if_pi916       TYPE zzdiv VALUE 'PI916',   "APS連携_計画手配送信.
      zrap_if_pi917       TYPE zzdiv VALUE 'PI917',   "APS連携_計画手配受信.
      zrap_if_pi918       TYPE zzdiv VALUE 'PI918',   "APS連携_製造指図送信.
      zrap_if_pi919       TYPE zzdiv VALUE 'PI919',   "APS連携_製造指図受信.
      zrap_if_pi920       TYPE zzdiv VALUE 'PI920',   "APS-計画独立所要量送信.
      zrap_if_pi921       TYPE zzdiv VALUE 'PI921',   "APS連携_在庫送信.
      zrap_if_pi922       TYPE zzdiv VALUE 'PI922',   "APS連携_作業区カレンダ送信.
      zrap_if_yi911       TYPE zzdiv VALUE 'YI911',   "発注価格サーバファイル取込.
      zrap_if_pi923       TYPE zzdiv VALUE 'PI923',   "APS連携_伝票紐付け送信
      zrap_if_pi924       TYPE zzdiv VALUE 'PI924',   "APS連携_購買発注受信
      zrap_if_pi925       TYPE zzdiv VALUE 'PI925',   "APS連携_伝票紐付け受信
      zrap_if_pi929       TYPE zzdiv VALUE 'PI929',   "APS連携_計画独立所要量の優先順位決定するための日数（送信）
*-< ADD V1.13 (E) >-*
*-< ADD V1.14 (S) >-*
      zrap_rep_fr904      TYPE zzdiv VALUE 'FR904',   "APS支払の締め処理.
*-< ADD V1.14 (E) >-*
*-< ADD V1.15 (S) >-*
      zrap_fun_vf908      TYPE zzdiv VALUE 'VF908',   "APIテンプレート（二次開発）.
*-< ADD V1.15 (E) >-*
    END   OF gcs_div.

*** 【D A T A 　宣言】 ***


ENDINTERFACE.
