public with sharing class ContactController {
   @AuraEnabled(cacheable=true)
   public static List<Contact> findContactByAccountName(String AccountName){
    try {
        return[
            SELECT Id,Name,Email,Phone
            FROM Contact
            WHERE Name=:AccountName
        ];
    } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
    }
   }
}