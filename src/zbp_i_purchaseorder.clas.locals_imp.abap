CLASS lhc_zi_purchaseorder DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_purchaseorder RESULT result.

    METHODS validatepo FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_purchaseorder~validatepo.

    METHODS createreturnorderviabapi FOR MODIFY
      IMPORTING keys FOR ACTION zi_purchaseorder~createreturnorderviabapi RESULT result.

ENDCLASS.

CLASS lhc_zi_purchaseorder IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD validatepo.
  ENDMETHOD.

  METHOD createreturnorderviabapi.

    DATA: ls_header  TYPE zif_wrap_bapi_po_create=>tp_header.
    DATA: lt_items   TYPE zif_wrap_bapi_po_create=>tp_items.
    DATA: ls_expitem TYPE zif_wrap_bapi_po_create=>tp_item.

    TRY.
        " Obter uma instância da implementação da interface através da factory
        DATA(lo_bapi_po_create) = zcl_wrap_bapi_po_create_fac=>create_instance( ).

      CATCH cx_root INTO DATA(lx_exception).
        " Handle potential exceptions during factory call or BAPI execution
        APPEND VALUE #( %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text     = |Static Action Error: { lx_exception->get_text( ) }|
                      )
                      ) TO reported-zi_purchaseorder.
        RETURN.
    ENDTRY.

    LOOP AT keys INTO DATA(ls_keys).

      TRY.
          CLEAR: ls_header,
                 lt_items.

          " Mapear dados do header da entidade para a estrutura da BAPI
          ls_header-comp_code    = ls_keys-%param-companycode.
          ls_header-doc_type     = ls_keys-%param-purchaseordertype.
          ls_header-purch_org    = ls_keys-%param-purchasingorganization.
          ls_header-pur_group    = ls_keys-%param-purchasinggroup.
          ls_header-vendor       = ls_keys-%param-supplier.
          ls_header-currency     = ls_keys-%param-documentcurrency.
          ls_header-pmnttrms     = ls_keys-%param-paymentterms.

          LOOP AT ls_keys-%param-_purchaseorderitem INTO DATA(ls_param_items).

            APPEND VALUE zif_wrap_bapi_po_create=>tp_item(
              po_item   = COND #( WHEN ls_param_items-purchaseorderitem IS NOT INITIAL
              THEN ls_param_items-purchaseorderitem
              ELSE lines( lt_items ) + 1 )
              material  = ls_param_items-material
              plant     = ls_param_items-plant
              quantity  = ls_param_items-orderquantity
              po_unit   = ls_param_items-purchaseorderquantityunit
              net_price = ls_param_items-netpriceamount
              tax_code  = ls_param_items-taxcode
            ) TO lt_items.

          ENDLOOP.

          " Chamar o método create da interface para criar o pedido de compra
          CALL METHOD lo_bapi_po_create->create
            EXPORTING
              is_haeder    = ls_header
              it_items     = lt_items
            IMPORTING
              es_expheader = DATA(ls_expheader)
              et_items     = DATA(lt_expitems)
              et_result    = DATA(lt_result).

          IF ls_expheader-po_number IS NOT INITIAL.
            READ ENTITIES OF zi_purchaseorder IN LOCAL MODE
              ENTITY zi_purchaseorder
                ALL FIELDS WITH VALUE #( ( %key-purchaseorder = ls_expheader-po_number ) )
              RESULT DATA(lt_po_data)
              ENTITY zi_purchaseorder BY \_purchaseorderitem
                ALL FIELDS WITH VALUE #( ( %key-purchaseorder = ls_expheader-po_number ) )
              RESULT DATA(lt_po_item_data)
              FAILED DATA(lt_loc_failed)
              REPORTED DATA(lt_loc_reported).

          ELSE.
            APPEND VALUE #( %cid          = ls_keys-%cid
                            purchaseorder = ls_expheader-po_number
            ) TO failed-zi_purchaseorder.

          ENDIF.

          LOOP AT lt_po_data INTO DATA(ls_po).

            APPEND VALUE #( %cid   = ls_keys-%cid
                            %param = CORRESPONDING #( ls_po ) ) TO result.

          ENDLOOP.

          LOOP AT lt_result INTO DATA(ls_result).

            CHECK ls_result-parameter EQ 'POHEADER' OR ls_expheader-po_number IS INITIAL.

            APPEND VALUE #( %cid          = ls_keys-%cid
                            purchaseorder = ls_expheader-po_number
                            %msg          = new_message(
                            id       = ls_result-id
                            number   = ls_result-number
                            severity = SWITCH #( ls_result-type
                                                 WHEN 'S' THEN if_abap_behv_message=>severity-success
                                                 WHEN 'I' THEN if_abap_behv_message=>severity-information
                                                 WHEN 'W' THEN if_abap_behv_message=>severity-warning
                                                 ELSE if_abap_behv_message=>severity-error )
                            v1       = ls_result-message_v1
                            v2       = ls_result-message_v2
                            v3       = ls_result-message_v3
                            v4       = ls_result-message_v4 )
            ) TO reported-zi_purchaseorder.

          ENDLOOP.

          LOOP AT lt_result INTO ls_result WHERE parameter EQ 'POITEM'.

            READ TABLE lt_expitems INTO ls_expitem INDEX ls_result-row.

            CHECK sy-subrc EQ 0.

            LOOP AT lt_po_item_data INTO DATA(ls_po_item) USING KEY id WHERE purchaseorder     EQ ls_expheader-po_number
                                                                         AND purchaseorderitem EQ ls_expitem-po_item.

              APPEND VALUE #( %cid              = ls_keys-%cid
                              purchaseorder     = ls_po_item-purchaseorder
                              purchaseorderitem = ls_po_item-purchaseorderitem
                              %msg          = new_message(
                              id       = ls_result-id
                              number   = ls_result-number
                              severity = SWITCH #( ls_result-type
                                                   WHEN 'S' THEN if_abap_behv_message=>severity-success
                                                   WHEN 'I' THEN if_abap_behv_message=>severity-information
                                                   WHEN 'W' THEN if_abap_behv_message=>severity-warning
                                                   ELSE if_abap_behv_message=>severity-error )
                              v1       = ls_result-message_v1
                              v2       = ls_result-message_v2
                              v3       = ls_result-message_v3
                              v4       = ls_result-message_v4 )
              ) TO reported-zi_purchaseorderitem.

            ENDLOOP.
          ENDLOOP.

        CATCH cx_root INTO lx_exception.
          " Handle potential exceptions during factory call or BAPI execution
          APPEND VALUE #( %msg = new_message_with_text(
                          severity = if_abap_behv_message=>severity-error
                          text     = |Static Action Error: { lx_exception->get_text( ) }|
                        )
                        ) TO reported-zi_purchaseorder.

      ENDTRY.

      CLEAR: lt_result,
             ls_expheader,
             lt_expitems,
             lt_po_data,
             lt_po_item_data,
             lt_loc_failed,
             lt_loc_reported.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lsc_zi_purchaseorder DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

  PRIVATE SECTION.

ENDCLASS.

CLASS lsc_zi_purchaseorder IMPLEMENTATION.

  METHOD save_modified.

    DATA: ls_header TYPE zif_wrap_bapi_po_create=>tp_header.
    DATA: lt_items TYPE zif_wrap_bapi_po_create=>tp_items.

    " Verificar se existem entidades criadas
    IF create-zi_purchaseorder IS NOT INITIAL.

      " Obter uma instância da implementação da interface através da factory
      DATA(lo_bapi_po_create) = zcl_wrap_bapi_po_create_fac=>create_instance( ).

      " Processar cada pedido de compra criado
      LOOP AT create-zi_purchaseorder ASSIGNING FIELD-SYMBOL(<fs_po_create>).
        " Preparar dados do header

        " Mapear dados do header da entidade para a estrutura da BAPI
        ls_header-comp_code    = <fs_po_create>-companycode.
        ls_header-doc_type     = <fs_po_create>-purchaseordertype.
        ls_header-purch_org    = <fs_po_create>-purchasingorganization.
        ls_header-pur_group    = <fs_po_create>-purchasinggroup.
        ls_header-vendor       = <fs_po_create>-supplier.
        ls_header-currency     = <fs_po_create>-documentcurrency.
        ls_header-pmnttrms     = <fs_po_create>-paymentterms.
        ls_header-incoterms1   = <fs_po_create>-incotermsclassification.
        ls_header-incoterms2   = <fs_po_create>-incotermstransferlocation.

        " Preparar tabela de itens

        " Obter os itens relacionados ao pedido de compra atual
        READ TABLE create-zi_purchaseorderitem  WITH KEY id COMPONENTS purchaseorder = <fs_po_create>-purchaseorder
                                                 TRANSPORTING NO FIELDS.

        " Se encontrou itens, processar cada um
        IF sy-subrc = 0.
          LOOP AT create-zi_purchaseorderitem ASSIGNING FIELD-SYMBOL(<fs_item_create>)
                                             FROM sy-tabix USING KEY id
                                             WHERE purchaseorder = <fs_po_create>-purchaseorder.

            " Mapear dados do item da entidade para a estrutura da BAPI
            APPEND VALUE zif_wrap_bapi_po_create=>tp_item(
              po_item    = COND #( WHEN <fs_item_create>-purchaseorderitem IS NOT INITIAL
              THEN <fs_item_create>-purchaseorderitem
              ELSE lines( lt_items ) + 1 )
              material   = <fs_item_create>-material
              plant      = <fs_item_create>-plant
              short_text = <fs_item_create>-purchaseorderitemtext
              quantity   = <fs_item_create>-orderquantity
              po_unit    = <fs_item_create>-purchaseorderquantityunit
              net_price  = <fs_item_create>-netpriceamount
              acctasscat = <fs_item_create>-accountassignmentcategory
              tax_code   = <fs_item_create>-taxcode
            ) TO lt_items.

          ENDLOOP.
        ENDIF.

        " Chamar o método create da interface para criar o pedido de compra
        CALL METHOD lo_bapi_po_create->create_bo
          EXPORTING
            is_haeder    = ls_header
            it_items     = lt_items
          IMPORTING
            es_expheader = DATA(ls_expheader)
            et_result    = DATA(lt_result).

        LOOP AT lt_result INTO DATA(ls_result).

          APPEND VALUE #( %key-purchaseorder = ls_expheader-po_number
                          purchaseorder      = ls_expheader-po_number
                          %msg               = new_message(
                          id       = ls_result-id
                          number   = ls_result-number
                          severity = SWITCH #( ls_result-type
                                               WHEN 'S' THEN if_abap_behv_message=>severity-success
                                               WHEN 'I' THEN if_abap_behv_message=>severity-information
                                               WHEN 'W' THEN if_abap_behv_message=>severity-warning
                                               ELSE if_abap_behv_message=>severity-error )
                          v1       = ls_result-message_v1
                          v2       = ls_result-message_v2
                          v3       = ls_result-message_v3
                          v4       = ls_result-message_v4
                        )
          ) TO reported-zi_purchaseorder.

        ENDLOOP.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
