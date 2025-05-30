CLASS zcl_wrap_bapi_po_create_fac DEFINITION
  PUBLIC

  FINAL

  CREATE PRIVATE .


  PUBLIC SECTION.

    CLASS-METHODS create_instance
      RETURNING VALUE(result) TYPE REF TO zif_wrap_bapi_po_create.

  PROTECTED SECTION.

  PRIVATE SECTION.

    METHODS constructor.

ENDCLASS.



CLASS zcl_wrap_bapi_po_create_fac IMPLEMENTATION.

  METHOD create_instance.

    result = NEW zcl_wrap_bapi_po_create(  ).

  ENDMETHOD.

  METHOD constructor.

  ENDMETHOD.

ENDCLASS.
