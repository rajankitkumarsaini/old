public with sharing class CreateLeadMappingRecord {
 
    /*Using multiple parameter in apex  controller */
    @AuraEnabled
    public static Lead_Field_Mapping__c LeadMappingAction(string AccountMapping, string ContactMapping, string OpportunityMapping){
        Lead_Field_Mapping__c LeadMappingObj = new Lead_Field_Mapping__c();
        LeadMappingObj.AccountMappings__c=AccountMapping;
        LeadMappingObj.ContactMapping__c=ContactMapping;
        LeadMappingObj.OpportunitiesMapping__c=OpportunityMapping;
      
 
        insert LeadMappingObj;
        return LeadMappingObj;
    }
}