@AbapCatalog: {
   sqlViewName:            'ZIPURCHASINGGRP',
   compiler.compareFilter: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '購買グループ検索ヘルプ'
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
  typeName:       '購買グループ検索ヘルプ',
  typeNamePlural: '購買グループ検索ヘルプ'
}
@ObjectModel.representativeKey: 'PurchasingGroup'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP

define view ZI_PurchasingGroup_VH
  as select from I_PurchasingGroup as PurchasingGroup

{

      @ObjectModel.text.element:  [ 'PurchasingGroupName' ]
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7}
//      @EndUserText.label: 'Purchasing Group'
//      @EndUserText.quickInfo: 'Purchasing Group'
  key PurchasingGroup.PurchasingGroup            as PurchasingGroup,

      @Semantics.text: true
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7  }
      PurchasingGroup.PurchasingGroupName        as PurchasingGroupName,

      @Search: { defaultSearchElement: true, ranking: #LOW  }
//      @EndUserText.label: 'Tel. No. of Purchasing Grp.'
//      @EndUserText.label: '購買グループの電話番号'
      PurchasingGroup.PurchasingGroupPhoneNumber as PurchasingGroupPhoneNumber,

      @Search: { defaultSearchElement: true, ranking: #LOW  }
//      @EndUserText.label: 'Tel. No. with Dialing Code'
//      @EndUserText.label: '電話番号 (ダイアルコードあり)'
      PurchasingGroup.PhoneNumber                as PhoneNumber,

      @Search: { defaultSearchElement: true, ranking: #LOW  }
      PurchasingGroup.PhoneNumberExtension       as PhoneNumberExtension,

      @Search: { defaultSearchElement: true, ranking: #LOW  }
//      @EndUserText.label: 'Fax'
      PurchasingGroup.FaxNumber                  as FaxNumber,

//      @Semantics.eMail.address: true
      @Search: { defaultSearchElement: true, ranking: #MEDIUM, fuzzinessThreshold: 0.7  }
//      @EndUserText.label: 'Email Address'
      PurchasingGroup.EmailAddress               as EmailAddress

}
