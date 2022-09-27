public with sharing class CaseController1 {
    @AuraEnabled(cacheable=true)
    public static Case fetchCase(Id caseId){
        return [SELECT AccountId FROM Case where id=:caseId LIMIT 1];
    }


 
}