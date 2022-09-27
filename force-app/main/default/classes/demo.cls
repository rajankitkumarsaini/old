public class demo {
    public string str;
    private static Final string demostr;
    static{
        demostr='Ankit';
    }
    public demo()
    {
        this(demostr);
    }
    public demo(string temp){
        this.str=temp;
        }
    public void print(){
        system.debug('Display text:'+str);
    }
        
    

}