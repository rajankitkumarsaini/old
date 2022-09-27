public with sharing class GetAccountData {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountData() {
        return [SELECT Id, Name ,(Select Id ,Name from Contacts) from Account];
    }
}