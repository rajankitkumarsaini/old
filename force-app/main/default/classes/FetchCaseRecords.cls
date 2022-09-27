public with sharing class FetchCaseRecords {
    @AuraEnabled(cacheable=true)
    public static List<string> fetchCase(Id caseId){
        string AcntName;
        String Casereason;
        String Contactname;
        list<String> finallststr=new list<String>();
        list<case> cse=new list<case>();
        
        
        
        cse =[SELECT reason,Account.Name,Contact.Name FROM Case where id=:caseId LIMIT 1];
        system.debug(cse);
        for(Case caseiterator : cse) {
             AcntName=caseiterator.Account.Name;
             Contactname=caseiterator.Contact.Name;
             Casereason=caseiterator.reason;
    
    
}
finallststr.add(AcntName);
finallststr.add(Contactname);
finallststr.add(Casereason);
system.debug(finallststr);
return finallststr;
    }


    @AuraEnabled
    public static void updateCase(Case cse){
        update cse;
    }
}