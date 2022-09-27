public with sharing class GetObjectFieldLabelUsingToolingAPI {
  public GetObjectFieldLabelUsingToolingAPI(){

  }
  @AuraEnabled(cacheable=true)
  public static Map<String,String> getAccountFieldsLabel(){
       
       Map<String,String> apiNameMappingWithLabels=new  Map<String,String>();
       Map<String,String> filteredApiNameMappingWithLabels=new  Map<String,String>();
      
      
      //Preparing Field API Name List
       String strFieldsApiNameSchema = makeToolingAPICall('Account');
       List<String> FieldsApiName=new List<String>();
       Map<String, Object> masterMapApiName = (Map<String, Object>) JSON.deserializeUntyped(strFieldsApiNameSchema);
       List<Object> listApiNamerecords = (List<Object>)masterMapApiName.get('records');
       List<JsonParser.records> lstApiNamerecords = (List<JsonParser.records>) JSON.deserialize(JSON.serialize(listApiNamerecords), List<JsonParser.records>.class);
       for(JsonParser.records selection : lstApiNamerecords){
          apiNameMappingWithLabels.put(selection.DeveloperName,selection.Label);
    
       }
      if(apiNameMappingWithLabels.ContainsKey('DunsNumber'))
        filteredApiNameMappingWithLabels.put('DunsNumber',apiNameMappingWithLabels.Get('DunsNumber'));
      if(apiNameMappingWithLabels.ContainsKey('Industry'))
        filteredApiNameMappingWithLabels.put('Industry',apiNameMappingWithLabels.Get('Industry'));
      if(apiNameMappingWithLabels.ContainsKey('AnnualRevenue'))
        filteredApiNameMappingWithLabels.put('AnnualRevenue',apiNameMappingWithLabels.Get('AnnualRevenue'));
      if(apiNameMappingWithLabels.ContainsKey('Description'))
        filteredApiNameMappingWithLabels.put('Description',apiNameMappingWithLabels.Get('Description'));
      if(apiNameMappingWithLabels.ContainsKey('NumberOfEmployees'))
        filteredApiNameMappingWithLabels.put('NumberOfEmployees',apiNameMappingWithLabels.Get('NumberOfEmployees'));
      if(apiNameMappingWithLabels.ContainsKey('NumberofLocations'))
        filteredApiNameMappingWithLabels.put('NumberofLocations',apiNameMappingWithLabels.Get('NumberofLocations'));
      if(apiNameMappingWithLabels.ContainsKey('Phone'))
        filteredApiNameMappingWithLabels.put('Phone',apiNameMappingWithLabels.Get('Phone'));
      if(apiNameMappingWithLabels.ContainsKey('Website'))
        filteredApiNameMappingWithLabels.put('Website',apiNameMappingWithLabels.Get('Website'));
      
      for (String key: filteredApiNameMappingWithLabels.keyset()){
          system.debug('The Current Key ='+key);
  
           system.debug('The Current value ='+ filteredApiNameMappingWithLabels.get(key));
      }
      system.debug('Returned map'+ apiNameMappingWithLabels);
      return filteredApiNameMappingWithLabels;
  }
  @AuraEnabled(cacheable=true)
   public static Map<String,String> getContactFieldsLabel(){
       system.debug('Contact Fields=========================================================================');
       Map<String,String> apiNameMappingWithLabels=new  Map<String,String>();
       Map<String,String> filteredApiNameMappingWithLabels=new  Map<String,String>();
      
      //Preparing Field API Name List
       String strFieldsApiNameSchema = makeToolingAPICall('Contact');
       List<String> FieldsApiName=new List<String>();
       Map<String, Object> masterMapApiName = (Map<String, Object>) JSON.deserializeUntyped(strFieldsApiNameSchema);
       List<Object> listApiNamerecords = (List<Object>)masterMapApiName.get('records');
       List<JsonParser.records> lstApiNamerecords = (List<JsonParser.records>) JSON.deserialize(JSON.serialize(listApiNamerecords), List<JsonParser.records>.class);
       for(JsonParser.records selection : lstApiNamerecords){
          apiNameMappingWithLabels.put(selection.DeveloperName,selection.Label);
    
       }
      if(apiNameMappingWithLabels.ContainsKey('DoNotCall'))
        filteredApiNameMappingWithLabels.put('DoNotCall',apiNameMappingWithLabels.Get('DoNotCall'));
      if(apiNameMappingWithLabels.ContainsKey('HasOptedOutOfEmail'))
        filteredApiNameMappingWithLabels.put('HasOptedOutOfEmail',apiNameMappingWithLabels.Get('HasOptedOutOfEmail'));
      if(apiNameMappingWithLabels.ContainsKey('Email'))
        filteredApiNameMappingWithLabels.put('Email',apiNameMappingWithLabels.Get('Email'));
      if(apiNameMappingWithLabels.ContainsKey('Description'))
        filteredApiNameMappingWithLabels.put('Description',apiNameMappingWithLabels.Get('Description'));
      if(apiNameMappingWithLabels.ContainsKey('LeadSource'))
        filteredApiNameMappingWithLabels.put('LeadSource',apiNameMappingWithLabels.Get('LeadSource'));
      if(apiNameMappingWithLabels.ContainsKey('MobilePhone'))
        filteredApiNameMappingWithLabels.put('MobilePhone',apiNameMappingWithLabels.Get('MobilePhone'));
      if(apiNameMappingWithLabels.ContainsKey('Phone'))
        filteredApiNameMappingWithLabels.put('Phone',apiNameMappingWithLabels.Get('Phone'));
      for (String key: filteredApiNameMappingWithLabels.keyset()){
          system.debug('The Current Key ='+key);
  
           system.debug('The Current value ='+ filteredApiNameMappingWithLabels.get(key));
      }
      return filteredApiNameMappingWithLabels;
  }
  @AuraEnabled(cacheable=true)
   public static Map<String,String> getOpportunityCFieldsLabel(){
       system.debug('Opportunity Fields=========================================================================');
       Map<String,String> apiNameMappingWithLabels=new  Map<String,String>();
       Map<String,String> filteredApiNameMappingWithLabels=new  Map<String,String>();
      
      //Preparing Field API Name List
       String strFieldsApiNameSchema = makeToolingAPICall('OpportunityC');
       List<String> FieldsApiName=new List<String>();
       Map<String, Object> masterMapApiName = (Map<String, Object>) JSON.deserializeUntyped(strFieldsApiNameSchema);
       List<Object> listApiNamerecords = (List<Object>)masterMapApiName.get('records');
       List<JsonParser.records> lstApiNamerecords = (List<JsonParser.records>) JSON.deserialize(JSON.serialize(listApiNamerecords), List<JsonParser.records>.class);
       for(JsonParser.records selection : lstApiNamerecords){
          apiNameMappingWithLabels.put(selection.DeveloperName,selection.Label);
    
       }
      if(apiNameMappingWithLabels.ContainsKey('Amount'))
        filteredApiNameMappingWithLabels.put('Amount',apiNameMappingWithLabels.Get('Amount'));
      if(apiNameMappingWithLabels.ContainsKey('Current_Generator_s'))
        filteredApiNameMappingWithLabels.put('Current_Generator_s',apiNameMappingWithLabels.Get('Current_Generator_s'));
      if(apiNameMappingWithLabels.ContainsKey('Opportunity_Name'))
        filteredApiNameMappingWithLabels.put('Opportunity_Name',apiNameMappingWithLabels.Get('Opportunity_Name'));
      if(apiNameMappingWithLabels.ContainsKey('Description'))
        filteredApiNameMappingWithLabels.put('Description',apiNameMappingWithLabels.Get('Description'));
      for (String key: filteredApiNameMappingWithLabels.keyset()){
          system.debug('The Current Key ='+key);
  
           system.debug('The Current value ='+ filteredApiNameMappingWithLabels.get(key));
      }
      return filteredApiNameMappingWithLabels;
  }
  
  
   @AuraEnabled(cacheable=true)
  public static Map<String,String> getLeadCFieldsLabel(){
       
    Map<String,String> apiNameMappingWithLabels=new  Map<String,String>();
    Map<String,String> filteredApiNameMappingWithLabels=new  Map<String,String>();
      
      
      //Preparing Field API Name List
       String strFieldsApiNameSchema = makeToolingAPICall('LeadC');
       List<String> FieldsApiName=new List<String>();
       Map<String, Object> masterMapApiName = (Map<String, Object>) JSON.deserializeUntyped(strFieldsApiNameSchema);
       List<Object> listApiNamerecords = (List<Object>)masterMapApiName.get('records');
       List<JsonParser.records> lstApiNamerecords = (List<JsonParser.records>) JSON.deserialize(JSON.serialize(listApiNamerecords), List<JsonParser.records>.class);
       for(JsonParser.records selection : lstApiNamerecords){
        apiNameMappingWithLabels.put(selection.DeveloperName,selection.Label);
  
     }
      
     for (String key: apiNameMappingWithLabels.keyset()){
      system.debug('The Current Key ='+key);

       system.debug('The Current value ='+ apiNameMappingWithLabels.get(key));
  }
      return apiNameMappingWithLabels;
  }
      

   public static string makeToolingAPICall(String ObjectName){
      String responseBody='';
      String baseURL='callout:FieldLabelNC';
      HttpRequest req = new HttpRequest();
      req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
     // req.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());        
      req.setTimeout(60000);
      req.setHeader('Content-Type', 'application/json');
      req.setEndpoint(baseURL+'?q=Select+DeveloperName,Label+From+FieldDefinition+where+EntityDefinition.Label=\''+String.escapeSingleQuotes(ObjectName)+'\'');
      req.setMethod('GET');
      Http h= new Http();
      HttpResponse res = h.send(req);
      responseBody = res.getBody();
        system.debug('responseBody========================================================================='+responseBody);
      return responseBody;
  
  }
 

}
