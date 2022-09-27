public with sharing class CaseController {
    @AuraEnabled(cacheable=true)
    public static Case fetchCase(Id caseId){
        return [SELECT CaseNumber,Subject,Account.Name,Description FROM Case where id=:caseId LIMIT 1];
    }


    @AuraEnabled
    public static void updateCase(Case cse){
        update cse;
    }

    @AuraEnabled
    public static case createCase(Case cse){

        insert cse;
        return cse;


    }
}