public class AccountUpdateWithJson {
    public static void UpdateAccount(){
        String JsonStr='[{"Id": "0015j00000e7ngMAAQ","Name": "test1","Description": "Alawalpur"}, {"Id": "0015j00000dSxnwAAC","Name": "test2","Description": "Ala"}]';
        
        List<Account> Acclst=new List<Account>();
        List<Object> AccountsRecord = (List<Object>) JSON.deserializeUntyped(JsonStr);
        List<JsontoApexCode> AccountsRecords = (List<JsontoApexCode>) JSON.deserialize(JSON.serialize(AccountsRecord), List<JsontoApexCode>.class);
        System.debug('Print::'+ AccountsRecords);
        for(JsontoApexCode tec:AccountsRecords){
            Account AccountData=new Account();
            system.debug(tec.Id);
            AccountData.Id=tec.Id;
            system.debug(AccountData.Id);
            system.debug(tec.Name);
            AccountData.Name=tec.Name;
            system.debug(tec.Description);
            AccountData.Description=tec.Description;
            Update AccountData;
        }
    }
}