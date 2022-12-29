public with sharing class AccountLeadMappings {
    @AuraEnabled(cacheable=true)
    public static List<Account_Mappings__c> getLeadtoAccountMappings(){
        try {
            return[Select Lead_Fields__c,Account_Fields__c From Account_Mappings__c];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}