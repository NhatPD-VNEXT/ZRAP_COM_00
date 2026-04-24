@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SVF機能 プリンタ名管理CDS'
@Metadata.ignorePropagatedAnnotations: true
//@ObjectModel.resultSet.sizeCategory:  #XS 
// → 指定していると、ポップアップ以外のヘルプとして動作しないため
@ObjectModel.dataCategory: #VALUE_HELP
define view entity ZI_ZY200T 
  as select from zy200t
{
    @UI.lineItem: [ { position: 10, importance: #HIGH } ]
    @ObjectModel.text.element: ['Printername'] 
    key printer as Printer,
    @UI.lineItem: [ { position: 20, importance: #HIGH } ]
    @Semantics.text: true
    printername as Printername
}
where langu = $session.system_language
