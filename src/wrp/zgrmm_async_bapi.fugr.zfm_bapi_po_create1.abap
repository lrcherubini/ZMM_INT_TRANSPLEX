FUNCTION zfm_bapi_po_create1.                               "#EC ENHOK
*"----------------------------------------------------------------------
*"*"Interface local:
*"  IMPORTING
*"     VALUE(POHEADER) LIKE  BAPIMEPOHEADER STRUCTURE  BAPIMEPOHEADER
*"     VALUE(POHEADERX) LIKE  BAPIMEPOHEADERX STRUCTURE
*"        BAPIMEPOHEADERX OPTIONAL
*"     VALUE(POADDRVENDOR) LIKE  BAPIMEPOADDRVENDOR STRUCTURE
*"        BAPIMEPOADDRVENDOR OPTIONAL
*"     VALUE(TESTRUN) LIKE  BAPIFLAG-BAPIFLAG OPTIONAL
*"     VALUE(MEMORY_UNCOMPLETE) LIKE  BAPIFLAG-BAPIFLAG OPTIONAL
*"     VALUE(MEMORY_COMPLETE) LIKE  BAPIFLAG-BAPIFLAG OPTIONAL
*"     VALUE(POEXPIMPHEADER) LIKE  BAPIEIKP STRUCTURE  BAPIEIKP
*"       OPTIONAL
*"     VALUE(POEXPIMPHEADERX) LIKE  BAPIEIKPX STRUCTURE  BAPIEIKPX
*"       OPTIONAL
*"     VALUE(VERSIONS) LIKE  BAPIMEDCM STRUCTURE  BAPIMEDCM OPTIONAL
*"     VALUE(NO_MESSAGING) LIKE  BAPIFLAG-BAPIFLAG OPTIONAL
*"     VALUE(NO_MESSAGE_REQ) LIKE  BAPIFLAG-BAPIFLAG OPTIONAL
*"     VALUE(NO_AUTHORITY) LIKE  BAPIFLAG-BAPIFLAG OPTIONAL
*"     VALUE(NO_PRICE_FROM_PO) LIKE  BAPIFLAG-BAPIFLAG OPTIONAL
*"     VALUE(PARK_COMPLETE) TYPE  BAPIFLAG-BAPIFLAG OPTIONAL
*"     VALUE(PARK_UNCOMPLETE) TYPE  BAPIFLAG-BAPIFLAG OPTIONAL
*"  EXPORTING
*"     VALUE(EXPPURCHASEORDER) LIKE  BAPIMEPOHEADER-PO_NUMBER
*"     VALUE(EXPHEADER) LIKE  BAPIMEPOHEADER STRUCTURE  BAPIMEPOHEADER
*"     VALUE(EXPPOEXPIMPHEADER) LIKE  BAPIEIKP STRUCTURE  BAPIEIKP
*"  TABLES
*"      RETURN STRUCTURE  BAPIRET2 OPTIONAL
*"      POITEM STRUCTURE  BAPIMEPOITEM OPTIONAL
*"      POITEMX STRUCTURE  BAPIMEPOITEMX OPTIONAL
*"      POADDRDELIVERY STRUCTURE  BAPIMEPOADDRDELIVERY OPTIONAL
*"      POSCHEDULE STRUCTURE  BAPIMEPOSCHEDULE OPTIONAL
*"      POSCHEDULEX STRUCTURE  BAPIMEPOSCHEDULX OPTIONAL
*"      POACCOUNT STRUCTURE  BAPIMEPOACCOUNT OPTIONAL
*"      POACCOUNTPROFITSEGMENT STRUCTURE  BAPIMEPOACCOUNTPROFITSEGMENT
*"       OPTIONAL
*"      POACCOUNTX STRUCTURE  BAPIMEPOACCOUNTX OPTIONAL
*"      POCONDHEADER STRUCTURE  BAPIMEPOCONDHEADER OPTIONAL
*"      POCONDHEADERX STRUCTURE  BAPIMEPOCONDHEADERX OPTIONAL
*"      POCOND STRUCTURE  BAPIMEPOCOND OPTIONAL
*"      POCONDX STRUCTURE  BAPIMEPOCONDX OPTIONAL
*"      POLIMITS STRUCTURE  BAPIESUHC OPTIONAL
*"      POCONTRACTLIMITS STRUCTURE  BAPIESUCC OPTIONAL
*"      POSERVICES STRUCTURE  BAPIESLLC OPTIONAL
*"      POSRVACCESSVALUES STRUCTURE  BAPIESKLC OPTIONAL
*"      POSERVICESTEXT STRUCTURE  BAPIESLLTX OPTIONAL
*"      EXTENSIONIN STRUCTURE  BAPIPAREX OPTIONAL
*"      EXTENSIONOUT STRUCTURE  BAPIPAREX OPTIONAL
*"      POEXPIMPITEM STRUCTURE  BAPIEIPO OPTIONAL
*"      POEXPIMPITEMX STRUCTURE  BAPIEIPOX OPTIONAL
*"      POTEXTHEADER STRUCTURE  BAPIMEPOTEXTHEADER OPTIONAL
*"      POTEXTITEM STRUCTURE  BAPIMEPOTEXT OPTIONAL
*"      ALLVERSIONS STRUCTURE  BAPIMEDCM_ALLVERSIONS OPTIONAL
*"      POPARTNER STRUCTURE  BAPIEKKOP OPTIONAL
*"      POCOMPONENTS STRUCTURE  BAPIMEPOCOMPONENT OPTIONAL
*"      POCOMPONENTSX STRUCTURE  BAPIMEPOCOMPONENTX OPTIONAL
*"      POSHIPPING STRUCTURE  BAPIITEMSHIP OPTIONAL
*"      POSHIPPINGX STRUCTURE  BAPIITEMSHIPX OPTIONAL
*"      POSHIPPINGEXP STRUCTURE  BAPIMEPOSHIPPEXP OPTIONAL
*"      SERIALNUMBER STRUCTURE  BAPIMEPOSERIALNO OPTIONAL
*"      SERIALNUMBERX STRUCTURE  BAPIMEPOSERIALNOX OPTIONAL
*"      INVPLANHEADER STRUCTURE  BAPI_INVOICE_PLAN_HEADER OPTIONAL
*"      INVPLANHEADERX STRUCTURE  BAPI_INVOICE_PLAN_HEADERX OPTIONAL
*"      INVPLANITEM STRUCTURE  BAPI_INVOICE_PLAN_ITEM OPTIONAL
*"      INVPLANITEMX STRUCTURE  BAPI_INVOICE_PLAN_ITEMX OPTIONAL
*"      NFMETALLITMS STRUCTURE  /NFM/BAPIDOCITM OPTIONAL
*"----------------------------------------------------------------------

  CALL FUNCTION 'BAPI_PO_CREATE1'
    EXPORTING
      poheader               = poheader                               " Header Data
      poheaderx              = poheaderx                              " Header Data (Change Parameter)
      poaddrvendor           = poaddrvendor                           " Address of Vendor
      testrun                = testrun                                " Test Indicator
      memory_uncomplete      = memory_uncomplete                      " Hold Purchase Order if Faulty
      memory_complete        = memory_complete                        " Hold Purchase Order if NOT Faulty
      poexpimpheader         = poexpimpheader                         " Export Trade: Header Data
      poexpimpheaderx        = poexpimpheaderx                        " Foreign Trade: Change Bar: Header Data
      versions               = versions                               " Version Management
      no_messaging           = no_messaging                           " No message determination
      no_message_req         = no_message_req                         " No messages necessary
      no_authority           = no_authority                           " No Authorization Check
      no_price_from_po       = no_price_from_po                       " No Adoption of Price from Last Document
      park_complete          = park_complete                          " Park Document if NOT Faulty
      park_uncomplete        = park_uncomplete                        " Park Document if Faulty
    IMPORTING
      exppurchaseorder       = exppurchaseorder                       " Purchasing Document Number
      expheader              = expheader                              " Header Data
      exppoexpimpheader      = exppoexpimpheader                      " Export Trade: Header Data
    TABLES
      return                 = return                                 " Return Parameter
      poitem                 = poitem                                 " Item Data
      poitemx                = poitemx                                " Item Data (Change Parameter)
      poaddrdelivery         = poaddrdelivery                         " Addresses for Inward Delivery (Item)
      poschedule             = poschedule                             " Delivery Schedule
      poschedulex            = poschedulex                            " Delivery Schedule (Change Parameter)
      poaccount              = poaccount                              " Account Assignment Fields
      poaccountprofitsegment = poaccountprofitsegment                 " Reservation Profitability Segment: BAPI_PROFITABILITY_SEGMENT
      poaccountx             = poaccountx                             " Account Assignment Fields (Change Parameter)
      pocondheader           = pocondheader                           " Conditions (Header)
      pocondheaderx          = pocondheaderx                          " Conditions (Header, Change Parameter)
      pocond                 = pocond                                 " Conditions (Items)
      pocondx                = pocondx                                " Conditions (Items, Change Parameter)
      polimits               = polimits                               " External Services: Limits
      pocontractlimits       = pocontractlimits                       " External Services: Contract Limits
      poservices             = poservices                             " External Services: Service Lines
      posrvaccessvalues      = posrvaccessvalues                      " External Services: Account Assignment Distribution for Service Lines
      poservicestext         = poservicestext                         " External Services: Service Long Text
      extensionin            = extensionin                            " Customer's Own Fields (Import Parameters)
      extensionout           = extensionout                           " Customer's Own Fields (Export Parameters)
      poexpimpitem           = poexpimpitem                           " Foreign Trade: Item Data
      poexpimpitemx          = poexpimpitemx                          " Foreign Trade: Change Parameter: Item Data
      potextheader           = potextheader                           " Header Texts
      potextitem             = potextitem                             " Item Texts
      allversions            = allversions                            " All Versions (Export Parameter)
      popartner              = popartner                              " Partner
      pocomponents           = pocomponents                           " BAPI Structure for Components
      pocomponentsx          = pocomponentsx                          " Update Information for Components in BUS2012 API
      poshipping             = poshipping                             " BAPI Shipping Data for Stock Transport Orders
      poshippingx            = poshippingx                            " BAPI Shipping Data Change Parameter
      poshippingexp          = poshippingexp                          " Export Structure for Shipping Data
      serialnumber           = serialnumber                           " Serial Numbers in Purchase Order BAPIs
      serialnumberx          = serialnumberx                          " Change Parameter: Serial Number in Purchase Order BAPIs
      invplanheader          = invplanheader                          " Invoicing Plan Header Data
      invplanheaderx         = invplanheaderx                         " Invoicing Plan Header Data (Change Parameter)
      invplanitem            = invplanitem                            " Invoicing Plan Item Data
      invplanitemx           = invplanitemx                           " Invoicing Plan Item Data (Change Parameter)
      nfmetallitms           = nfmetallitms.                          " /NFM/: BAPI Communication Structure NF Document Item Data

  LOOP AT return TRANSPORTING NO FIELDS WHERE type CA 'AEX'.
    EXIT.
  ENDLOOP.

  IF exppurchaseorder IS INITIAL OR sy-subrc EQ 0.
    CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.

  ELSE.
    CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
      EXPORTING
        wait = 'X'.

  ENDIF.

ENDFUNCTION.
