@EndUserText.label: 'CDS - Consumption View Items'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity Z_C_ITEMS_0090 
  /* provider contract transactional_query */
  as projection on Z_I_ITEMS_0090
{
    key HeaderId,
    key ItemId,
    Name,
    Description,
    Releasedate,
    Discontinueddate,
    @Semantics.amount.currencyCode : 'CurrencyCode'
    Price,
    @Semantics.currencyCode: true
    CurrencyCode,
    @Semantics.quantity.unitOfMeasure : 'Unitofmeasure2'
    Height,
    @Semantics.quantity.unitOfMeasure : 'Unitofmeasure2'
    Width,
    @Semantics.quantity.unitOfMeasure : 'Unitofmeasure2'
    Depth,
    Unitofmeasure2,
    @Semantics.quantity.unitOfMeasure : 'Unitofmeasure'
    Quantity,
    Unitofmeasure,
    /* Associations */
    _Header : redirected to parent Z_C_HEADER_0090,
    _Currency,
    _UnitOfMeasure,
    _UnitOfMeasure2
}
