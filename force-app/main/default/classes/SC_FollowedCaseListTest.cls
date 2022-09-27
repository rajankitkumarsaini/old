@isTest(SeeAllData=true)
public with sharing class SC_FollowedCaseListTest {
    @AuraEnabled
    @isTest
    public static Void getFollowedCasesTest(){
        try{
            SC_FollowedCaseList.getFollowedCases();
            /*Set<id> setCaseIDs = new Set<id>();
            List<Case> lstCase = new List<Case>();
            for(EntitySubscription entSub : [Select ParentId, SubscriberId from EntitySubscription where SubscriberId=:UserInfo.getUserId()]){
                setCaseIDs.add(entSub.ParentId);
            }

            if(setCaseIDs!=null && setCaseIDs.size()>0){
                lstCase = new List<Case>([Select id, CaseNumber, Subject, Status, Priority from Case where Id IN :setCaseIDs]);
            }
            System.debug('List Cases** '+lstCase);
            //return lstCase;*/

        }Catch(Exception ex){
            System.System.debug('Error in Followed Case Visibility **'+ex.getMessage());
            //throw new AuraHandledException(ex.getMessage());
            //Error_Log__c newLog = new Error_Log__c(Log_Details__c = ex.getMessage(), Object_Type__c = 'Case', Exception_Type__c = 'Error in Followed Case Visibility', Error_From__c = 'SC_FollowedCaseList', From_Name__c = UserInfo.getUserId());
            //insert newLog;
           // return null;
        }
    }
}