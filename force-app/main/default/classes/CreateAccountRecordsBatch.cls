Global class CreateAccountRecordsBatch implements Database.Batchable<Account>,Database.Stateful
{  
    global Map<Id, String> errorMap;
    global Map<Id, Account> IdToAccountMap;
    global Map<Id, String> successMap;
    global String baseURL;
    Global Integer totalRecords = 0;
    Global Integer totaldescription = 0;
    global CreateAccountRecordsBatch(){
        errorMap = new Map<Id, String>();
        successMap = new Map<Id, String>();
        IdToAccountMap = new Map<Id, Account>();
        baseURL = URL.getSalesforceBaseUrl().toExternalForm();
    }

    Global Iterable<Account> Start(Database.BatchableContext bc)
    {
        return new MediatorofCreateAccountRecrdsBatch();
    }
    Global void Execute(Database.BatchableContext bc,list<Account> scope)
    {
        List<Account> accsToInsert = new List<Account>();
        List<Contact> conlist = new List<Contact>();
        for(Account acc : scope){ 
           acc.Name = 'AccountTest00'+ totalRecords++;
           acc.Description='description'+ totaldescription++;
           accsToInsert.add(acc); 
       } 
        if(accsToInsert.size() > 0){
            List<Database.SaveResult> dsrs = Database.Insert(accsToInsert, false);
            Integer index = 0;
             for(Database.SaveResult dsr : dsrs){
                 if(!dsr.isSuccess()){
                      String errMsg = dsr.getErrors()[0].getMessage();
                      errorMap.put(accsToInsert[index].Id, errMsg);
                     } else {
                         String sucMsg = baseURL + '/' + accsToInsert[index].Id;
                         successMap.put(accsToInsert[index].Id, sucMsg);
                     }
                  IdToAccountMap.put(accsToInsert[index].Id, accsToInsert[index]);
                 index++;
             }
        }
        
       //insert accsToInsert;
        for(Account acc1 : accsToInsert){
          Contact con = new Contact();
           con.lastname = 'Contact_CreatedByBatchClass';
           con.accountid = acc1.id;
           con.Description= acc1.Description;
           conlist.add(con);
   }  
   Insert conlist;
        
    }
    Global Void Finish(Database.BatchableContext bc)
    {
        if(! IdToAccountMap.isEmpty()) {
         System.debug('Batch Job Id is.....: '+ bc.getJobId());
        
         AsyncApexJob jobDetails = [ Select id, status, totalJobItems, jobItemsProcessed,
                                  			numberOFErrors, CreatedBy.Email
                                  				from AsyncApexJob
                                  					Where id =: bc.getJobId()];
        // MessagingHelperUtility.SendBatchJobStatusNotificationEmail(jobDetails,'Create Account Records Batch information',totalRecords);
          String body = 'Your batch job '
                + 'CreateAccountRecordsBatch '
                + 'has finished. \n'
                + 'There were total'
                + IdToAccountMap.size()
                + ' records. Please find the attached success and error records CSV.';
            String subject = 'Account - Apex Batch Result for AccountUpdateBatch';
            // Define the email
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            // Define email file attachment list
            Messaging.EmailFileAttachment[] emailAttList = new List<Messaging.EmailFileAttachment>();
            if(!errorMap.isEmpty()){
                // Creating the CSV file for error
                String finalstr = 'Id, Name, Error \n';
               
                String attName = 'AccountErrors' + system.now().format('YYYYMMDDhhmm') + '.csv';
                for(Id id  : errorMap.keySet()){
                    string err = errorMap.get(id);
                    Account acct = (Account) IdToAccountMap.get(id);
                    string recordString = '"'+id+'","'+acct.Name+'","'+err+'"\n';
                    finalstr = finalstr +recordString;
                }
                               
                // Create the email attachment    
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                efa.setFileName(attName);
                efa.setBody(Blob.valueOf(finalstr));
                emailAttList.add(efa);
            }
            if(! successMap.isEmpty()) {
                // Creating the CSV file for successful updates
                String finalstr = 'Id, Name, Link \n';
                String attName = 'AccountSuccess' + system.now().format('YYYYMMDDhhmm') + '.csv';
                for(Id id  : successMap.keySet()){
                    string suc = successMap.get(id);
                    Account acct = (Account) IdToAccountMap.get(id);
                    string recordString = '"'+id+'","'+acct.Name+'","'+suc+'"\n';
                    finalstr = finalstr +recordString;
                }
               
                // Create the email attachment    
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                efa.setFileName(attName);
                efa.setBody(Blob.valueOf(finalstr));
                emailAttList.add(efa);
                 
            }
            // Sets the paramaters of the email
            email.setSubject( subject );
            email.setToAddresses( new String[] {jobDetails.CreatedBy.Email, 'rajankitkumarsaini@gmail.com'} );
            email.setPlainTextBody( body );
            email.setFileAttachments(emailAttList);
           
            // Sends the email
            Messaging.SendEmailResult [] r =
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }
    }
}