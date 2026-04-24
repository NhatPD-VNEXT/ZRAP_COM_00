CLASS zcx_xco_runtime_exception DEFINITION
  PUBLIC
  INHERITING FROM cx_xco_runtime_exception
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA error_value_1 TYPE string.
    DATA error_value_2 TYPE string.

    CLASS-METHODS class_constructor .
    METHODS constructor
      IMPORTING
        !textid        LIKE if_t100_message=>t100key OPTIONAL
        !previous      LIKE previous OPTIONAL
        !error_value_1 TYPE string OPTIONAL
        !error_value_2 TYPE string OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCX_XCO_RUNTIME_EXCEPTION IMPLEMENTATION.


  METHOD class_constructor.
  ENDMETHOD.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous
        textid   = textid.

    me->error_value_1 = error_value_1.
    me->error_value_2 = error_value_2.

    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
