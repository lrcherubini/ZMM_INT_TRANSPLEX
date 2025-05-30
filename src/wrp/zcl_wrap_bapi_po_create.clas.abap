CLASS zcl_wrap_bapi_po_create DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_wrap_bapi_po_create .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_wrap_bapi_po_create IMPLEMENTATION.

  METHOD zif_wrap_bapi_po_create~create.

    DATA: ls_headerx TYPE bapimepoheaderx,
          lt_itemsx  TYPE TABLE OF bapimepoitemx,
          ls_itemsx  LIKE LINE OF lt_itemsx.

    et_items = it_items.

    CALL METHOD zcl_ba_util=>set_bapi_x
      EXPORTING
        is_bapi  = is_haeder
*       it_blanks    =
*       it_constants =
      IMPORTING
        es_bapix = ls_headerx.

    LOOP AT et_items INTO DATA(ls_items).

      CLEAR ls_itemsx.
      CALL METHOD zcl_ba_util=>set_bapi_x
        EXPORTING
          is_bapi  = ls_items
*         it_blanks    =
*         it_constants =
        IMPORTING
          es_bapix = ls_itemsx.

      APPEND ls_itemsx TO lt_itemsx.

    ENDLOOP.

    zcl_wrap_bapi_po_create_async=>bapi_po_create(
      EXPORTING
        i_poheader     = is_haeder
        i_poheaderx    = ls_headerx
        i_no_authority = 'X'
      IMPORTING
        e_expheader    = es_expheader
      CHANGING
        c_return       = et_result
        c_poitem       = et_items
        c_poitemx      = lt_itemsx
    ).

  ENDMETHOD.
ENDCLASS.
