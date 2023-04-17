//@AbapCatalog.sqlViewName: 'ZVITEMS_0090'
//@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS - Interface Items'
define view entity Z_I_ITEMS_0090 
  as select from zitems_0090
  association to parent Z_I_HEADER_0090 as _Header on $projection.HeaderId = _Header.HeaderId
  association [1..1] to I_Currency as _Currency on $projection.CurrencyCode = _Currency.Currency
  association [1..1] to I_UnitOfMeasure as _UnitOfMeasure  on $projection.Unitofmeasure = _UnitOfMeasure.UnitOfMeasure
  association [1..1] to I_UnitOfMeasure as _UnitOfMeasure2 on $projection.Unitofmeasure = _UnitOfMeasure2.UnitOfMeasure
{
    key header_id    as HeaderId,
    key item_id      as ItemId,
    name             as Name,
    description      as Description,
    releasedate      as Releasedate,
    discontinueddate as Discontinueddate,
    @Semantics.amount.currencyCode : 'CurrencyCode'
    price            as Price,
    //@Semantics.currencyCode: true
    currency_code    as CurrencyCode,
    @Semantics.quantity.unitOfMeasure : 'Unitofmeasure2'
    height           as Height,
    @Semantics.quantity.unitOfMeasure : 'Unitofmeasure2'
    width            as Width,
    @Semantics.quantity.unitOfMeasure : 'Unitofmeasure2'
    depth            as Depth,
    unitofmeasure2   as Unitofmeasure2,
    @Semantics.quantity.unitOfMeasure : 'Unitofmeasure'
    quantity         as Quantity,
    unitofmeasure    as Unitofmeasure,
    _Header,
    _Currency,
    _UnitOfMeasure,
    _UnitOfMeasure2
}
