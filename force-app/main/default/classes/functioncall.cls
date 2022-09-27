public class functioncall {
    public void mainvaluemethod()
    {
        string weburl='www.asdf.com';
        system.debug('before pbv call'+weburl);
        pbv(weburl);
        system.debug('After pbv call'+weburl);
    }
    private void pbv(string temp)
    {
         temp='www.salesforce.com';    
    }
    public void mainrefrencemethod()
    {
        Account str=new Account();
        str.Name='Test Account';
        str.Website='www.apexhours.com';
        system.debug('before pbr call'+str);
        pbr(str);
        system.debug('After pbv call'+str);
    }
     private void pbr(Account str)
    {
         str.Website='www.salesforce.com';    
    }
    

}