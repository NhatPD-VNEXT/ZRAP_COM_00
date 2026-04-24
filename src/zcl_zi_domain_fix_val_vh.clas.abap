************************************************************************
*  [変更履歴]                                                          *
*   バージョン情報 ：V1.00  2024/06/18  M.OKADA            XW2K900213  *
*   変更内容       ：新規作成                                          *
*----------------------------------------------------------------------*
*   バージョン情報 ：V9.99  YYYY/MM/DD  変更者             移送番号    *
*   変更内容       ：                                                  *
************************************************************************
CLASS zcl_zi_domain_fix_val_vh DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ZI_DOMAIN_FIX_VAL_VH IMPLEMENTATION.


  METHOD if_rap_query_provider~select.

    DATA:
      ldt_business_data      TYPE TABLE OF zi_domain_fix_val_vh,
      ldt_business_data_line TYPE zi_domain_fix_val_vh,
      ldf_domain_name        TYPE sxco_ad_object_name  ,
      ldf_pos TYPE i.

    TRY.
      DATA(ldf_top)                = io_request->get_paging( )->get_page_size( ).
      DATA(ldf_skip)               = io_request->get_paging( )->get_offset( ).
      DATA(ldf_requested_fields)   = io_request->get_requested_elements( ).
      DATA(ldf_sort_order)         = io_request->get_sort_elements( ).
      DATA(ldf_filter_cond_string) = io_request->get_filter( )->get_as_sql_string( ).
      DATA(ldf_filter_cond_ranges) = io_request->get_filter( )->get_as_ranges(  ).

      READ TABLE ldf_filter_cond_ranges WITH KEY name = 'DOMAIN_NAME'
             INTO DATA(filter_condition_domain_name).

      IF filter_condition_domain_name IS NOT INITIAL.
        ldf_domain_name = filter_condition_domain_name-range[ 1 ]-low.
      ELSE.
        "do some exception handling
        io_response->set_total_number_of_records( lines( ldt_business_data ) ).
        io_response->set_data( ldt_business_data ).
        EXIT.

      ENDIF.

      ldt_business_data_line-domain_name = ldf_domain_name .

      CAST cl_abap_elemdescr( cl_abap_typedescr=>describe_by_name( ldf_domain_name ) )->get_ddic_fixed_values(
        EXPORTING
          p_langu        = sy-langu
        RECEIVING
          p_fixed_values = DATA(ldt_fixed_values)
        EXCEPTIONS
          not_found      = 1
          no_ddic_type   = 2
          OTHERS         = 3 ).

      IF sy-subrc > 0.
        "do some exception handling
        io_response->set_total_number_of_records( lines( ldt_business_data ) ).
        io_response->set_data( ldt_business_data ).
        EXIT.
      ENDIF.

      LOOP AT ldt_fixed_values INTO DATA(lds_fixed_value).
        ldf_pos += 1.
        ldt_business_data_line-pos         = ldf_pos.
        ldt_business_data_line-low         = lds_fixed_value-low .
        ldt_business_data_line-high        = lds_fixed_value-high.
        ldt_business_data_line-description = lds_fixed_value-ddtext.
        APPEND ldt_business_data_line TO ldt_business_data.
      ENDLOOP.

      IF ldf_top IS NOT INITIAL.
        DATA(ldf_max_index) = ldf_top + ldf_skip.
      ELSE.
        ldf_max_index = 0.
      ENDIF.

      SELECT *
        FROM @ldt_business_data AS data_source_fields ##ITAB_KEY_IN_SELECT
       WHERE (ldf_filter_cond_string)
        INTO TABLE @ldt_business_data
          UP TO @ldf_max_index ROWS
           .
      IF ldf_skip IS NOT INITIAL.
        DELETE ldt_business_data TO ldf_skip.
      ENDIF.

      io_response->set_total_number_of_records( lines( ldt_business_data ) ).
      io_response->set_data( ldt_business_data ).

    CATCH cx_root INTO DATA(lds_exception).
      DATA(ldf_exception_message)  = cl_message_helper=>get_latest_t100_exception( lds_exception )->if_message~get_longtext( ).
      DATA(ldf_exception_t100_key) = cl_message_helper=>get_latest_t100_exception( lds_exception )->t100key.
      "do some exception handling
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
