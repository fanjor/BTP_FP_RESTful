CLASS lhc_Items DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS validateItemId FOR VALIDATE ON SAVE
      IMPORTING keys FOR Items~validateItemId.

ENDCLASS.

CLASS lhc_Items IMPLEMENTATION.

  METHOD validateItemId.

*   Read business object:
    READ ENTITIES OF z_i_header_0090 IN LOCAL MODE
         ENTITY Items
         FIELDS ( ItemID )
*         WITH CORRESPONDING #( keys )
         WITH VALUE #( FOR <row_key> IN keys ( %key = <row_key>-%key ) )
         RESULT DATA(lt_items).

    DATA: lt_saleso TYPE SORTED TABLE OF zitems_0090 WITH UNIQUE KEY header_id item_id.

    lt_saleso = CORRESPONDING #( lt_items DISCARDING DUPLICATES MAPPING header_id = HeaderId item_id = ItemId EXCEPT * ).
    DELETE lt_saleso WHERE header_id IS INITIAL.
    DELETE lt_saleso WHERE item_id IS INITIAL.

    SELECT FROM zitems_0090 FIELDS header_id, item_id
           FOR ALL ENTRIES IN @lt_saleso
           WHERE header_id = @lt_saleso-header_id
             AND item_id   = @lt_saleso-item_id
           INTO TABLE @DATA(lt_itemsDB).

    LOOP AT lt_saleso ASSIGNING FIELD-SYMBOL(<fs_saleso>).

      IF <fs_saleso>-header_id IS NOT INITIAL AND
         <fs_saleso>-item_id IS INITIAL AND
        line_exists( lt_itemsdb[ header_id = <fs_saleso>-header_id ] ).

        APPEND VALUE #( HeaderId = <fs_saleso>-header_id ) TO failed-header.

        APPEND VALUE #( HeaderId = <fs_saleso>-header_id
                        %msg     = new_message( id       = 'ZMC_SALESORDER_0090'
                                                number   = '004'
                                                v1       = <fs_saleso>-header_id
                                                v2       = <fs_saleso>-item_id
                                                severity = if_abap_behv_message=>severity-error
                                   )
                        %element-HeaderId = if_abap_behv=>mk-on
                      ) TO reported-header.
      ENDIF.

      IF <fs_saleso>-header_id IS NOT INITIAL AND
         <fs_saleso>-item_id IS NOT INITIAL AND
        line_exists( lt_itemsdb[ header_id = <fs_saleso>-header_id item_id = <fs_saleso>-item_id ] ).

*        APPEND VALUE #( HeaderId = <fs_saleso>-header_id ItemId = <fs_saleso>-item_id ) TO failed-header.
        APPEND VALUE #( HeaderId = <fs_saleso>-header_id ) TO failed-header.

        APPEND VALUE #( HeaderId = <fs_saleso>-header_id
*                        ItemId   = <fs_saleso>-item_id
                        %msg     = new_message( id       = 'ZMC_SALESORDER_0090'
                                                number   = '003'
                                                v1       = <fs_saleso>-header_id
                                                v2       = <fs_saleso>-item_id
                                                severity = if_abap_behv_message=>severity-error
                                   )
                        %element-HeaderId = if_abap_behv=>mk-on
                      ) TO reported-header.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
