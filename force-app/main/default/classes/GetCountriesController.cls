public with sharing class GetCountriesController {


    @AuraEnabled(cacheable=true)
    public static   Map<String, List<String>> getCountries() {
        
        Map<String, List<String>> countryList = new Map<String, List<String>>();
        for(Generic_Metadata__mdt mtd: [Select Label, Value__c from Generic_Metadata__mdt]){



            if(!countryList.containsKey(mtd.Label)){
             List<String> statesValues = (mtd.Value__c).split(',');
             countryList.put(mtd.Label, statesValues);
            }
        }
        
        return countryList;
        
    }
}