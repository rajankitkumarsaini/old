public class UpdateFieldSchema{

    public static string getUpdatedFieldSchema(String dependentFieldValue_z, String controllingValue_z, String dependentFieldId_z ){
        String dependentFieldValue = dependentFieldValue_z;//'REL HW - RS TEST';
        String controllingValue = controllingValue_z;// '7130-X5';
        String dependentFieldId = dependentFieldId_z;
        String strFieldSchema = makeToolingAPICall(dependentFieldId, '', 'GET');
       
        Map<String, Object> masterMap = (Map<String, Object>) JSON.deserializeUntyped(strFieldSchema);
        Map<String, Object> metadataMap = (Map<String, Object>) masterMap.get('Metadata');
        Map<String, Object> metadataMapValueSet = (Map<String, Object>)metadataMap.get('valueSet');
        Map<String, Object> metadataMapValueSetDefinition = (Map<String, Object>)metadataMapValueSet.get('valueSetDefinition');
        //To Add New Value in Dependent Field
        List<Object> listValues = (List<Object>)metadataMapValueSetDefinition.get('value');
       
       
        List<SC_JsonParserFieldSchema.value> lstvalue = (List<SC_JsonParserFieldSchema.value>) JSON.deserialize(JSON.serialize(listValues), List<SC_JsonParserFieldSchema.value>.class);
       
        //Create New Entry under target PickList Field
        SC_JsonParserFieldSchema.value newValue = new SC_JsonParserFieldSchema.value();
        newValue.color=null;
        newValue.default_z=null;
        newValue.description=null;
        newValue.isActive=null;
        newValue.label=dependentFieldValue;
        newValue.urls=null;
        newValue.valueName=dependentFieldValue;
       
        lstvalue.add(newValue); //List Ready for adding new Value.
        //Lets Prepare the JSON for Field Dependency
       
        //To Define the Dependencies b/w Controlling and Dependent
       
       
        //Prepare Mapping with Controlling
        /***********/
        List<Object>  valueSettingsList = (List<Object> )metadataMapValueSet.get('valueSettings');
        List<SC_JsonParserFieldSchema.valueSettings> valueSettingsListParsed = (List<SC_JsonParserFieldSchema.valueSettings>) JSON.deserialize(JSON.serialize(valueSettingsList), List<SC_JsonParserFieldSchema.valueSettings>.class);
        SC_JsonParserFieldSchema.valueSettings newSetting = new SC_JsonParserFieldSchema.valueSettings();

        newSetting.controllingFieldValue = new List<String>{controllingValue};
        newSetting.valueName = dependentFieldValue;
        valueSettingsList.add(newSetting);
       
        //System.debug('*** Added List** '+lstValueSetting);
        metadataMapValueSet.put('valueSettings',valueSettingsList);
       
        /************/
        //Add the values back to map and pass for next Call.
        metadataMapValueSetDefinition.put('value',lstvalue);
        metadataMapValueSet.put('valueSetDefinition',metadataMapValueSetDefinition);
        metadataMap.put('valueSet',metadataMapValueSet);
        String metadataPaylod = json.serialize(metadataMap);
        metadataPaylod = '{"Metadata":'+metadataPaylod+'}';
        metadataPaylod = metadataPaylod.replace('"default_z"','"default"');
       
        System.debug('**metadataPaylod2****'+metadataPaylod);
        //PATCH
        String strResponse = makeToolingAPICall(dependentFieldId,metadataPaylod,'PATCH');
        return strResponse;
    
    }
    
    public static string makeToolingAPICall(String dependentFieldId, String theBody, String methodName){
        String responseBody='';
        String updatedJsonBody= theBody;
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v53.0/tooling/sobjects/CustomField/'+dependentFieldId);
        req.setMethod(methodName);
        if(theBody!='')
        req.setBody(theBody);
        Http h= new Http();
        HttpResponse res = h.send(req);
        responseBody = res.getBody();
        return responseBody;
    
    }
    
    
    
    
    

}