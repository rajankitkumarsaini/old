/*Author : Ankit Kr Saini
* Date : May 17, 2022
* Desc : Trigger to Update the Picklist Value on Case Field based on Record Creation
*/ 

trigger PickListFieldMappingTrigger on PickListFieldMapping__c (after insert) {
    try{
        if(Trigger.isAfter && Trigger.IsInsert){
            PickListFieldMappingTriggerHelper.getFieldMetadata(Trigger.new);
        }
        
        
    }Catch(Exception ex){
        System.debug('There is error in Trigger on Execution ' + ex.getMessage());
    }
}