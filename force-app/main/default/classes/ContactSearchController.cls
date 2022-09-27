public with sharing class ContactSearchController {
    @AuraEnabled(cacheable=true)
    public static list<Contact> getContacts(String accountId,String contactName){
     List<Contact> contactList = new List<Contact>();
     if(contactName!=''){
         String contName = '%' + contactName + '%';
         contactList = [SELECT id,name FROM Contact WHERE AccountId=:accountId AND name like:contName];
         return contactList;  
     }
     return contactList;
 }

}