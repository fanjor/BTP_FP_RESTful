//@AbapCatalog.sqlViewName: 'ZVHEADER_0090'
//@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS - Interface Header'
define root view entity Z_I_HEADER_0090 
  as select from zheader_0090
  composition [1..*] of Z_I_ITEMS_0090 as _Items
  association [0..1] to I_Country as _Country on $projection.Country = _Country.Country
  association [0..*] to I_CountryText as _CountryText on $projection.Country = _CountryText.Country
{
    key header_id as HeaderId,
    email         as Email,
    firstname     as Firstname,
    lastname      as Lastname,
    country       as Country,
    //@Semantics.systemDateTime.createdAt: true
    createon      as Createon,
    deliverydate  as Deliverydate,
    orderstatus   as Orderstatus,
    imageurl      as Imageurl,
    _Items,
    _Country,
    _CountryText
}
