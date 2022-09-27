public with sharing class getAccountContacts {
    
    @AuraEnabled
    public static List<Account> getAccount(){
        return [SELECT Id, Name ,(Select Id ,Name,Email,Phone from Contacts) from Account];
    }
}