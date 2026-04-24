************************************************************************
*  [変更履歴]                                                          *
*   バージョン情報 ：V1.00  2024/06/05  M.OKADA            XW2K900213  *
*   変更内容       ：新規作成                                          *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.01  2025/02/20  M.SHIOMI           NWFK900043  *
*   変更内容       ：ロングテキストの改行を                            *
*                    半角スペースに置換するメソッドを追加              *
*----------------------------------------------------------------------*
*   バージョン情報 ：V9.99  YYYY/MM/DD  変更者             移送番号    *
*   変更内容       ：                                                  *
************************************************************************
CLASS zcl_zrap_com_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    "処理日時(タイムゾーン考慮)出力.
    CLASS-METHODS process_date_time_output
      EXPORTING
        ef_date      TYPE d         "処理日付.
        ef_time      TYPE t         "処理時間.
        ef_timestamp TYPE tzntstmpl "処理日時.
      RAISING
        cx_abap_context_info_error
      .
*-< ADD V1.01 (S) >-*
    "ロングテキストの改行を半角スペースに置換.
    CLASS-METHODS replace_halfspace_proc
      IMPORTING
        if_longtext TYPE string     "取得ロングテキスト.
      EXPORTING
        ef_longtext TYPE c          "出力用ロングテキスト.
      .
*-< ADD V1.01 (E) >-*
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ZRAP_COM_00 IMPLEMENTATION.


  METHOD process_date_time_output.

    TRY.
        DATA(ldf_tzone) = cl_abap_context_info=>get_user_time_zone( ).
        GET TIME STAMP FIELD DATA(ldf_timestamp).
        CONVERT TIME STAMP ldf_timestamp
           TIME ZONE ldf_tzone
           INTO: DATE DATA(ldf_date),
                 TIME DATA(ldf_time).

        ef_date      = ldf_date.
        ef_time      = ldf_time.
        ef_timestamp = ldf_timestamp.

        "【例外処理】.
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


  METHOD replace_halfspace_proc.
    DATA:
      ldf_halfspace      TYPE string,
      ldf_longtext(500)  TYPE c.
    CLEAR:
      ldf_halfspace,
      ldf_longtext.

    ldf_longtext = if_longtext.  "string→char
    ef_longtext  = ldf_longtext.

    "【改行を半角スペースに置換】
    CALL METHOD cl_abap_char_utilities=>get_simple_spaces_for_cur_cp
      RECEIVING
        s_str = ldf_halfspace.

*   *CRLFの場合
    REPLACE
       ALL OCCURRENCES OF cl_abap_char_utilities=>cr_lf
        IN ldf_longtext
      WITH ldf_halfspace+0(1).
    IF sy-subrc = 0.
      CLEAR:ef_longtext.
      ef_longtext = ldf_longtext.
      EXIT.
    ELSE.
    ENDIF.

*   *LFの場合
    REPLACE
       ALL OCCURRENCES OF cl_abap_char_utilities=>cr_lf+1(1)
        IN ldf_longtext
      WITH ldf_halfspace+0(1).
    IF sy-subrc = 0.
      CLEAR:ef_longtext.
      ef_longtext = ldf_longtext.
      EXIT.
    ELSE.
    ENDIF.

*   *CRの場合
    REPLACE
       ALL OCCURRENCES OF cl_abap_char_utilities=>cr_lf+0(1)
        IN ldf_longtext
      WITH ldf_halfspace+0(1).
    IF sy-subrc = 0.
      CLEAR:ef_longtext.
      ef_longtext = ldf_longtext.
      EXIT.
    ELSE.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
