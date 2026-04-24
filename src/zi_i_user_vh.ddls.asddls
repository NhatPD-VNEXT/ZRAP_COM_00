@AbapCatalog: {
   sqlViewName:            'ZIIUSERVH',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ユーザ検索ヘルプ'
@Search.searchable: true
@Consumption.ranked: true
@ObjectModel:{
  usageType:{
    serviceQuality: #C, 
    sizeCategory: #XL, 
    dataClass: #MASTER
  }
}
@UI.headerInfo:{
  typeName:       'ユーザ検索ヘルプ',
  typeNamePlural: 'ユーザ検索ヘルプ'
}
@ObjectModel.representativeKey: 'UserID'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP
define view ZI_I_USER_VH 
  as select from I_User
{
  @ObjectModel.text.element:  [ 'UserDescription' ]
  @Search: {
    defaultSearchElement: true,
    ranking:              #HIGH,
    fuzzinessThreshold:   0.9
  }
  key cast(UserID as zzuserid preserving type ) as UserID,
  @Semantics.text: true
  @Search: {
    defaultSearchElement: true,
    ranking: #LOW,
    fuzzinessThreshold: 0.9
  }
  UserDescription
}
where IsTechnicalUser = ''
