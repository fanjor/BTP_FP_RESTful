@EndUserText.label: 'CDS - Consumption View Header'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.semanticKey: ['HeaderId']
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity Z_C_HEADER_0090 
  provider contract transactional_query
  as projection on Z_I_HEADER_0090
{
   key HeaderId,
   Email,
   Firstname,
   Lastname,
   @ObjectModel.text.element: ['CountryShortName']
   Country,
   _CountryText.CountryShortName as CountryShortName : localized,
   @Semantics.systemDateTime.createdAt: true
   Createon,
   Deliverydate,
   Orderstatus,
   Imageurl,
   /* Associations */
   _Items : redirected to composition child Z_C_ITEMS_0090,
   _CountryText
}
