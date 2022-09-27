/*Author : Ankit Kr Saini
* Date : May 17, 2022
* Desc : Helper class for 'PickListFieldMappingTrigger' Trigger.
*/ 
public class PickListFieldMappingTriggerHelper {
    public static void getFieldMetadata(List<PickListFieldMapping__c> listFieldMapping){
        String originValue='';
            String ProductValue='';
        try{
            String fieldId ='00N5j00000Cqexo';
            Map<String, String> mapOrigin_wise_Product = new Map<String, String>();
            for(PickListFieldMapping__c eachMapping : listFieldMapping){
                //mapOrigin_wise_Product.put(eachMapping.Origin__c, eachMapping.Product__c);
                originValue=eachMapping.Origin__c;
                ProductValue=eachMapping.Product__c;
                
            }
            System.debug('Origin+++++++++++++++++++++++'+originValue);
            System.debug('Product+++++++++++++++++++++++'+ProductValue);
            //System.debug('**RS MAP mapOrigin_wise_Product '+mapOrigin_wise_Product);
            //Get the Field Metadata
            makeAPICallToGetMetadata(fieldId,originValue,ProductValue);
            //System.debug('**RS THE Field Schema ** '+responseMetadataValue);
            
        }Catch(Exception ex){
            System.debug('Error in getFieldMetadata'+ex.getMessage());
        }
    }
    
    @future(callOut=true)
    public static void makeAPICallToGetMetadata(String fieldId,String originValue,String ProductValue){
        String responseMetadata='';
        String keyFieldID=fieldId;
        String originValueF=originValue;
        String ProductValueF=ProductValue;
        
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint('https://saini3-dev-ed.my.salesforce.com/services/data/v54.0/tooling/sobjects/CustomField/'+keyFieldID);
		req.setMethod('GET');
        
        Http h = new Http();
        HttpResponse res = h.send(req);
		responseMetadata =  res.getBody();
        System.debug('**RS THE Field Schema ** '+responseMetadata);
        //return responseMetadata;
        //Get the Substring after metadata
        //Append the Metadata: thing in begining of Substringed
        //
        //Using String class's substring function, Get the Metadata part
        String pivotKey ='"valueSetDefinition":{"sorted":false,"value":[';
        String subStringMeta = responseMetadata.subStringAfter(pivotKey);//string after pivot key
        System.debug(' After Pivot key '+subStringMeta);
        String subStringMeta1= responseMetadata.substringBefore(pivotKey);//string before pivot key
        System.debug('Before  Pivot key '+subStringMeta1);
        //string before pivot key+ pivot key+ UserString(for Concatenate )+string After pivot key
        String concatenateMetadata = subStringMeta1+pivotKey+'{"color":null,"default":false,"description":null,"isActive":null,"label":"'+ProductValueF+'","urls":null,"valueName":"'+ProductValueF+'"},'+subStringMeta;
        System.debug('After append 1 '+concatenateMetadata);
        
        //Controlling Field value Setting
        String pivotKey1 ='"valueSetName":null,"valueSettings":[';
        String subStringMeta2 = concatenateMetadata.subStringAfter(pivotKey1);//string after pivot key
        System.debug('After pivot key 1 '+subStringMeta2);
        String subStringMeta3= concatenateMetadata.substringBefore(pivotKey1);//String before pivot key
        System.debug('Before pivot key 1 '+subStringMeta3);
        //string before pivot key1+ pivot Key1 +Additional String +String After pivot Key1
        String trimconcatenateMetadata =subStringMeta3+pivotKey1+'{"controllingFieldValue":["'+originValueF+'"],"valueName":"'+ProductValueF+'"},'+subStringMeta2;
        System.debug('Before Patching string '+trimconcatenateMetadata);
        
        String pivotkey2='"Id":"00N5j00000CqexoEAB",';
        String subStringMeta4= trimconcatenateMetadata.substringBefore(pivotkey2);//string before pivot key2
        String pivotkey3='"EntityDefinitionId":"Case",';
        String subStringMeta5=trimconcatenateMetadata.substringAfter(pivotkey3);//string before pivot key3
        string finalconcatenateMetadata=subStringMeta4+subStringMeta5;
        System.debug('Before Patching final string '+finalconcatenateMetadata); 
        
        //new http request for Patching Back the string 
        HttpRequest requ = new HttpRequest();
        requ.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        requ.setHeader('Content-Type', 'application/json');
        requ.setEndpoint('https://saini3-dev-ed.my.salesforce.com/services/data/v54.0/tooling/sobjects/CustomField/'+keyFieldID);
        requ.setBody(finalconcatenateMetadata);
        requ.setMethod('PATCH');
        Http hObj = new Http();
        HttpResponse resp = hObj.send(requ);
        System.debug(resp);
    }
    
}