CLASS zcl_wrap_bapi_po_create_async DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS: bapi_po_create
      IMPORTING
        i_poheader               TYPE bapimepoheader
        i_poheaderx              TYPE bapimepoheaderx OPTIONAL
        i_poaddrvendor           TYPE bapimepoaddrvendor OPTIONAL
        i_testrun                TYPE bapiflag-bapiflag OPTIONAL
        i_memory_uncomplete      TYPE bapiflag-bapiflag OPTIONAL
        i_memory_complete        TYPE bapiflag-bapiflag OPTIONAL
        i_poexpimpheader         TYPE bapieikp OPTIONAL
        i_poexpimpheaderx        TYPE bapieikpx OPTIONAL
        i_versions               TYPE bapimedcm OPTIONAL
        i_no_messaging           TYPE bapiflag-bapiflag OPTIONAL
        i_no_message_req         TYPE bapiflag-bapiflag OPTIONAL
        i_no_authority           TYPE bapiflag-bapiflag OPTIONAL
        i_no_price_from_po       TYPE bapiflag-bapiflag OPTIONAL
        i_park_complete          TYPE bapiflag-bapiflag OPTIONAL
        i_park_uncomplete        TYPE bapiflag-bapiflag OPTIONAL
      EXPORTING
        e_exppurchaseorder       TYPE bapimepoheader-po_number
        e_expheader              TYPE bapimepoheader
        e_exppoexpimpheader      TYPE bapieikp
      CHANGING
        c_return                 TYPE bapiret2_tt OPTIONAL
        c_poitem                 TYPE bapimepoitem_tp OPTIONAL
        c_poitemx                TYPE bapimepoitemx_tp OPTIONAL
        c_poaddrdelivery         TYPE bapimepoaddrdelivery_tp OPTIONAL
        c_poschedule             TYPE bapimeposchedule_tp OPTIONAL
        c_poschedulex            TYPE bapimeposchedulx_tp OPTIONAL
        c_poaccount              TYPE bapimepoaccount_tp OPTIONAL
        c_poaccountprofitsegment TYPE bapimepoaccountprofit_tp OPTIONAL
        c_poaccountx             TYPE bapimepoaccountx_tp OPTIONAL
        c_pocondheader           TYPE bapimepocondheader_tp OPTIONAL
        c_pocondheaderx          TYPE bapimepocondheaderx_tp OPTIONAL
        c_pocond                 TYPE bapimepocond_tp OPTIONAL
        c_pocondx                TYPE bapimepocondx_tp OPTIONAL
        c_polimits               TYPE bapiesuhc_tp OPTIONAL
        c_pocontractlimits       TYPE bapiesucc_tp OPTIONAL
        c_poservices             TYPE bapiesllc_tp OPTIONAL
        c_posrvaccessvalues      TYPE bapiesklc_tp OPTIONAL
        c_poservicestext         TYPE bapieslltx_tp OPTIONAL
        c_extensionin            TYPE bapiparex_tp OPTIONAL
        c_extensionout           TYPE bapiparex_tp OPTIONAL
        c_poexpimpitem           TYPE bapieipo_tp OPTIONAL
        c_poexpimpitemx          TYPE bapieipox_tp OPTIONAL
        c_potextheader           TYPE bapimepotextheader_tp OPTIONAL
        c_potextitem             TYPE bapimepotext_tp OPTIONAL
        c_allversions            TYPE mepo_t_bapimedcm OPTIONAL
        c_popartner              TYPE bapiekkop_tp OPTIONAL
        c_pocomponents           TYPE bapimepocomponent_tp OPTIONAL
        c_pocomponentsx          TYPE bapimepocomponentx_tp OPTIONAL
        c_poshipping             TYPE bapiitemship_tp OPTIONAL
        c_poshippingx            TYPE bapiitemshipx_tp OPTIONAL
        c_poshippingexp          TYPE bapimeposhippexp_tp OPTIONAL
        c_serialnumber           TYPE bapimepo_t_serialno OPTIONAL
        c_serialnumberx          TYPE bapimepo_t_serialnox OPTIONAL
        c_invplanheader          TYPE bapi_invoice_plan_header_tty OPTIONAL
        c_invplanheaderx         TYPE bapi_invoice_plan_headerx_tty OPTIONAL
        c_invplanitem            TYPE bapi_invoice_plan_item_tty OPTIONAL
        c_invplanitemx           TYPE bapi_invoice_plan_itemx_tty OPTIONAL
        c_nfmetallitms           TYPE /nfm/bapidocitm_t OPTIONAL.

    CLASS-METHODS: return_bapi_po_create
      IMPORTING
        p_task TYPE csequence.

  PROTECTED SECTION.
  PRIVATE SECTION.

    CLASS-DATA:
      gv_done                   TYPE abap_boolean,
      gv_exppurchaseorder       TYPE bapimepoheader-po_number,
      gs_expheader              TYPE bapimepoheader,
      gs_exppoexpimpheader      TYPE bapieikp,
      gt_return                 TYPE bapiret2_tt,
      gt_poitem                 TYPE bapimepoitem_tp,
      gt_poitemx                TYPE bapimepoitemx_tp,
      gt_poaddrdelivery         TYPE bapimepoaddrdelivery_tp,
      gt_poschedule             TYPE bapimeposchedule_tp,
      gt_poschedulex            TYPE bapimeposchedulx_tp,
      gt_poaccount              TYPE bapimepoaccount_tp,
      gt_poaccountprofitsegment TYPE bapimepoaccountprofit_tp,
      gt_poaccountx             TYPE bapimepoaccountx_tp,
      gt_pocondheader           TYPE bapimepocondheader_tp,
      gt_pocondheaderx          TYPE bapimepocondheaderx_tp,
      gt_pocond                 TYPE bapimepocond_tp,
      gt_pocondx                TYPE bapimepocondx_tp,
      gt_polimits               TYPE bapiesuhc_tp,
      gt_pocontractlimits       TYPE bapiesucc_tp,
      gt_poservices             TYPE bapiesllc_tp,
      gt_posrvaccessvalues      TYPE bapiesklc_tp,
      gt_poservicestext         TYPE bapieslltx_tp,
      gt_extensionin            TYPE bapiparex_tp,
      gt_extensionout           TYPE bapiparex_tp,
      gt_poexpimpitem           TYPE bapieipo_tp,
      gt_poexpimpitemx          TYPE bapieipox_tp,
      gt_potextheader           TYPE bapimepotextheader_tp,
      gt_potextitem             TYPE bapimepotext_tp,
      gt_allversions            TYPE mepo_t_bapimedcm,
      gt_popartner              TYPE bapiekkop_tp,
      gt_pocomponents           TYPE bapimepocomponent_tp,
      gt_pocomponentsx          TYPE bapimepocomponentx_tp,
      gt_poshipping             TYPE bapiitemship_tp,
      gt_poshippingx            TYPE bapiitemshipx_tp,
      gt_poshippingexp          TYPE bapimeposhippexp_tp,
      gt_serialnumber           TYPE bapimepo_t_serialno,
      gt_serialnumberx          TYPE bapimepo_t_serialnox,
      gt_invplanheader          TYPE bapi_invoice_plan_header_tty,
      gt_invplanheaderx         TYPE bapi_invoice_plan_headerx_tty,
      gt_invplanitem            TYPE bapi_invoice_plan_item_tty,
      gt_invplanitemx           TYPE bapi_invoice_plan_itemx_tty,
      gt_nfmetallitms           TYPE /nfm/bapidocitm_t.

    CLASS-METHODS: initialize.

ENDCLASS.

CLASS zcl_wrap_bapi_po_create_async IMPLEMENTATION.

  METHOD initialize.

    CLEAR: gv_done,
           gv_exppurchaseorder,
           gs_expheader,
           gs_exppoexpimpheader,
           gt_return,
           gt_poitem,
           gt_poitemx,
           gt_poaddrdelivery,
           gt_poschedule,
           gt_poschedulex,
           gt_poaccount,
           gt_poaccountprofitsegment,
           gt_poaccountx,
           gt_pocondheader,
           gt_pocondheaderx,
           gt_pocond,
           gt_pocondx,
           gt_polimits,
           gt_pocontractlimits,
           gt_poservices,
           gt_posrvaccessvalues,
           gt_poservicestext,
           gt_extensionin,
           gt_extensionout,
           gt_poexpimpitem,
           gt_poexpimpitemx,
           gt_potextheader,
           gt_potextitem,
           gt_allversions,
           gt_popartner,
           gt_pocomponents,
           gt_pocomponentsx,
           gt_poshipping,
           gt_poshippingx,
           gt_poshippingexp,
           gt_serialnumber,
           gt_serialnumberx,
           gt_invplanheader,
           gt_invplanheaderx,
           gt_invplanitem,
           gt_invplanitemx,
           gt_nfmetallitms.

  ENDMETHOD.

  METHOD bapi_po_create.

    TRY.
        DATA(lv_guid) = cl_system_uuid=>create_uuid_c22_static( ).

      CATCH cx_uuid_error.
        lv_guid = sy-datum && sy-uzeit.

    ENDTRY.

    initialize(  ).

    CALL FUNCTION 'ZFM_BAPI_PO_CREATE1'
      STARTING NEW TASK lv_guid
      DESTINATION IN GROUP DEFAULT
      CALLING return_bapi_po_create ON END OF TASK
      EXPORTING
        poheader               = i_poheader
        poheaderx              = i_poheaderx
        no_authority           = i_no_authority
        poaddrvendor           = i_poaddrvendor
        testrun                = i_testrun
        memory_uncomplete      = i_memory_uncomplete
        memory_complete        = i_memory_complete
        poexpimpheader         = i_poexpimpheader
        poexpimpheaderx        = i_poexpimpheaderx
        versions               = i_versions
        no_messaging           = i_no_messaging
        no_message_req         = i_no_message_req
        no_price_from_po       = i_no_price_from_po
        park_complete          = i_park_complete
        park_uncomplete        = i_park_uncomplete
      TABLES
        return                 = c_return
        poitem                 = c_poitem
        poitemx                = c_poitemx
        poaddrdelivery         = c_poaddrdelivery
        poschedule             = c_poschedule
        poschedulex            = c_poschedulex
        poaccount              = c_poaccount
        poaccountprofitsegment = c_poaccountprofitsegment
        poaccountx             = c_poaccountx
        pocondheader           = c_pocondheader
        pocondheaderx          = c_pocondheaderx
        pocond                 = c_pocond
        pocondx                = c_pocondx
        polimits               = c_polimits
        pocontractlimits       = c_pocontractlimits
        poservices             = c_poservices
        posrvaccessvalues      = c_posrvaccessvalues
        poservicestext         = c_poservicestext
        extensionin            = c_extensionin
        extensionout           = c_extensionout
        poexpimpitem           = c_poexpimpitem
        poexpimpitemx          = c_poexpimpitemx
        potextheader           = c_potextheader
        potextitem             = c_potextitem
        allversions            = c_allversions
        popartner              = c_popartner
        pocomponents           = c_pocomponents
        pocomponentsx          = c_pocomponentsx
        poshipping             = c_poshipping
        poshippingx            = c_poshippingx
        poshippingexp          = c_poshippingexp
        serialnumber           = c_serialnumber
        serialnumberx          = c_serialnumberx
        invplanheader          = c_invplanheader
        invplanheaderx         = c_invplanheaderx
        invplanitem            = c_invplanitem
        invplanitemx           = c_invplanitemx
        nfmetallitms           = c_nfmetallitms.

    WAIT FOR ASYNCHRONOUS TASKS UNTIL gv_done EQ abap_true.

    e_expheader         = gs_expheader.
    e_exppoexpimpheader = gs_exppoexpimpheader.
    e_exppurchaseorder  = gv_exppurchaseorder.
    c_return            = gt_return.
    c_poitem            = gt_poitem.

  ENDMETHOD.

  METHOD return_bapi_po_create.

    RECEIVE RESULTS FROM FUNCTION 'ZFM_BAPI_PO_CREATE1'
      IMPORTING
        expheader              = gs_expheader
        exppoexpimpheader      = gs_exppoexpimpheader
        exppurchaseorder       = gv_exppurchaseorder
      TABLES
        return                 = gt_return
        poitem                 = gt_poitem
        poitemx                = gt_poitemx
        poaddrdelivery         = gt_poaddrdelivery
        poschedule             = gt_poschedule
        poschedulex            = gt_poschedulex
        poaccount              = gt_poaccount
        poaccountprofitsegment = gt_poaccountprofitsegment
        poaccountx             = gt_poaccountx
        pocondheader           = gt_pocondheader
        pocondheaderx          = gt_pocondheaderx
        pocond                 = gt_pocond
        pocondx                = gt_pocondx
        polimits               = gt_polimits
        pocontractlimits       = gt_pocontractlimits
        poservices             = gt_poservices
        posrvaccessvalues      = gt_posrvaccessvalues
        poservicestext         = gt_poservicestext
        extensionin            = gt_extensionin
        extensionout           = gt_extensionout
        poexpimpitem           = gt_poexpimpitem
        poexpimpitemx          = gt_poexpimpitemx
        potextheader           = gt_potextheader
        potextitem             = gt_potextitem
        allversions            = gt_allversions
        popartner              = gt_popartner
        pocomponents           = gt_pocomponents
        pocomponentsx          = gt_pocomponentsx
        poshipping             = gt_poshipping
        poshippingx            = gt_poshippingx
        poshippingexp          = gt_poshippingexp
        serialnumber           = gt_serialnumber
        serialnumberx          = gt_serialnumberx
        invplanheader          = gt_invplanheader
        invplanheaderx         = gt_invplanheaderx
        invplanitem            = gt_invplanitem
        invplanitemx           = gt_invplanitemx
        nfmetallitms           = gt_nfmetallitms.

    gv_done = abap_true.

  ENDMETHOD.

ENDCLASS.
