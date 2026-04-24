@AbapCatalog: {
   sqlViewName:            'ZILANGUAGEHELP',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '言語キー検索ヘルプ'
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
  typeName:       '言語キー検索ヘルプ',
  typeNamePlural: '言語キー検索ヘルプ'
}
@ObjectModel.representativeKey: 'LanguageCode'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP

define view ZI_LANGUAGE_VH
   as select distinct from I_LanguageText
    {
   @UI.hidden: true
   key Language,
    @ObjectModel.text.element:  [ 'LanguageName' ]
    @Search: {
      defaultSearchElement: true,
      ranking:              #HIGH,
      fuzzinessThreshold:   0.9
    }
    key LanguageCode,
    @Semantics.text: true
    @Search: {
      defaultSearchElement: true,
      fuzzinessThreshold: 0.9,
      ranking:            #LOW 
    }   
    LanguageName
}
where Language = $session.system_language

