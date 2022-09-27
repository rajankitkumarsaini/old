public with sharing class GetStatesNameByCountryController {

    @AuraEnabled(cacheable=true)
    public Static List<String> GetStatesByCountry(String countryName) {

        List<String> statesValues= new List<String>();
        Map<String, List<String>> mapCountryWiseStates = new Map<String, List<String>>();
        for(Generic_Metadata__mdt mtd: [Select Label, Value__c from Generic_Metadata__mdt Where Label=:countryName]){

                if(!mapCountryWiseStates.containsKey(mtd.Label)){
                statesValues = (mtd.Value__c).split(',');
                }

        }
        return(statesValues);
    }
    
}