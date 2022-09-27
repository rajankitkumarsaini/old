global with sharing class AccountRemoter {

    public String accountName { get; set; }
    //public static Account account { get; set; }
    //public AccountRemoter() { } // empty constructor
    
    @RemoteAction
    global static boolean getAccount(String accountName) {
        //account = [SELECT Id, Name, Phone, Type, NumberOfEmployees 
                  // FROM Account WHERE Name = :accountName];
        //return account;
        system.debug('Account Name=====> '+ accountName);
        list<Account> account=new list<Account>();
        List<string> lsstr= new List<string> ();
        
        account = [SELECT Id, Name, Phone, Type, NumberOfEmployees 
                   FROM Account WHERE Name = :accountName];
        for(Account a: account){
          string str=String.valueOf(a.Name);
          lsstr.add(str);
        }
        if(lsstr.Contains(accountName)){
          return true;
        }
        else
	      return false;

    }
}