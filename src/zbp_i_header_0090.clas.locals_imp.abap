CLASS lhc_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS cancelSalesOrder FOR MODIFY
      IMPORTING keys FOR ACTION Header~cancelSalesOrder.

    METHODS createSalesOrder FOR MODIFY
      IMPORTING keys FOR ACTION Header~createSalesOrder.

    METHODS createSalesOrderAction FOR MODIFY
      IMPORTING keys FOR ACTION Header~createSalesOrderAction RESULT result.


    METHODS get_features FOR FEATURES
      IMPORTING keys REQUEST requested_features FOR Header RESULT result.


    METHODS validateHeaderId FOR VALIDATE ON SAVE
      IMPORTING keys FOR Header~validateHeaderId.

    METHODS validateEmail FOR VALIDATE ON SAVE
      IMPORTING keys FOR Header~validateEmail.


    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Header RESULT result.

ENDCLASS.

CLASS lhc_Header IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD cancelSalesOrder.
  ENDMETHOD.

  METHOD createSalesOrder.
  ENDMETHOD.

  METHOD createSalesOrderAction.

    DATA: lt_create_header TYPE TABLE FOR CREATE z_i_header_0090\\Header.

    DATA(lv_today) = cl_abap_context_info=>get_system_date(  ).

*   Read business object:
    READ ENTITIES OF z_i_header_0090 IN LOCAL MODE
         ENTITY Header
         FIELDS ( HeaderId Email Firstname Lastname Country Createon Deliverydate Orderstatus Imageurl )
         WITH VALUE #( FOR row_key IN keys ( %key = row_key-%key ) )
         RESULT DATA(lt_entity_header)
         FAILED failed
         REPORTED reported.

*    CHECK failed IS INITIAL.

*   get max item value:
    SELECT MAX( header_id )
      FROM zheader_0090
      INTO @DATA(lv_header_id).

*   create new item:
    lt_create_header = VALUE #( FOR create_row IN lt_entity_header INDEX INTO idx
                                ( HeaderId     = lv_header_id + idx
                                  Email        = create_row-Email
                                  Firstname    = create_row-Firstname
                                  Lastname     = create_row-Lastname
                                  Country      = create_row-Country
                                  Createon     = lv_today
                                  Deliverydate = create_row-Deliverydate
                                  Orderstatus  = 1
                                  Imageurl     = create_row-Imageurl )
                              ).

*   save information into DB:
    MODIFY ENTITIES OF z_i_header_0090
           IN LOCAL MODE ENTITY Header
           CREATE FIELDS ( HeaderId
                           Email
                           Firstname
                           Lastname
                           Country
                           Createon
                           Deliverydate
                           Orderstatus
                           Imageurl )
           WITH lt_create_header
           MAPPED mapped
           FAILED failed
           REPORTED reported.

*   return results:
    result = VALUE #( FOR result_row IN lt_create_header INDEX INTO idx
                      ( %cid_ref = keys[ idx ]-%cid_ref
                        %key     = keys[ idx ]-%key
                        %param   = CORRESPONDING #( result_row )
                      )
                    ).

  ENDMETHOD.


  METHOD validateHeaderId.

*   Read business object:
    READ ENTITIES OF z_i_header_0090 IN LOCAL MODE
         ENTITY Header
         FIELDS ( HeaderId )
*         WITH CORRESPONDING #( keys )
         WITH VALUE #( FOR <row_key> IN keys ( %key = <row_key>-%key ) )
         RESULT DATA(lt_header).

    DATA: lt_saleso TYPE SORTED TABLE OF zheader_0090 WITH UNIQUE KEY header_id.

    lt_saleso = CORRESPONDING #( lt_header DISCARDING DUPLICATES MAPPING header_id = HeaderId EXCEPT * ).
    DELETE lt_saleso WHERE header_id IS INITIAL.

    SELECT FROM zheader_0090 FIELDS header_id
           FOR ALL ENTRIES IN @lt_saleso
           WHERE header_id = @lt_saleso-header_id
           INTO TABLE @DATA(lt_headerDB).

    LOOP AT lt_saleso ASSIGNING FIELD-SYMBOL(<fs_saleso>).

      IF <fs_saleso>-header_id IS NOT INITIAL AND
        line_exists( lt_headerdb[ header_id = <fs_saleso>-header_id ] ).

        APPEND VALUE #( HeaderId = <fs_saleso>-header_id ) TO failed-header.

        APPEND VALUE #( HeaderId = <fs_saleso>-header_id
                        %msg     = new_message( id       = 'ZMC_SALESORDER_0090'
                                                number   = '001'
                                                v1       = <fs_saleso>-header_id
                                                severity = if_abap_behv_message=>severity-error
                                   )
                        %element-HeaderId = if_abap_behv=>mk-on
                      ) TO reported-header.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD validateEmail.

*   Read business object:
    READ ENTITIES OF z_i_header_0090 IN LOCAL MODE
         ENTITY Header
         FIELDS ( HeaderId Email )
         WITH VALUE #( FOR <row_key> IN keys ( %key = <row_key>-%key ) )
         RESULT DATA(lt_header).

    LOOP AT lt_header ASSIGNING FIELD-SYMBOL(<fs_header>).

      IF <fs_header>-email IS INITIAL OR <fs_header>-email IS NOT ASSIGNED.
        APPEND VALUE #( %key = <fs_header>-%key
                        HeaderId = <fs_header>-HeaderId ) TO failed-header.

        APPEND VALUE #( %key = <fs_header>-%key
                        %msg     = new_message( id       = 'ZMC_SALESORDER_0090'
                                                number   = '002'
                                                v1       = <fs_header>-HeaderId
                                                severity = if_abap_behv_message=>severity-error
                                   )
                        %element-HeaderId = if_abap_behv=>mk-on
                      ) TO reported-header.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD get_features.

*   Read business object:
    READ ENTITIES OF z_i_header_0090 IN LOCAL MODE
         ENTITY Header
         FIELDS ( HeaderId Orderstatus )
         WITH VALUE #( FOR row_key IN keys ( %key = row_key-%key ) )
         RESULT DATA(lt_header_result).

*   return results:
    result = VALUE #( FOR header_row IN lt_header_result
                      ( %key     = header_row-%key
                        %field-Orderstatus = if_abap_behv=>fc-f-read_only
                        %assoc-_Items      = if_abap_behv=>fc-o-enabled
                      )
                    ).

  ENDMETHOD.

ENDCLASS.
