CLASS zcl_load_data_0090 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_load_data_0090 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA: lt_header TYPE TABLE OF zheader_0090,
          lt_items  TYPE TABLE OF zitems_0090.

    "** SALES ORDERS - HEADER **
    lt_header = VALUE #(
      ( header_id    = '0000000001'
        email        = 'John.Finkie@gmail.com'
        firstname    = 'John'
        lastname     = 'Finkie'
        country      = 'CO'
        createon     = '20220915'
        deliverydate = '20221001'
        orderstatus  = 1   "D-Delivered, P-Pending, C-Cancelled, I-Incomplete
        imageurl     = '' )
      ( header_id    = '0000000002'
        email        = 'Marie.Josie@gmail.com'
        firstname    = 'Marie'
        lastname     = 'Josie'
        country      = 'FR'
        createon     = '20230119'
        deliverydate = '20230123'
        orderstatus  = 1   "D-Delivered, P-Pending, C-Cancelled, I-Incomplete
        imageurl     = '' )
      ).

    DELETE FROM zheader_0090.
    INSERT zheader_0090 FROM TABLE @lt_header.

    SELECT * FROM zheader_0090 INTO TABLE @lt_header.
    out->write( sy-dbcnt ).
    out->write( 'zheader_0090 data inserted successfully!').


    "** SALES ORDERS - ITEMS **
    lt_items = VALUE #(
      ( header_id    = '0000000001'
        item_id      = '0000000001'
        name         = 'COMP1'
        description  = 'Computer IBM Lenovo'
        releasedate  = '20220101'
        discontinueddate = '20251231'
        price        = 1500
        currency_code = 'USD'
        height        = 3
        width         = 15
        depth         = 10
        unitofmeasure2 = 'ST'
        quantity      = 5
        unitofmeasure = 'ST' )
      ( header_id    = '0000000001'
        item_id      = '0000000002'
        name         = 'COMP2'
        description  = 'Computer MAC Air'
        releasedate  = '20220515'
        discontinueddate = '20271231'
        price        = 2000
        currency_code = 'USD'
        height        = 2
        width         = 14
        depth         = 9
        unitofmeasure2 = 'ST'
        quantity      = 10
        unitofmeasure = 'ST' )
      ( header_id    = '0000000002'
        item_id      = '0000000001'
        name         = 'CEL1'
        description  = 'Celular Phone Samsung A'
        releasedate  = '20221020'
        discontinueddate = '20241231'
        price        = 1000
        currency_code = 'USD'
        height        = 1
        width         = 4
        depth         = 10
        unitofmeasure2 = 'ST'
        quantity      = 3
        unitofmeasure = 'ST' )
      ( header_id    = '0000000002'
        item_id      = '0000000002'
        name         = 'CEL2'
        description  = 'Celular Phone Motorola J1'
        releasedate  = '20220701'
        discontinueddate = '20271231'
        price        = 1800
        currency_code = 'USD'
        height        = 2
        width         = 12
        depth         = 8
        unitofmeasure2 = 'ST'
        quantity      = 15
        unitofmeasure = 'ST' )
      ).

    DELETE FROM zitems_0090.
    INSERT zitems_0090 FROM TABLE @lt_items.

    SELECT * FROM zitems_0090 INTO TABLE @lt_items.
    out->write( sy-dbcnt ).
    out->write( 'zitems_0090 data inserted successfully!').

  ENDMETHOD.
ENDCLASS.


