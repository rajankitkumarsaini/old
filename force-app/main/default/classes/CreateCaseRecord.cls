public with sharing class CreateCaseRecord {
    @AuraEnabled 
    public static String createTheCase(String description,String subject ){
        Case c = new Case();
        c.Description=description;
        c.Subject = subject;
        insert c;
        return c.id;
    }
}