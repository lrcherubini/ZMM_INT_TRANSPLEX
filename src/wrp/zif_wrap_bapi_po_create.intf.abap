INTERFACE zif_wrap_bapi_po_create
  PUBLIC .

  TYPES:
    tp_header    TYPE bapimepoheader,
    tp_item      TYPE bapimepoitem,
    tp_items     TYPE bapimepoitem_tp,
    tp_expheader TYPE bapimepoheader,
    tp_result    TYPE bapiret2_tt.

  METHODS create
    IMPORTING
      is_haeder    TYPE tp_header
      it_items     TYPE tp_items
    EXPORTING
      es_expheader TYPE tp_expheader
      et_items     TYPE tp_items
      et_result    TYPE tp_result.

ENDINTERFACE.
