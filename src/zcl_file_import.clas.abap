************************************************************************
*  [変更履歴]                                                          *
*   バージョン情報 ：V1.00  2024/07/21  T.MIURA            XW2K900320  *
*   変更内容       ：新規作成                                          *
*----------------------------------------------------------------------*
*   バージョン情報 ：V9.99  YYYY/MM/DD  変更者             移送番号    *
*   変更内容       ：                                                  *
************************************************************************
CLASS zcl_file_import DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
*** 【T Y P E S宣言】 ***
    TYPES:
      gts_tbl              TYPE zif_zrap_com_00=>gts_import_file_field,
      gts_data_table_strct TYPE string.

    TYPES: BEGIN OF gts_ds_result_err, "DataSpiderエラー構造
      errmsg  TYPE string, "エラーメッセージ.
      errtype TYPE string, "エラータイプ.
      errcode TYPE string, "エラーコード（ロジックで個別に実装したもの）.
    END OF gts_ds_result_err.

    TYPES:
      gtt_file_list     TYPE TABLE OF zif_zrap_com_00=>gts_import_file_list,
      gtt_tbl           TYPE TABLE OF gts_tbl,
      gtt_ds_result_err TYPE TABLE OF gts_ds_result_err.

*** 【D A T A宣言】 ***
    CLASS-DATA:
      gdt_file_list        TYPE gtt_file_list,
      gdt_tbl              TYPE gtt_tbl,
      gds_data_table_strct TYPE gts_data_table_strct,
      gds_ds_result_err    TYPE gts_ds_result_err.

*** 【クラスメソッド】 ***
    "サーバーファイルリスト取得.
    CLASS-METHODS get_filelist_from_server
      IMPORTING
        if_div          TYPE zzdiv          "区分.
        is_import_param TYPE any            "取込パラメータ構造.
      EXPORTING
        et_file_list    TYPE STANDARD TABLE "取得ファイルリストテーブル.
        ef_ds_err_msg   TYPE string         "DataSpiderエラーメッセージ.
      RAISING
        cx_http_dest_provider_error
        zcx_no_data
       .

    "サーバーファイル取込.
    CLASS-METHODS import_file_from_server
      IMPORTING
        if_div          TYPE zzdiv          "区分.
        is_import_param TYPE any            "パラメータ構造.
      EXPORTING
        et_data_table   TYPE STANDARD TABLE "ファイル内容転送テーブル.
        ef_ds_err_msg   TYPE string         "DataSpiderエラーメッセージ.
      CHANGING
        cs_data_strct   TYPE any            "ファイル内容転送テーブルのヘッダ構造.
      RAISING
        cx_http_dest_provider_error
        zcx_no_data
        cx_sy_conversion_no_number
       .

    "HTTP Client取得.
    CLASS-METHODS get_http_client
      IMPORTING
        if_div         TYPE zzdiv                         "区分.
        if_type        TYPE zztype                        "種別.
        if_commscn     TYPE if_com_management=>ty_cscn_id "接続先ID.
      EXPORTING
        eo_http_client TYPE REF TO if_web_http_client     "HTTP Client.
      RAISING
        cx_http_dest_provider_error
        zcx_no_data
       .

    "インポートファイル パラメータ設定.
    CLASS-METHODS set_import_param
      IMPORTING
        if_div          TYPE zzdiv                                 "区分.
      CHANGING
        cs_import_param TYPE zif_zrap_com_00=>gts_import_parameter "パラメータ構造体.
      RAISING
        zcx_no_data
       .

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FILE_IMPORT IMPLEMENTATION.


  METHOD get_filelist_from_server.

    TRY.

      "HTTP Client取得.
      get_http_client(
        EXPORTING
          if_div     = if_div
          if_type    = 'B'
          if_commscn = 'ZEAI_FILELIST_GET'
        IMPORTING
          eo_http_client = DATA(ldo_http_client)
      ).

      DATA(ldo_request) = ldo_http_client->get_http_request( ).
      "JSON変換処理
      DATA(ldf_json_data) = xco_cp_json=>data->from_abap( is_import_param )->to_string( ).
      ldo_request->append_text( ldf_json_data ).
      ldo_request->set_header_field(
        i_name  = 'Content-Type'     ##NO_TEXT
        i_value = 'application/json' ##NO_TEXT
      ).

      "通信処理実行.
      DATA(ldo_response) = ldo_http_client->execute( if_web_http_client=>put ).

      "実行結果判定.
      DATA(lds_http_status) = ldo_response->get_status( ).
      IF lds_http_status-code = 200.
        DATA(ldo_resp_txt) = ldo_response->get_text( ).
        xco_cp_json=>data->from_string( ldo_resp_txt )->write_to( REF #( zcl_file_import=>gdt_file_list ) ).

        "取込件数判定.
        IF zcl_file_import=>gdt_file_list[] IS INITIAL.
          RETURN.
        ENDIF.

        "DataSpiderエラー判定.
        READ TABLE zcl_file_import=>gdt_file_list INDEX 1 INTO DATA(lds_file_list).

        IF sy-subrc = 0 AND lds_file_list-ERRCODE IS NOT INITIAL.
          gds_ds_result_err-errcode = lds_file_list-ERRCODE.

          CASE gds_ds_result_err-errcode.
            WHEN 'E01'.
              MESSAGE e022(zrap_com_00) INTO ef_ds_err_msg.
          ENDCASE.

        ENDIF.

        et_file_list = zcl_file_import=>gdt_file_list.
      ELSE.
        MESSAGE e025(zrap_com_00) INTO ef_ds_err_msg WITH lds_http_status-code.
      ENDIF.

    "Exception
    CATCH cx_http_dest_provider_error INTO DATA(lds_cx_http_dest_provider_err).
      RAISE EXCEPTION TYPE cx_http_dest_provider_error
        MESSAGE
             ID lds_cx_http_dest_provider_err->if_t100_message~t100key-msgid
           TYPE lds_cx_http_dest_provider_err->if_t100_dyn_msg~msgty
         NUMBER lds_cx_http_dest_provider_err->if_t100_message~t100key-msgno
           WITH lds_cx_http_dest_provider_err->if_t100_dyn_msg~msgv1
                lds_cx_http_dest_provider_err->if_t100_dyn_msg~msgv2
                lds_cx_http_dest_provider_err->if_t100_dyn_msg~msgv3
                .

    CATCH cx_web_http_client_error INTO DATA(lds_cx_web_http_client_error).
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

    CATCH zcx_no_data INTO DATA(lds_zcx_no_data).
      DATA(ldf_zcx_no_data_txt) = lds_zcx_no_data->if_message~get_longtext( ).
      RAISE EXCEPTION TYPE zcx_no_data
        MESSAGE e000(zrap_com_00) WITH ldf_zcx_no_data_txt.

    ENDTRY.

  ENDMETHOD.


  METHOD get_http_client.

    "ローカル宣言.
    DATA(ldf_commscn) = if_commscn.

    TRY.

      "接続先取得（通信契約）.
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
        FROM  zy043t
        WHERE div     = @if_div
          AND zztype  = @if_type
          AND zzseqno = '1'
         INTO @DATA(lds_zy043t_div_type)
            .

      IF sy-subrc = 0.
        ldf_commscn = lds_zy043t_div_type-zzvalue01.
      ENDIF.

      "パラメータテーブル取得.
      SELECT  client,
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
        FROM  zy043t
        WHERE div  = 'ZCL_FILE_IMPORT'
        INTO TABLE @DATA(ldt_zy043t).

      IF sy-subrc = 0.
        SORT ldt_zy043t STABLE
          BY zztype  ASCENDING
             zzseqno ASCENDING.
      ELSE.
        RAISE EXCEPTION TYPE zcx_no_data
          MESSAGE e001(zrap_com_00)
             WITH text-001
                  .
      ENDIF.

      "通信シナリオ開始.
      DATA: lds_cscn TYPE if_com_scenario_factory=>ty_query-cscn_id_range.
      lds_cscn = VALUE #( (
        sign = 'I'
        option = 'EQ'
        low = ldf_commscn
       ) ).
      DATA(ldo_factory) = cl_com_arrangement_factory=>create_instance( ).

      ldo_factory->query_ca(
        EXPORTING
          is_query           = VALUE #( cscn_id_range = lds_cscn )
        IMPORTING
          et_com_arrangement = DATA(ldt_ca) ).

      "取得に失敗した場合、エラー処理.
      IF ldt_ca IS INITIAL.
        RAISE EXCEPTION TYPE zcx_no_data
          MESSAGE e001(zrap_com_00)
             WITH text-001
                  ldf_commscn
                  .
      ENDIF.

      "COM Outbound Services取得.
      READ TABLE ldt_zy043t INTO DATA(lds_zy043t_a)
        WITH KEY zztype = 'A'
        BINARY SEARCH.

      IF sy-subrc = 0.
        DATA: ldf_service_id TYPE IF_COM_MANAGEMENT=>TY_CSCN_OUTB_SRV_ID.
        CASE if_commscn.
          WHEN 'ZEAI_FILELIST_GET'.
            ldf_service_id = lds_zy043t_a-zzvalue01.
          WHEN 'ZEAI_FILE_GET'.
            ldf_service_id = lds_zy043t_a-zzvalue02.
          WHEN OTHERS.
        ENDCASE.
      ENDIF.

      READ TABLE ldt_ca INTO DATA(lds_ca) INDEX 1.

      DATA(ldo_dest) = cl_http_destination_provider=>create_by_comm_arrangement(
        comm_scenario  = ldf_commscn
        service_id     = ldf_service_id
        comm_system_id = lds_ca->get_comm_system_id( )
      ).
      eo_http_client = cl_web_http_client_manager=>create_by_http_destination( ldo_dest ).

    "Exception
    CATCH cx_http_dest_provider_error INTO DATA(lds_cx_http_dest_provider_err).
      RAISE EXCEPTION TYPE cx_http_dest_provider_error
        MESSAGE
             ID lds_cx_http_dest_provider_err->if_t100_message~t100key-msgid
           TYPE lds_cx_http_dest_provider_err->if_t100_dyn_msg~msgty
         NUMBER lds_cx_http_dest_provider_err->if_t100_message~t100key-msgno
           WITH lds_cx_http_dest_provider_err->if_t100_dyn_msg~msgv1
                lds_cx_http_dest_provider_err->if_t100_dyn_msg~msgv2
                lds_cx_http_dest_provider_err->if_t100_dyn_msg~msgv3
                .

    CATCH cx_web_http_client_error INTO DATA(lds_cx_web_http_client_error).
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

    ENDTRY.

  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

    "ローカル宣言.
    TYPES:
      BEGIN OF lts_tbl,
        COLUMN01  TYPE string,
        COLUMN02  TYPE string,
        COLUMN03  TYPE string,
        COLUMN04  TYPE string,
        COLUMN05  TYPE string,
        COLUMN06  TYPE string,
        COLUMN07  TYPE string,
        COLUMN08  TYPE string,
        COLUMN09  TYPE string,
        COLUMN10  TYPE string,
        COLUMN11  TYPE string,
        COLUMN12  TYPE string,
        COLUMN13  TYPE string,
        COLUMN14  TYPE string,
        COLUMN15  TYPE string,
        COLUMN16  TYPE string,
      END   OF lts_tbl,

      ltt_tbl           TYPE TABLE OF lts_tbl,
      ltt_file_list_tbl TYPE TABLE OF zif_zrap_com_00=>gts_import_file_list.


    DATA:
      lds_tbl           TYPE lts_tbl,
      ldt_tbl           TYPE ltt_tbl,
      ldt_file_list_tbl TYPE ltt_file_list_tbl,

      BEGIN OF lds_import_param,
        param  TYPE zif_zrap_com_00=>gts_import_parameter,
      END   OF lds_import_param.



    TRY.
      "パラメータ設定.
      zcl_file_import=>set_import_param(
        EXPORTING
          if_div          = zif_zrap_com_00=>gcs_div-zrap_fun_yf001
        CHANGING
          cs_import_param = lds_import_param-param
        ).

      out->write( 'cs_import_param' ).
      out->write( lds_import_param-param ).

      "ファイルリスト取得.
      zcl_file_import=>get_filelist_from_server(
        EXPORTING
          if_div           = zif_zrap_com_00=>gcs_div-zrap_fun_yf001
          is_import_param  = lds_import_param
        IMPORTING
          et_file_list     = ldt_file_list_tbl
          ef_ds_err_msg    = DATA(ldf_ds_err_msg)
        ).

      out->write( 'et_file_list' ).
      out->write( ldt_file_list_tbl ).

      "DataSpiderエラーメッセージ判定.
      IF ldf_ds_err_msg IS INITIAL AND ldt_file_list_tbl[] IS NOT INITIAL.

*        DATA: ldt_tbl TYPE gtt_tbl.

        LOOP AT ldt_file_list_tbl INTO DATA(lds_file_list_tbl).

          lds_import_param-param-filename = lds_file_list_tbl-filename.

          "サーバーファイル取込処理.
          zcl_file_import=>import_file_from_server(
            EXPORTING
              if_div           = zif_zrap_com_00=>gcs_div-zrap_fun_yf001
              is_import_param  = lds_import_param
            IMPORTING
              et_data_table    = ldt_tbl
              ef_ds_err_msg    = ldf_ds_err_msg
            CHANGING
              cs_data_strct    = lds_tbl
            ).

          out->write( 'is_import_param' ).
          out->write( lds_import_param ).
          out->write( 'cs_data_strct' ).
          out->write( lds_tbl ).
          out->write( 'et_data_table' ).
          out->write( ldt_tbl ).
          out->write( 'ef_ds_err_msg' ).
          out->write( ldf_ds_err_msg ).

          "DataSpiderエラーメッセージ判定.
          IF ldf_ds_err_msg IS NOT INITIAL AND ldt_tbl[] IS NOT INITIAL.
*          MESSAGE E000(ZRAP_COM_00) WITH ldf_ds_err_msg INTO gdt_msg.
            EXIT.
          ENDIF.

*          LOOP AT gdt_tbl INTO DATA(lds_tbl).
*            APPEND lds_tbl TO ldt_tbl.
*          ENDLOOP.

          CLEAR ldt_tbl.
        ENDLOOP.

      ELSE.
        out->write( 'ef_ds_err_msg' ).
        out->write( ldf_ds_err_msg ).
      ENDIF.

    "Exception.
    CATCH cx_http_dest_provider_error INTO DATA(lds_cx_http_dest_provider_err).
      DATA(lds_cx_http_dst_prov_err_txt) = lds_cx_http_dest_provider_err->if_message~get_longtext( ).
      out->write( lds_cx_http_dst_prov_err_txt ).
*      MESSAGE E000(ZRAP_COM_00) WITH lds_cx_http_dst_prov_err_txt INTO gdt_msg.

    CATCH zcx_no_data INTO DATA(lds_zcx_no_data).
      DATA(lds_zcx_no_data_txt) = lds_zcx_no_data->if_message~get_longtext( ).
      out->write( lds_zcx_no_data_txt ).
*      MESSAGE E000(ZRAP_COM_00) WITH lds_zcx_no_data_txt INTO gdt_msg.

    CATCH cx_sy_conversion_no_number INTO DATA(lds_cx_sy_cv_no_num_err).
      DATA(lds_cx_sy_cv_no_num_err_txt) = lds_cx_sy_cv_no_num_err->if_message~get_longtext( ).
      out->write( lds_cx_sy_cv_no_num_err_txt ).
*      MESSAGE E000(ZRAP_COM_00) WITH lds_cx_sy_cv_no_num_err_txt INTO gdt_msg.

    ENDTRY.

*    out->write( 'ldt_tbl' ).
*    out->write( ldt_tbl ).

  ENDMETHOD.


  METHOD import_file_from_server.

    TRY.

      "HTTP Client取得.
      get_http_client(
        EXPORTING
          if_div     = if_div
          if_type    = 'A'
          if_commscn = 'ZEAI_FILE_GET'
        IMPORTING
          eo_http_client = DATA(ldo_http_client)
      ).

      DATA(ldo_request) = ldo_http_client->get_http_request( ).
      "JSON変換処理
      DATA(ldf_json_data) = xco_cp_json=>data->from_abap( is_import_param )->to_string( ).
      ldo_request->append_text( ldf_json_data ).
      ldo_request->set_header_field(
          i_name  = 'Content-Type'     ##NO_TEXT
          i_value = 'application/json' ##NO_TEXT
      ).

      "通信処理実行.
      DATA(ldo_response) = ldo_http_client->execute( if_web_http_client=>put ).

      "実行結果判定.
      DATA(lds_http_status) = ldo_response->get_status( ).
      IF lds_http_status-code = 200.
        DATA(ldo_resp_txt) = ldo_response->get_text( ).
        xco_cp_json=>data->from_string( ldo_resp_txt )->write_to( REF #( zcl_file_import=>gdt_tbl ) ).

        "取込件数判定.
        IF zcl_file_import=>gdt_tbl[] IS INITIAL.
          RETURN.
        ENDIF.

        "DataSpiderエラー判定.
        READ TABLE zcl_file_import=>gdt_tbl INDEX 1 INTO DATA(lds_gdt_tbl).

        IF sy-subrc = 0 AND lds_gdt_tbl-FIELD101 IS NOT INITIAL.
          gds_ds_result_err-errcode = lds_gdt_tbl-FIELD101.

          CASE gds_ds_result_err-errcode.
            WHEN 'E01'.
              MESSAGE e003(zrap_com_00) INTO ef_ds_err_msg.
            WHEN 'E02'.
              MESSAGE e024(zrap_com_00) INTO ef_ds_err_msg.
            WHEN OTHERS.
          ENDCASE.

          "取込ファイル項目数が100より多いならば、lds_gdt_tbl-FIELD101に値が格納されてしまうため
          IF gds_ds_result_err-errcode = 'E00' OR ef_ds_err_msg IS NOT INITIAL.
            RETURN.
          ENDIF.
        ENDIF.

        "DataSpiderと呼出元内部テーブルのデータマッピング.
        DATA: ldo_struct_descr TYPE REF TO cl_abap_structdescr.
        "取込んだ行数分ループ.
        LOOP AT zcl_file_import=>gdt_tbl INTO DATA(lds_tbl).
          CLEAR cs_data_strct.
          ldo_struct_descr ?= cl_abap_typedescr=>describe_by_data( cs_data_strct ).
          "項目情報を取得する.
          DATA(ldt_struct_fields) = ldo_struct_descr->get_components( ).
          "項目名の数量分ループ.
          LOOP AT ldt_struct_fields INTO DATA(lds_struct_fields).
            ASSIGN COMPONENT 1 OF STRUCTURE lds_struct_fields TO FIELD-SYMBOL(<l_field>). "構造項目.
            ASSIGN lds_struct_fields-TYPE->type_kind TO FIELD-SYMBOL(<l_type>).           "構造項目の型.
            ASSIGN COMPONENT sy-tabix OF STRUCTURE lds_tbl TO FIELD-SYMBOL(<l_val>).      "構造項目の値.

            "項目の値を格納する
            CASE <l_type>.
              "日付、時刻型.
              WHEN 'D' OR 'T'.
                IF <l_val> IS INITIAL.
                  cs_data_strct-(<l_field>) = SPACE.
                ELSE.
                  cs_data_strct-(<l_field>) = <l_val>.
                ENDIF.
              WHEN OTHERS.
                cs_data_strct-(<l_field>) = <l_val>.
            ENDCASE.

          ENDLOOP.

          APPEND cs_data_strct TO et_data_table.
        ENDLOOP.

        "データ不整合を防ぐため
        CLEAR cs_data_strct.
      ELSE.
        MESSAGE e025(zrap_com_00) INTO ef_ds_err_msg WITH lds_http_status-code.
      ENDIF.

    "Exception
    CATCH cx_http_dest_provider_error INTO DATA(lds_cx_http_dest_provider_err).
      RAISE EXCEPTION TYPE cx_http_dest_provider_error
        MESSAGE
             ID lds_cx_http_dest_provider_err->if_t100_message~t100key-msgid
           TYPE lds_cx_http_dest_provider_err->if_t100_dyn_msg~msgty
         NUMBER lds_cx_http_dest_provider_err->if_t100_message~t100key-msgno
           WITH lds_cx_http_dest_provider_err->if_t100_dyn_msg~msgv1
                lds_cx_http_dest_provider_err->if_t100_dyn_msg~msgv2
                lds_cx_http_dest_provider_err->if_t100_dyn_msg~msgv3
                .

    CATCH cx_web_http_client_error INTO DATA(lds_cx_web_http_client_err).
      RAISE EXCEPTION TYPE zcx_no_data
        MESSAGE
             ID lds_cx_web_http_client_err->if_t100_message~t100key-msgid
           TYPE lds_cx_web_http_client_err->if_t100_dyn_msg~msgty
         NUMBER lds_cx_web_http_client_err->if_t100_message~t100key-msgno
           WITH lds_cx_web_http_client_err->if_t100_dyn_msg~msgv1
                lds_cx_web_http_client_err->if_t100_dyn_msg~msgv2
                lds_cx_web_http_client_err->if_t100_dyn_msg~msgv3
                lds_cx_web_http_client_err->if_t100_dyn_msg~msgv4
                .

    CATCH zcx_no_data INTO DATA(lds_zcx_no_data).
      DATA(ldf_zcx_no_data_txt) = lds_zcx_no_data->if_message~get_longtext( ).
      RAISE EXCEPTION TYPE zcx_no_data
        MESSAGE e000(zrap_com_00) WITH ldf_zcx_no_data_txt.

    CATCH cx_sy_conversion_no_number INTO DATA(lds_cx_sy_cv_no_num_err).
      CLEAR cs_data_strct.
      DATA(lds_cx_sy_cv_no_num_err_val) = lds_cx_sy_cv_no_num_err->value.
      RAISE EXCEPTION TYPE cx_sy_conversion_no_number
        EXPORTING value = lds_cx_sy_cv_no_num_err_val.

    ENDTRY.

  ENDMETHOD.


  METHOD set_import_param.

    "パラメータテーブル取得(共通).
    "種別：C、連番：1でエントリを登録する.
    SELECT  SINGLE *
      FROM  zy043t
      WHERE div     = @if_div
        AND zztype  = 'C'
        AND zzseqno = '0001'
      INTO @DATA(lds_zy043t).

    IF sy-subrc = 0.
      "【区切り文字の形式】
      cs_import_param-delimiter = lds_zy043t-zzvalue01.
      "【文字コード】.
      cs_import_param-charcode = lds_zy043t-zzvalue02.
      "【取込ファイルディレクトリパス】.
      CONCATENATE lds_zy043t-zzvalue03 lds_zy043t-zzvalue04 lds_zy043t-zzvalue05 INTO DATA(ldf_filedir).
      cs_import_param-filedir = ldf_filedir.
      "【取込ファイル名】.
      cs_import_param-filename = lds_zy043t-zzvalue06.
      "【Tempファイルディレクトリパス】.
      cs_import_param-tempfiledir = lds_zy043t-zzvalue07.
    ENDIF.

    "ディレクトリパス設定処理.
    IF cs_import_param-filedir IS INITIAL.
      RAISE EXCEPTION TYPE zcx_no_data
        MESSAGE e026(zrap_com_00)
          .
    ENDIF.
  ENDMETHOD.
ENDCLASS.
