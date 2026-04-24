************************************************************************
*  [変更履歴]                                                          *
*   バージョン情報 ：V1.00  2024/01/25  M.OKADA            XW2K900367  *
*   変更内容       ：新規作成                                          *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.01  2024/04/18  T.MIURA            XW2K900213  *
*   変更内容       ：Job IDを出力処理パラメータに追加                  *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.02  2024/04/30  T.MIURA            XW2K900213  *
*   変更内容       ：起動タイプを出力処理パラメータに追加              *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.03  2024/05/17  T.MIURA            XW2K900213  *
*   変更内容       ：呼び出すスクリプトのパラメータを追加              *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.04  2024/05/22  T.MIURA            XW2K900213  *
*   変更内容       ：APIのResponseからのエラー情報取得処理を追加       *
*                    パラメータ設定メソッド.ディレクトリ条件を変更     *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.05  2024/06/06  T.MIURA            XW2K900213  *
*   変更内容       ：エラーコードを追加                                *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.06  2024/06/14  T.MIURA            XW2K900213  *
*   変更内容       ：ヘッダーフラグを追加                              *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.07  2024/06/19  M.OKADA            XW2K900213  *
*   変更内容       ：代理店Web・品目情報_送信のファイル命名規約を追加  *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.08  2024/06/27  T.MIURA            XW2K900213  *
*   変更内容       ：出力ファイル名変更によるパラメータ設定を変更      *
*                    VrSetUserNameのパラメータをメールアドレスに変更   *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.09  2024/12/06  M.SHIOMI           NWFK900043  *
*   変更内容       ：ATCチェック対応のため                             *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.10  2025/01/07  M.OKADA            NWFK900043  *
*   変更内容       ：ユーザ・初期値プリンタ取得のMethodを追加          *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.11  2025/02/04  M.OKADA            NWFK900043  *
*   変更内容       ：200項目対応の改修を追加                           *
*                    ・COM Outbound Service取得(ZY043T)の固定値を      *
*                      Importパラメータ「if_com_os_div」に変更         *
*                      ※200項目のHTTPリクエストに切り替える場合は     *
*                        ZCL_SVF_OUTPUT_2を外部から指定                *
*                    ・if_oo_adt_classrunを追加(動作確認用)            *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.12  2025/02/13  M.SHIOMI           NWFK900043  *
*   変更内容       ：DWHの場合のファイル名を追加                       *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.13  2025/03/11  M.OKADA            NWFK900043  *
*   変更内容       ：特定のSSLエラーの場合、再処理を行うように修正     *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.14  2025/07/24  M.OKADA            NWFK900043  *
*   変更内容       ：特定のSSLエラーの場合、再処理を行うように修正     *
*                    ※1.13と異なるエラーが発生したため追加            *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.15  2025/10/14  M.OKADA            NWFK900043  *
*   変更内容       ：特定のSSLエラーの場合、再処理を行うように修正     *
*                    ※1.13~1.14と異なるエラーが発生したため追加       *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.16  2025/10/15  M.OKADA            NWFK900043  *
*   変更内容       ：1.13で実装したリトライ処理の                      *
*                    以下を固定値ではなく変数に変更                    *
*                    ・リトライ回数                                    *
*                    ・待ち時間                                        *
*                    待ち時間の値を変更                                *
*                    ・1 → 10                                         *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.17  2025/10/16  M.OKADA            NWFK900043  *
*   変更内容       ：svf_output_procのEXPORTINGパラメータを追加        *
*                    ・ef_cause_msg                                    *
*                    　※呼出元のメッセージに原因となった              *
*                      　エラーメッセージを出力するため                *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.18  2026/01/26  M.OKADA            NWFK900043  *
*   変更内容       ：SSLエラー対応                                     *
*                    1.13~1.14のチェック対象の文字列の前半部分が       *
*                    一致していれば対象となるように変更                *
*                    ※完全一致では対象とならないケースがでてきた為    *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.19  2026/02/03  M.OKADA            NWFK900043  *
*   変更内容       ：エラーコードE06を追加                             *
*----------------------------------------------------------------------*
*   バージョン情報 ：V9.99  YYYY/MM/DD  変更者             移送番号    *
*   変更内容       ：                                                  *
************************************************************************
CLASS zcl_svf_output DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

*-< ADD V1.04 (S) >-*
    TYPES:
      BEGIN OF gts_ds_result_info,
        filename TYPE string, "ファイル名.
        msg      TYPE string, "処理結果.
        errmsg   TYPE string, "エラーメッセージ.
        errtype  TYPE string, "エラータイプ.
        errcode  TYPE string, "エラーコード（ロジックで個別に実装したもの）.
      END OF gts_ds_result_info.

    TYPES:
      gtt_ds_result_info TYPE TABLE OF gts_ds_result_info.

    CLASS-DATA:
      gdt_ds_result_info TYPE gtt_ds_result_info.
*-< ADD V1.04 (E) >-*

*-< ADD V1.13 (S) >-*
    CLASS-DATA:
      BEGIN OF gds_ssl_err,
        p1  TYPE  string
            VALUE 'SSL handshake with vm-eai-prod-001.nkkswitches.co. 403' ##NO_TEXT,

*-< ADD V1.14 (S) >-*
        p2  TYPE  string
            VALUE 'Direct connect to vm-eai-prod-001.nkkswitches.co.j 411' ##NO_TEXT,
*-< ADD V1.14 (E) >-*

*-< ADD V1.15 (S) >-*
        p3  TYPE  string
            VALUE 'Connection to partner timed out after 600s. 402' ##NO_TEXT,
*-< ADD V1.15 (E) >-*

*-< ADD V1.18 (S) >-*
        p4  TYPE  string
            VALUE 'SSL handshake with*' ##NO_TEXT,
        p5  TYPE  string
            VALUE 'Direct connect to*' ##NO_TEXT,
*-< ADD V1.18 (E) >-*
      END   OF gds_ssl_err.
*-< ADD V1.13 (E) >-*

*-< ADD V1.16 (S) >-*
    CLASS-DATA:
      gdf_retry_cnt     TYPE  i                            "再処理回数.
                        VALUE 10
                        ,
      gdf_wait          TYPE  i                            "待ち時間(秒)
                        VALUE 10
                        .
*-< ADD V1.16 (E) >-*

    "SVF 出力実行処理.
    CLASS-METHODS svf_output_proc
      IMPORTING
        if_div          TYPE zzdiv                         "区分.
        is_out_dat      TYPE any                           "出力データ構造
*-< ADD V1.11 (S) >-*
        if_com_os_div   TYPE any                           "COM Outbound Service取得
          DEFAULT 'ZCL_SVF_OUTPUT'
*-< ADD V1.11 (E) >-*
      EXPORTING
        ef_ds_err_msg   TYPE string                        "DataSpiderエラーメッセージ
*-< ADD V1.13 (S) >-*
        ef_warm_msg     TYPE string                        "警告メッセージ
        ef_retry_cnt    TYPE i                             "再処理.
*-< ADD V1.13 (E) >-*
*-< ADD V1.17 (S) >-*
        ef_cause_msg     TYPE string                       "原因メッセージ
*-< ADD V1.17 (E) >-*
      RETURNING
        VALUE(ef_subrc) TYPE sy-subrc                      "戻り値.
      RAISING
        zcx_no_data                                        "対象データなし.
        cx_http_dest_provider_error
        cx_web_http_client_error
        .

    "SVF API関数設定.
    CLASS-METHODS svf_api_set
      IMPORTING
        if_div                TYPE zzdiv                         "区分.
        if_VrSetPrinter       TYPE any                           "VrSetPrinter.
          DEFAULT ',RDSpool'
        if_VrSetOutputPrinter TYPE any                           "VrSetOutputPrinter.
          OPTIONAL
        if_VrSetForm          TYPE any                           "VrSetForm.
          OPTIONAL
        if_OUTPUTSPOOLMODE    TYPE any                           "OUTPUTSPOOLMODE.
          DEFAULT '2'
      CHANGING
        ct_api                TYPE zif_zrap_com_00=>gtt_svf_api  "SVF API関数TBL.
*-< ADD V1.08 (S) >-*
        cs_out_parameter      TYPE zif_zrap_com_00=>gts_out_parameter
*-< ADD V1.08 (E) >-*
      RAISING
        cx_abap_context_info_error
        .

    "出力処理 パラメータ設定.
    CLASS-METHODS out_param_set
      IMPORTING
        if_div           TYPE zzdiv                         "区分.
        if_fileid        TYPE any                           "ファイルID.
        if_date          TYPE any                           "出力日付.
        if_time          TYPE any                           "出力時間.
      CHANGING
        cs_out_parameter TYPE zif_zrap_com_00=>gts_out_parameter
        .

*-< ADD V1.10 (S) >-*
    "ユーザ・初期値プリンタ取得.
    CLASS-METHODS user_default_printer_get
      RETURNING
        VALUE(rf_printer) TYPE ZI_UserPrinter_01-printer "プリンタID
        .
*-< ADD V1.10 (E) >-*

*-< ADD V1.11 (S) >-*
    METHODS field_set
      CHANGING
        cs_field  TYPE zif_zrap_com_00=>gts_svf_field_2.

    METHODS data_set
      IMPORTING
        is_data   TYPE zif_zrap_com_00=>gts_svf_data_2
      CHANGING
        cs_data   TYPE zif_zrap_com_00=>gts_svf_data_2.

    INTERFACES if_oo_adt_classrun .
*-< ADD V1.11 (E) >-*

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SVF_OUTPUT IMPLEMENTATION.


  METHOD data_set.
    CLEAR: cs_data.
    cs_data-field001 = 'Value001'    ##NO_TEXT.
    cs_data-field096 = 'Value097'    ##NO_TEXT.
    cs_data-field097 = 'Value097'    ##NO_TEXT.
    cs_data-field098 = 'Value098'    ##NO_TEXT.
    cs_data-field099 = 'Value099'    ##NO_TEXT.
    cs_data-field100 = 'Value_"_100' ##NO_TEXT.
    cs_data-field127 = 'Value127'    ##NO_TEXT.
    "cs_data-field200 = 'Value200'  .
  ENDMETHOD.


  METHOD field_set.
    CLEAR: cs_field.
    cs_field-field001 = 'ID001'.
    cs_field-field096 = 'ID096'.
    cs_field-field097 = 'ID097'.
    cs_field-field098 = 'ID098'.
    cs_field-field099 = 'ID099'.
    cs_field-field100 = 'ID100'.
    cs_field-field100 = 'ID127'.
    "cs_field-field200 = 'ID200'.
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

    DATA:
      lds_output     TYPE zif_zrap_com_00=>gts_svf_data_2,
      lds_svf_data   TYPE zif_zrap_com_00=>gts_svf_data_2,
      ldf_ds_err_msg TYPE string,
      BEGIN OF lds_out_dat,
        param  TYPE zif_zrap_com_00=>gts_out_parameter,
        api    TYPE zif_zrap_com_00=>gtt_svf_api,
        field  TYPE zif_zrap_com_00=>gts_svf_field_2,
        data   TYPE STANDARD TABLE OF zif_zrap_com_00=>gts_svf_data_2,
      END   OF lds_out_dat.

    TRY.
*      "【処理日時作成】.
*      zcl_zrap_com_00=>process_date_time_output(
*        IMPORTING
*          ef_date      = DATA(ldf_date)
*          ef_time      = DATA(ldf_time)
*          ef_timestamp = DATA(ldf_timestamp)
*        ).
*
*      "【ファイル 項目値設定】.
*      data_set(
*        EXPORTING
*          is_data = lds_output
*        CHANGING
*          cs_data = lds_svf_data
*        ).
*      APPEND lds_svf_data TO lds_out_dat-data.
*
*      "【出力処理 パラメータ設定】.
*      zcl_svf_output=>out_param_set(
*        EXPORTING
*          if_div                = 'VI910_2'
*          if_fileid             = 'VI910_02_TEST'
*          if_date               = ldf_date
*          if_time               = ldf_time
*        CHANGING
*          cs_out_parameter      = lds_out_dat-param
*        ).
*
*
*      "【ファイル 項目ID設定】.
*      field_set(
*        CHANGING
*          cs_field = lds_out_dat-field
*        ).
*
*      "【SVF データ連携処理】.
*      DATA(ldf_subrc) = zcl_svf_output=>svf_output_proc(
*        EXPORTING
*          if_div        = 'VI910_2'
*          is_out_dat    = lds_out_dat
*          if_com_os_div = 'ZCL_SVF_OUTPUT_2'
*        IMPORTING
*          ef_ds_err_msg = ldf_ds_err_msg
*        ).


    "【例外処理】.
    CATCH cx_http_dest_provider_error INTO DATA(lds_cx_http_dest_provider_err) ##NO_HANDLER.

    CATCH cx_web_http_client_error INTO DATA(lds_cx_web_http_client_error) ##NO_HANDLER.

    CATCH cx_abap_context_info_error INTO DATA(lds_cx_abap_context_info_error) ##NO_HANDLER.

    CATCH zcx_no_data INTO DATA(lds_zcx_no_data) ##NO_HANDLER.

    ENDTRY.
  ENDMETHOD.


  METHOD out_param_set.
*-< ADD V1.12 (S) >-*
    DATA:ldf_datetime(14) TYPE C.
    CLEAR:ldf_datetime.
*-< ADD V1.12 (E) >-*

*-< ADD V1.01 (S) >-*
    "パラメータテーブル取得(共通).
    "種別：B、連番：1でエントリを登録する.
    SELECT  SINGLE *
      FROM  zy043t
      WHERE div     = @if_div
        AND zztype  = 'B'
        AND zzseqno = '0001'
      INTO @DATA(lds_zy043t).

    IF sy-subrc = 0.
*-< UPD V1.04 (S) >-*
*      "【Job ID（UCX Single起動引数）】.
*      cs_out_parameter-svfjobid = lds_zy043t-zzvalue01.
*      "【対象ディレクトリ（UCX Single起動引数）】.
**      CONCATENATE lds_zy043t-zzvalue02 lds_zy043t-zzvalue03 lds_zy043t-zzvalue04 INTO DATA(ldf_filedir).
**      cs_out_parameter-filedir = ldf_filedir.
**-< ADD V1.02 (S) >-*
*      "【起動タイプ（例：SVF = SVF）】.
*      cs_out_parameter-processtype = lds_zy043t-zzvalue05.
**-< ADD V1.02 (E) >-*
**-< ADD V1.03 (S) >-*
*      "【呼び出すスクリプト名】.
*      cs_out_parameter-scriptname = lds_zy043t-zzvalue06.
**-< ADD V1.03 (E) >-*
      "【区切り文字の形式】
      cs_out_parameter-delimiter = lds_zy043t-zzvalue01.
      "【文字コード】.
      cs_out_parameter-charcode = lds_zy043t-zzvalue02.
      "【呼び出すスクリプト名】.
      cs_out_parameter-scriptname = lds_zy043t-zzvalue03.
      "【起動タイプ（例：SVF = SVF）】.
      cs_out_parameter-processtype = lds_zy043t-zzvalue04.
      "【Job ID（UCX Single起動引数）】.
      cs_out_parameter-svfjobid = lds_zy043t-zzvalue05.
*-< UPD V1.04 (E) >-*
*-< ADD V1.06 (S) >-*
      "【ヘッダーフラグ】.
      cs_out_parameter-headerflg = lds_zy043t-zzvalue06.
*-< ADD V1.06 (E) >-*
    ENDIF.
*-< ADD V1.01 (E) >-*

*-< ADD V1.04 (S) >-*
    "パラメータテーブル取得(共通).
    "種別：C、連番：1でエントリを登録する.
*-< UPD V1.09 (S) >-*
*    SELECT  SINGLE *
    SELECT  SINGLE
      client,
      div,
      zztype,
      zzseqno,
      zztypename,
      zzvalue01,
      zzvalue02,
      zzvalue03,
      zzvalue04,
      zzvalue05,
      zzvalue06,
      zzvalue07,
      zzvalue08,
      last_changed_at,
      local_last_changed_at
*-< UPD V1.09 (E) >-*
      FROM  zy043t
      WHERE div     = @if_div
        AND zztype  = 'C'
        AND zzseqno = '0001'
      INTO @DATA(lds_zy043t_1).

    IF sy-subrc = 0.
      "【ファイル出力ディレクトリ】.
      CONCATENATE lds_zy043t_1-zzvalue01 lds_zy043t_1-zzvalue02 lds_zy043t_1-zzvalue03 INTO DATA(ldf_filedir).
      cs_out_parameter-filedir = ldf_filedir.
    ENDIF.
*-< ADD V1.04 (E) >-*

    "【ファイル名】.
    CASE if_div.
        "【固有命名規約】.
        " ※区分毎にCASEを記載.
*-< ADD V1.07 (S) >-*
      WHEN zif_zrap_com_00=>gcs_div-zrap_tpl_vi901.
        "現行と同じ固定名称をセット.
        cs_out_parameter-filename = 'SD_IEB0011.TXT'.

*-< ADD V1.07 (E) >-*
*-< ADD V1.12 (S) >-*
      WHEN zif_zrap_com_00=>gcs_div-zrap_tpl_vi910_1
        OR zif_zrap_com_00=>gcs_div-zrap_tpl_vi910_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_mi901_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_mi901_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_mi902_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_mi902_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_mi902_3
        OR zif_zrap_com_00=>gcs_div-zrap_if_mi903_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_mi903_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_mi904_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_mi904_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_mi904_3
        OR zif_zrap_com_00=>gcs_div-zrap_if_mi904_4
        OR zif_zrap_com_00=>gcs_div-zrap_if_mi905_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_mi906_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_vi912_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_vi912_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_vi913_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_vi913_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_vi914_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_vi914_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_vi914_3
        OR zif_zrap_com_00=>gcs_div-zrap_if_vi914_4
        OR zif_zrap_com_00=>gcs_div-zrap_if_pi902_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_pi902_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_pi903_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_pi903_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_pi904_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_pi904_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_pi904_3
        OR zif_zrap_com_00=>gcs_div-zrap_if_pi905_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi926_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi926_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi926_3
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi926_4
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi926_5
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi926_6
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi926_7
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi926_8
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi927_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi927_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi927_3
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi927_4
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi927_5
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi927_6
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi927_7
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi927_8
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi927_9
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi927_A
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi927_B
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi927_C
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi928_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi928_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi929_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi930_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi930_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi930_3
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi930_4
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi931_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi931_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi932_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi932_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi933_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi933_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi934_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi935_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi935_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi936_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi937_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi937_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi938_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi938_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi938_3
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi939_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi942_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi943_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi944_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi946_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi947_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi948_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi949_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi950_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi951_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi952_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi952_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi952_3
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi953_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_yi954_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_ci901_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_ci902_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_ci902_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_ci903_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_ci903_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_ci904_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_ci904_2
        OR zif_zrap_com_00=>gcs_div-zrap_if_ci905_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_ci906_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_fi901_1
        OR zif_zrap_com_00=>gcs_div-zrap_if_fi901_2
        .

        CONCATENATE if_date "日付
                    if_time "時間
               INTO ldf_datetime.

        "出力ファイル・命名規約.
        CONCATENATE:if_fileid                 "ファイルID
                    ldf_datetime
               INTO cs_out_parameter-filename
          SEPARATED BY '_',                   "_区切り
                    cs_out_parameter-filename
                    '.csv'                    "拡張子.
               INTO cs_out_parameter-filename.

*-< ADD V1.12 (E) >-*
        "【共通命名規約】.
      WHEN OTHERS.
        "出力ファイル・命名規約.
        CONCATENATE:if_fileid                 "ファイルID
                    if_date                   "日付
                    if_time                   "時間
                    sy-uname                  "SAPユーザID
               INTO cs_out_parameter-filename
          SEPARATED BY '_',                   "_区切り
                    cs_out_parameter-filename
                    '.txt'                    "拡張子.
               INTO cs_out_parameter-filename.
    ENDCASE.

*-< ADD V1.08 (S) >-*
    "【機能実行日時】.
    CONCATENATE if_date if_time INTO DATA(ldf_sapsystime).
    cs_out_parameter-sapsystime = ldf_sapsystime.
*-< ADD V1.08 (E) >-*

  ENDMETHOD.


  METHOD svf_api_set.

    "ローカル宣言.
    DATA:
      lds_svf_api TYPE zif_zrap_com_00=>gts_svf_api.
    CLEAR:
      lds_svf_api.

    "出力イメージ.
    "<start>.
    "VrSetPrinter=",RDSpool"                    .
    "VrSetOutputPrinter=PDF_1                   .
    "VrSetForm=ZFIR0020_01.XML,4                .
    "OUTPUTSPOOLMODE=2                          .
*-< UPD V1.08 (S) >-*
*    "VrSetUserName="Test User"                  .
* -> メールアドレスに変更
    "VrSetUserName="tadanori.miura@ips.ne.jp"   .
*-< UPD V1.08 (E) >-*
    "VrSetDocName2="会計伝票印刷"               .
    "VrSetComputer="my405871.s4hana.cloud.sap"  .
    "<end>                                      .

    TRY.
        "【<start>】.
        lds_svf_api-value = '<start>'.
        APPEND lds_svf_api TO ct_api.

        "【VrSetPrinter=】.
        CONCATENATE 'VrSetPrinter='
                    '"'
                    if_vrsetprinter
                    '"'
               INTO lds_svf_api-value.
        APPEND lds_svf_api TO ct_api.

        "【VrSetOutputPrinter=】.
        "スプール完了の場合、プリンタ指定は不要.
        IF if_vrsetoutputprinter = 'SPOOL'.
        ELSE.
          CONCATENATE 'VrSetOutputPrinter='
                      '"'
                      if_vrsetoutputprinter
                      '"'
                 INTO lds_svf_api-value.
          APPEND lds_svf_api TO ct_api.
        ENDIF.

        "【VrSetForm=】.
        SELECT SINGLE *
          FROM zy201t
         WHERE div    = @if_div
           AND formid = @if_vrsetform
          INTO @DATA(lds_zy201t)
             .
        CONCATENATE 'VrSetForm='
                    '"'
                    lds_zy201t-formid
                    ','
                    lds_zy201t-sort_flg
                    '"'
               INTO lds_svf_api-value.
        APPEND lds_svf_api TO ct_api.

        "【OUTPUTSPOOLMODE=】.
        CONCATENATE 'OUTPUTSPOOLMODE='
                    '"'
                    if_outputspoolmode
                    '"'
               INTO lds_svf_api-value.
        APPEND lds_svf_api TO ct_api.

        "【VrSetDocName2=】.
        CONCATENATE 'VrSetDocName2='
                    '"'
                    lds_zy201t-formname
                    '"'
               INTO lds_svf_api-value.
        APPEND lds_svf_api TO ct_api.

*-< ADD V1.08 (S) >-*
        "【帳票名】.
        cs_out_parameter-docname = lds_zy201t-formname.

        "ログインユーザからメールアドレスを取得する
        SELECT SINGLE _User~userid,
                      _Mail~EmailAddress
          FROM        I_user                       AS _User
          INNER JOIN  I_AddrCurDefaultEmailAddress AS _Mail
          ON          _User~AddressPersonID = _Mail~AddressPersonID
          AND         _User~AddressID       = _Mail~AddressID
          WHERE userid = @sy-uname
          INTO @DATA(lds_user_mail)
          PRIVILEGED ACCESS.
*-< ADD V1.08 (E) >-*

        "【VrSetUserName=】.
        DATA(ldf_VrSetUserName) = cl_abap_context_info=>get_user_description( ).
        CONCATENATE 'VrSetUserName='
                    '"'
*-< UPD V1.08 (S) >-*
*                  ldf_VrSetUserName
*->メールアドレスに変更
                    lds_user_mail-EmailAddress
*-< UPD V1.08 (E) >-*
                    '"'
               INTO lds_svf_api-value.
        APPEND lds_svf_api TO ct_api.

*-< ADD V1.08 (S) >-*
        "【メールアドレス】.
        cs_out_parameter-mailaddress = lds_user_mail-EmailAddress.
*-< ADD V1.08 (E) >-*

        "【VrSetComputer=】.
        DATA(ldf_VrSetComputer) = cl_abap_context_info=>get_system_url( ).
        CONCATENATE 'VrSetComputer='
                  '"'
                  ldf_VrSetComputer
                  '"'
             INTO lds_svf_api-value.
        APPEND lds_svf_api TO ct_api.

        "【<end>】.
        lds_svf_api-value = '<end>'.
        APPEND lds_svf_api TO ct_api.

      CATCH cx_abap_context_info_error INTO DATA(lds_cx_abap_context_info_error).
        RAISE EXCEPTION TYPE cx_abap_context_info_error
          MESSAGE
               ID lds_cx_abap_context_info_error->if_t100_message~t100key-msgid
             TYPE lds_cx_abap_context_info_error->if_t100_dyn_msg~msgty
           NUMBER lds_cx_abap_context_info_error->if_t100_message~t100key-msgno
             WITH lds_cx_abap_context_info_error->if_t100_dyn_msg~msgv1
                  lds_cx_abap_context_info_error->if_t100_dyn_msg~msgv2
                  lds_cx_abap_context_info_error->if_t100_dyn_msg~msgv3
                  lds_cx_abap_context_info_error->if_t100_dyn_msg~msgv4
                  .
    ENDTRY.

  ENDMETHOD.


  METHOD svf_output_proc.

    "ローカル宣言.
    DATA:
      l_cscn      TYPE if_com_scenario_factory=>ty_query-cscn_id_range,
      ldf_commscn TYPE if_com_management=>ty_cscn_id.                    "通信シナリオ.
    CLEAR:
      ldf_commscn.

    "接続先取得.
*-< UPD V1.09 (S) >-*
*    SELECT  SINGLE *
    SELECT SINGLE
      client,
      div,
      zztype,
      zzseqno,
      zztypename,
      zzvalue01,
      zzvalue02,
      zzvalue03,
      zzvalue04,
      zzvalue05,
      zzvalue06,
      zzvalue07,
      zzvalue08,
      last_changed_at,
      local_last_changed_at
*-< UPD V1.09 (E) >-*
      FROM  zy043t
      WHERE div     = @if_div
        AND zztype  = 'A'
        AND zzseqno = '1'
       INTO @DATA(lds_zy043t_div_a)
          .
    "取得に失敗した場合、エラー処理.
    IF sy-subrc = 0.
      ldf_commscn = lds_zy043t_div_a-zzvalue01.
    ELSE.
      ef_subrc = 8.
      RAISE EXCEPTION TYPE zcx_no_data
        MESSAGE e000(zrap_com_00)
           WITH TEXT-002
                if_div
                .
    ENDIF.

    "パラメータテーブル取得(共通).
*-< UPD V1.09 (S) >-*
*    SELECT  *
    SELECT
      client,
      div,
      zztype,
      zzseqno,
      zztypename,
      zzvalue01,
      zzvalue02,
      zzvalue03,
      zzvalue04,
      zzvalue05,
      zzvalue06,
      zzvalue07,
      zzvalue08,
      last_changed_at,
      local_last_changed_at
*-< UPD V1.09 (E) >-*
      FROM  zy043t
*-< UPD V1.11 (S) >-*
     "WHERE div     = 'ZCL_SVF_OUTPUT'
      WHERE div     = @if_com_os_div
*-< UPD V1.11 (E) >-*
       INTO TABLE @DATA(ldt_zy043t)
          .
    IF sy-subrc = 0.
      SORT ldt_zy043t STABLE
        BY zztype  ASCENDING
           zzseqno ASCENDING.
    ELSE.
      ef_subrc = 8.
      RAISE EXCEPTION TYPE zcx_no_data
        MESSAGE e001(zrap_com_00)
           WITH TEXT-001
                ldf_commscn
           .
    ENDIF.

    TRY.
        "通信シナリオ取得.
        l_cscn = VALUE #( (
          sign   = 'I'
          option = 'EQ'
          low    = ldf_commscn
          ) ).
        DATA(l_factory) = cl_com_arrangement_factory=>create_instance( ).

        l_factory->query_ca(
          EXPORTING
            is_query           = VALUE #( cscn_id_range = l_cscn )
          IMPORTING
            et_com_arrangement = DATA(ldt_ca) ).

        "取得に失敗した場合、エラー処理.
        IF ldt_ca IS INITIAL.
          ef_subrc = 8.
          RAISE EXCEPTION TYPE zcx_no_data
            MESSAGE e001(zrap_com_00)
               WITH TEXT-001
                    ldf_commscn
               .
        ENDIF.

        "COM Outbound Services取得.
        READ TABLE ldt_zy043t INTO DATA(lds_zy043t_a)
          WITH KEY zztype = 'A'
          BINARY SEARCH.
        IF sy-subrc = 0.
          DATA:
            ldf_service_id TYPE if_com_management=>ty_cscn_outb_srv_id.
          ldf_service_id = lds_zy043t_a-zzvalue01.
        ELSE.
        ENDIF.

        READ TABLE ldt_ca INTO DATA(lds_ca)
          INDEX 1.
        DATA(l_dest) = cl_http_destination_provider=>create_by_comm_arrangement(
          comm_scenario  = ldf_commscn
          "service_id     = 'ZBTP_SFTP_REST'
          service_id     = ldf_service_id
          comm_system_id = lds_ca->get_comm_system_id( )
          ).

        DATA(l_http_client) = cl_web_http_client_manager=>create_by_http_destination( l_dest ).
        DATA(l_request) = l_http_client->get_http_request( ).

        "JSON変換処理.
        DATA(ldf_json_data) = xco_cp_json=>data->from_abap( is_out_dat )->to_string( ).
        l_request->append_text( ldf_json_data ).

        "HTTPヘッダ設定.
        "※下記がないと、JSONとDataSpider側で認識されないため.
        l_request->set_header_field(
          i_name  = 'Content-Type'      ##NO_TEXT
          i_value = 'application/json'  ##NO_TEXT
          ).

        "通信処理実行.
*-< UPD V1.13 (S) >-*
        "DATA(lo_response) = l_http_client->execute( if_web_http_client=>get ).
        DO.
          TRY.
            DATA(lo_response) = l_http_client->execute( if_web_http_client=>get ).
            EXIT.

          CATCH cx_web_http_client_error INTO DATA(lds_cx_web_http_client_err_do).
            MESSAGE
                 ID lds_cx_web_http_client_err_do->if_t100_message~t100key-msgid
               TYPE lds_cx_web_http_client_err_do->if_t100_dyn_msg~msgty
             NUMBER lds_cx_web_http_client_err_do->if_t100_message~t100key-msgno
               WITH lds_cx_web_http_client_err_do->if_t100_dyn_msg~msgv1
                    lds_cx_web_http_client_err_do->if_t100_dyn_msg~msgv2
                    lds_cx_web_http_client_err_do->if_t100_dyn_msg~msgv3
                    lds_cx_web_http_client_err_do->if_t100_dyn_msg~msgv4
               INTO DATA(ldf_cx_web_http_client_error)
                    .

            IF ldf_cx_web_http_client_error = gds_ssl_err-p1
*-< ADD V1.14 (S) >-*
            OR ldf_cx_web_http_client_error = gds_ssl_err-p2
*-< ADD V1.14 (E) >-*
*-< ADD V1.15 (S) >-*
            OR ldf_cx_web_http_client_error = gds_ssl_err-p3
*-< ADD V1.15 (E) >-*
*-< ADD V1.18 (S) >-*
            OR ldf_cx_web_http_client_error CP gds_ssl_err-p4
            OR ldf_cx_web_http_client_error CP gds_ssl_err-p5
*-< ADD V1.18 (E) >-*
              .
*-< ADD V1.17 (S) >-*
               ef_cause_msg = ldf_cx_web_http_client_error.
*-< ADD V1.17 (E) >-*

*-< UPD V1.16 (S) >-*
*              IF ef_retry_cnt <= 10.
              IF ef_retry_cnt <= gdf_retry_cnt.
*-< UPD V1.16 (E) >-*
                ef_retry_cnt = ef_retry_cnt + 1.
                ef_warm_msg  = 'cx_web_http_client_error'.
*-< UPD V1.16 (S) >-*
*                WAIT UP TO 1 SECONDS.
                WAIT UP TO gdf_wait SECONDS.
*-< UPD V1.16 (E) >-*
                CONTINUE.
              ELSE.
              ENDIF.
            ELSE.
            ENDIF.

            ef_subrc = 8.
            RAISE EXCEPTION TYPE cx_http_dest_provider_error
              MESSAGE
                   ID lds_cx_web_http_client_err_do->if_t100_message~t100key-msgid
                 TYPE lds_cx_web_http_client_err_do->if_t100_dyn_msg~msgty
               NUMBER lds_cx_web_http_client_err_do->if_t100_message~t100key-msgno
                 WITH lds_cx_web_http_client_err_do->if_t100_dyn_msg~msgv1
                      lds_cx_web_http_client_err_do->if_t100_dyn_msg~msgv2
                      lds_cx_web_http_client_err_do->if_t100_dyn_msg~msgv3
                      lds_cx_web_http_client_err_do->if_t100_dyn_msg~msgv4
                      .

          CATCH cx_http_dest_provider_error INTO DATA(lds_cx_http_dest_prov_err_do).
            MESSAGE
                 ID lds_cx_http_dest_prov_err_do->if_t100_message~t100key-msgid
               TYPE lds_cx_http_dest_prov_err_do->if_t100_dyn_msg~msgty
             NUMBER lds_cx_http_dest_prov_err_do->if_t100_message~t100key-msgno
               WITH lds_cx_http_dest_prov_err_do->if_t100_dyn_msg~msgv1
                    lds_cx_http_dest_prov_err_do->if_t100_dyn_msg~msgv2
                    lds_cx_http_dest_prov_err_do->if_t100_dyn_msg~msgv3
                    lds_cx_http_dest_prov_err_do->if_t100_dyn_msg~msgv4
               INTO DATA(ldf_cx_http_dest_provider_err)
                    .
            IF ldf_cx_http_dest_provider_err = gds_ssl_err-p1
*-< ADD V1.14 (S) >-*
            OR ldf_cx_http_dest_provider_err = gds_ssl_err-p2
*-< ADD V1.14 (E) >-*
*-< ADD V1.15 (S) >-*
            OR ldf_cx_http_dest_provider_err = gds_ssl_err-p3
*-< ADD V1.15 (E) >-*
*-< ADD V1.18 (S) >-*
            OR ldf_cx_web_http_client_error CP gds_ssl_err-p4
            OR ldf_cx_web_http_client_error CP gds_ssl_err-p5
*-< ADD V1.18 (E) >-*
              .
*-< ADD V1.17 (S) >-*
               ef_cause_msg = ldf_cx_http_dest_provider_err.
*-< ADD V1.17 (E) >-*

*-< UPD V1.16 (S) >-*
*              IF ef_retry_cnt <= 10.
              IF ef_retry_cnt <= gdf_retry_cnt.
*-< UPD V1.16 (E) >-*
                ef_retry_cnt = ef_retry_cnt + 1.
                ef_warm_msg  = 'cx_http_dest_provider_error'.
*-< UPD V1.16 (S) >-*
*                WAIT UP TO 1 SECONDS.
                WAIT UP TO gdf_wait SECONDS.
*-< UPD V1.16 (E) >-*
                CONTINUE.
              ELSE.
              ENDIF.
            ELSE.
            ENDIF.

            ef_subrc = 8.
            RAISE EXCEPTION TYPE cx_http_dest_provider_error
              MESSAGE
                   ID lds_cx_http_dest_prov_err_do->if_t100_message~t100key-msgid
                 TYPE lds_cx_http_dest_prov_err_do->if_t100_dyn_msg~msgty
               NUMBER lds_cx_http_dest_prov_err_do->if_t100_message~t100key-msgno
                 WITH lds_cx_http_dest_prov_err_do->if_t100_dyn_msg~msgv1
                      lds_cx_http_dest_prov_err_do->if_t100_dyn_msg~msgv2
                      lds_cx_http_dest_prov_err_do->if_t100_dyn_msg~msgv3
                      lds_cx_http_dest_prov_err_do->if_t100_dyn_msg~msgv4
                      .

          CATCH cx_web_message_error INTO DATA(lds_cx_web_message_err_do).
            MESSAGE
                 ID lds_cx_web_message_err_do->if_t100_message~t100key-msgid
               TYPE lds_cx_web_message_err_do->if_t100_dyn_msg~msgty
             NUMBER lds_cx_web_message_err_do->if_t100_message~t100key-msgno
               WITH lds_cx_web_message_err_do->if_t100_dyn_msg~msgv1
                    lds_cx_web_message_err_do->if_t100_dyn_msg~msgv2
                    lds_cx_web_message_err_do->if_t100_dyn_msg~msgv3
                    lds_cx_web_message_err_do->if_t100_dyn_msg~msgv4
               INTO DATA(ldf_cx_web_message_error)
                    .
            IF ldf_cx_web_message_error = gds_ssl_err-p1
*-< ADD V1.14 (S) >-*
            OR ldf_cx_web_message_error = gds_ssl_err-p2
*-< ADD V1.14 (E) >-*
*-< ADD V1.15 (S) >-*
            OR ldf_cx_web_message_error = gds_ssl_err-p3
*-< ADD V1.15 (E) >-*
*-< ADD V1.18 (S) >-*
            OR ldf_cx_web_http_client_error CP gds_ssl_err-p4
            OR ldf_cx_web_http_client_error CP gds_ssl_err-p5
*-< ADD V1.18 (E) >-*
              .
*-< ADD V1.17 (S) >-*
               ef_cause_msg = ldf_cx_web_message_error.
*-< ADD V1.17 (E) >-*

*-< UPD V1.16 (S) >-*
*              IF ef_retry_cnt <= 10.
              IF ef_retry_cnt <= gdf_retry_cnt.
*-< UPD V1.16 (E) >-*
                ef_retry_cnt = ef_retry_cnt + 1.
                ef_warm_msg  = 'cx_web_message_error'.
*-< UPD V1.16 (S) >-*
*                WAIT UP TO 1 SECONDS.
                WAIT UP TO gdf_wait SECONDS.
*-< UPD V1.16 (E) >-*
                CONTINUE.
              ELSE.
              ENDIF.
            ELSE.
            ENDIF.

            ef_subrc = 8.
            RAISE EXCEPTION TYPE zcx_no_data
              MESSAGE
                   ID lds_cx_web_message_err_do->if_t100_message~t100key-msgid
                 TYPE lds_cx_web_message_err_do->if_t100_dyn_msg~msgty
               NUMBER lds_cx_web_message_err_do->if_t100_message~t100key-msgno
                 WITH lds_cx_web_message_err_do->if_t100_dyn_msg~msgv1
                      lds_cx_web_message_err_do->if_t100_dyn_msg~msgv2
                      lds_cx_web_message_err_do->if_t100_dyn_msg~msgv3
                      lds_cx_web_message_err_do->if_t100_dyn_msg~msgv4
                      .

          CATCH cx_root INTO DATA(lds_cx_root_do).
            DATA(ldf_cx_root_do_get_text) = lds_cx_root_do->if_message~get_longtext( ).

            IF ldf_cx_root_do_get_text = gds_ssl_err-p1
*-< ADD V1.14 (S) >-*
            OR ldf_cx_root_do_get_text = gds_ssl_err-p2
*-< ADD V1.14 (E) >-*
*-< ADD V1.15 (S) >-*
            OR ldf_cx_root_do_get_text = gds_ssl_err-p3
*-< ADD V1.15 (E) >-*
*-< ADD V1.18 (S) >-*
            OR ldf_cx_web_http_client_error CP gds_ssl_err-p4
            OR ldf_cx_web_http_client_error CP gds_ssl_err-p5
*-< ADD V1.18 (E) >-*
              .
*-< ADD V1.17 (S) >-*
               ef_cause_msg = ldf_cx_root_do_get_text.
*-< ADD V1.17 (E) >-*

*-< UPD V1.16 (S) >-*
*              IF ef_retry_cnt <= 10.
              IF ef_retry_cnt <= gdf_retry_cnt.
*-< UPD V1.16 (E) >-*
                ef_retry_cnt = ef_retry_cnt + 1.
                ef_warm_msg  = 'cx_root'.
*-< UPD V1.16 (S) >-*
*                WAIT UP TO 1 SECONDS.
                WAIT UP TO gdf_wait SECONDS.
*-< UPD V1.16 (E) >-*
                CONTINUE.
              ELSE.
              ENDIF.
            ELSE.
            ENDIF.

            ef_subrc = 8.
            RAISE EXCEPTION TYPE zcx_no_data
              MESSAGE e001(zrap_com_00)
                 WITH ldf_cx_root_do_get_text
                    .
          ENDTRY.
        ENDDO.
*-< UPD V1.13 (E) >-*

        "実行結果判定.
        DATA(http_status_code) = lo_response->get_status( ).
        DATA(response) =  lo_response->get_text( ).

        IF http_status_code-code = '200'.
*-< ADD V1.04 (S) >-*
          xco_cp_json=>data->from_string( response )->write_to( REF #( zcl_svf_output=>gdt_ds_result_info ) ).
          READ TABLE gdt_ds_result_info INDEX 1 INTO DATA(lds_ds_result_info).

          IF sy-subrc = 0.
            IF lds_ds_result_info-msg = 'NG'.
              ef_subrc = 8.

              CASE lds_ds_result_info-errcode.
                WHEN 'E01'.
                  MESSAGE e003(zrap_com_00) INTO ef_ds_err_msg.
                WHEN 'E02'.
                  MESSAGE e004(zrap_com_00) INTO ef_ds_err_msg.
                WHEN 'E03'.
                  FIND '[' IN lds_ds_result_info-errmsg MATCH OFFSET DATA(s_off) MATCH LENGTH DATA(s_len).
                  IF sy-subrc = 0.
                    FIND ']' IN lds_ds_result_info-errmsg MATCH OFFSET DATA(e_off) MATCH LENGTH DATA(e_len).
                    IF sy-subrc = 0.
                      DATA(lds_get_len) = e_off - s_off - 1.
                      DATA(lds_get_s_lo) = s_off + 1.
                      DATA(lds_svf_status_code) = lds_ds_result_info-errmsg+lds_get_s_lo(lds_get_len).
                      MESSAGE e005(zrap_com_00) WITH lds_svf_status_code INTO ef_ds_err_msg.
                    ENDIF.
                  ENDIF.

                  IF sy-subrc <> 0.
                    MESSAGE e005(zrap_com_00) WITH space INTO ef_ds_err_msg.
                  ENDIF.
*-< ADD V1.05 (S) >-*
                WHEN 'E04'.
                  MESSAGE e021(zrap_com_00) INTO ef_ds_err_msg.
                WHEN 'E05'.
                  MESSAGE e022(zrap_com_00) INTO ef_ds_err_msg.
*-< ADD V1.05 (E) >-*
*-< ADD V1.19 (S) >-*
                WHEN 'E06'.
                  MESSAGE e032(zrap_com_00) INTO ef_ds_err_msg.
*-< ADD V1.19 (E) >-*
                WHEN OTHERS.
              ENDCASE.

            ENDIF.
          ENDIF.
*-< ADD V1.04 (E) >-*
        ELSE.
          ef_subrc = 8.
        ENDIF.

        "Exception
      CATCH cx_http_dest_provider_error INTO DATA(lds_cx_http_dest_provider_err).
        ef_subrc = 8.
        RAISE EXCEPTION TYPE cx_http_dest_provider_error
          MESSAGE
               ID lds_cx_http_dest_provider_err->if_t100_message~t100key-msgid
             TYPE lds_cx_http_dest_provider_err->if_t100_dyn_msg~msgty
           NUMBER lds_cx_http_dest_provider_err->if_t100_message~t100key-msgno
             WITH lds_cx_http_dest_provider_err->if_t100_dyn_msg~msgv1
                  lds_cx_http_dest_provider_err->if_t100_dyn_msg~msgv2
                  lds_cx_http_dest_provider_err->if_t100_dyn_msg~msgv3
                  lds_cx_http_dest_provider_err->if_t100_dyn_msg~msgv4
                  .

      CATCH cx_web_http_client_error INTO DATA(lds_cx_web_http_client_error).
        ef_subrc = 8.
        RAISE EXCEPTION TYPE zcx_no_data
          MESSAGE
               ID lds_cx_web_http_client_error->if_t100_message~t100key-msgid
             TYPE lds_cx_web_http_client_error->if_t100_dyn_msg~msgty
           NUMBER lds_cx_web_http_client_error->if_t100_message~t100key-msgno
             WITH lds_cx_web_http_client_error->if_t100_dyn_msg~msgv1
                  lds_cx_web_http_client_error->if_t100_dyn_msg~msgv2
                  lds_cx_web_http_client_error->if_t100_dyn_msg~msgv3
                  lds_cx_web_http_client_error->if_t100_dyn_msg~msgv4
                  .

      CATCH cx_web_message_error INTO DATA(lds_cx_web_message_error).
        ef_subrc = 8.
        RAISE EXCEPTION TYPE zcx_no_data
          MESSAGE
               ID lds_cx_web_message_error->if_t100_message~t100key-msgid
             TYPE lds_cx_web_message_error->if_t100_dyn_msg~msgty
           NUMBER lds_cx_web_message_error->if_t100_message~t100key-msgno
             WITH lds_cx_web_message_error->if_t100_dyn_msg~msgv1
                  lds_cx_web_message_error->if_t100_dyn_msg~msgv2
                  lds_cx_web_message_error->if_t100_dyn_msg~msgv3
                  lds_cx_web_message_error->if_t100_dyn_msg~msgv4
                  .

      CATCH cx_root INTO DATA(lds_cx_root).
        ef_subrc = 8.
        DATA(ldf_cx_root_get_text) = lds_cx_root->if_message~get_longtext( ).
        RAISE EXCEPTION TYPE zcx_no_data
          MESSAGE e001(zrap_com_00)
             WITH ldf_cx_root_get_text
                .

    ENDTRY.

  ENDMETHOD.


  METHOD user_default_printer_get.

    DATA:
      ldf_printer TYPE ZI_UserPrinter_01-printer.
    CLEAR:
      ldf_printer.

    "ユーザに設定されているデフォルトプリンタを取得.
    SELECT  SINGLE
            printer
      FROM  ZI_UserPrinter_01
      WHERE zzdefault = 'X'
      INTO  @ldf_printer
      .
    IF sy-subrc = 0.
    ELSE.
      "取得に失敗した場合、PDFの値を初期値として提案.
      SELECT  SINGLE
              printer
        FROM  ZI_UserPrinter_01
        WHERE zzdefault = 'P'
        INTO  @ldf_printer
        .
    ENDIF.

    "取得した値を返す.
    rf_printer = ldf_printer.

  ENDMETHOD.
ENDCLASS.
