CLASS zcx_no_data DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_dyn_msg .

    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL .
    METHODS get_message_id
      RETURNING
        VALUE(id) TYPE symsgno .

  PROTECTED SECTION.
  PRIVATE SECTION.

    ALIASES default_textid
      FOR if_t100_message~default_textid .
    ALIASES t100key
      FOR if_t100_message~t100key .
ENDCLASS.



CLASS ZCX_NO_DATA IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.


  METHOD get_message_id.
    id = me->if_t100_message~t100key-msgno.
  ENDMETHOD.
ENDCLASS.
