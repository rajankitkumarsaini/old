public with sharing class GetStatus {
    
    public static string GetStatusValue(Id recId){
        List<Case> LstStatus=new List<case>();
        String StatusValue;
        LstStatus=[select Status From Case Where Id=:recId];
        StatusValue= String.valueof(LstStatus.Get(0));
        return(StatusValue);
    }

}