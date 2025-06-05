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
        is_bapi  = is_header
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
        i_poheader     = is_header
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

  METHOD zif_wrap_bapi_po_create~create_bo.

    DATA: ls_headerx TYPE bapimepoheaderx,
          lt_itemsx  TYPE TABLE OF bapimepoitemx,
          ls_itemsx  LIKE LINE OF lt_itemsx.

    et_items = it_items.

    CALL METHOD zcl_ba_util=>set_bapi_x
      EXPORTING
        is_bapi  = is_header
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

    CALL FUNCTION 'BAPI_PO_CREATE1'
      EXPORTING
        poheader     = is_header
        poheaderx    = ls_headerx
        no_authority = 'X'
*       poaddrvendor =
*       testrun      =
*       memory_uncomplete      =
*       memory_complete        =
*       poexpimpheader         =
*       poexpimpheaderx        =
*       versions     =
*       no_messaging =
*       no_message_req         =
*       no_price_from_po       =
*       park_complete          =
*       park_uncomplete        =
      IMPORTING
*       exppurchaseorder       = e
        expheader    = es_expheader
*       exppoexpimpheader      =
      TABLES
        return       = et_result
        poitem       = et_items
        poitemx      = lt_itemsx
*       poaddrdelivery         =
*       poschedule   =
*       poschedulex  =
*       poaccount    =
*       poaccountprofitsegment =
*       poaccountx   =
*       pocondheader =
*       pocondheaderx          =
*       pocond       =
*       pocondx      =
*       polimits     =
*       pocontractlimits       =
*       poservices   =
*       posrvaccessvalues      =
*       poservicestext         =
*       extensionin  =
*       extensionout =
*       poexpimpitem =
*       poexpimpitemx          =
*       potextheader =
*       potextitem   =
*       allversions  =
*       popartner    =
*       pocomponents =
*       pocomponentsx          =
*       poshipping   =
*       poshippingx  =
*       poshippingexp          =
*       serialnumber =
*       serialnumberx          =
*       invplanheader          =
*       invplanheaderx         =
*       invplanitem  =
*       invplanitemx =
*       nfmetallitms =
      .

  ENDMETHOD.
ENDCLASS.
