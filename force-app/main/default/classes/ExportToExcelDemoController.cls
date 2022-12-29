public with sharing class ExportToExcelDemoController { 
    public class ContactWrapper{  
      @AuraEnabled  
      public string contactName;  
      @AuraEnabled  
      public string contactEmail;  
      public ContactWrapper(Contact contactObj){  
        this.contactName = String.valueOf(contactObj.Quantity__c);  
        this.contactEmail = String.valueOf(contactObj.Price__c);  
      }  
    }  
    @AuraEnabled  
    public static List<ContactWrapper> getContacts(){  
      List<ContactWrapper> contactWrapperList = new List<ContactWrapper>();  
      for(Contact cwObj : [select id, Quantity__c, Price__c from Contact WHERE Name LIKE 'Test%']){  
        contactWrapperList.add(new ContactWrapper(cwObj));  
      }  
      return contactWrapperList;  
    }  
  }