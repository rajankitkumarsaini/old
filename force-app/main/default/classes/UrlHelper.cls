public with sharing class UrlHelper {
    @AuraEnabled(cacheable=true)
    public static String reflectValue(String value) {
        list<case> actid=new list<case>();
        actid=[SELECT AccountId FROM Case Where id=:value];
        value=String.valueof(actid.Get(0));
    return value;
    }
}