public class MessagingHelperUtility 
{
	Public static void SendBatchJobStatusNotificationEmail(AsyncApexJob jobDetails,String jobName,Integer totalRecords)
    {
       if(jobDetails.Id != Null) 
       {
           Messaging.SingleEmailMessage sEmail = new Messaging.SingleEmailMessage();
           
           		String[] toAddress = new String[]{jobDetails.CreatedBy.Email, 'rajankitkumarsaini@gmail.com'};
                sEmail.setToAddresses(toAddress);
           
           		sEmail.setSenderDisplayName('Tesla Sales Support Center');
           
           		sEmail.setReplyTo('support@tesla.com');
           
           		String emailSubject = 'Weekly Customers Total Account Job Status : '+jobName+ ' ('+ jobDetails.Id+ ').';
           		sEmail.setSubject(emailSubject);
           
           		String emailContent = 'Dear Customer Support Team, <br/><br/> '+
                					'We are pleased to Inform you, that Weekly Customers Total Account Batch Job has been Processed Successfully. <br/><br/>'+
                					'Here are the Batch Job Results...: <br/><br/>'+
                					'Batch Job Id is.....: '+ jobDetails.Id+
                					'<br/>Batch Job Name is.....: '+jobName +
                					'<br/>Batch Job Status is......: '+ jobDetails.Status+
                					'<br/>Total Number Of Batches Available...: '+ jobDetails.TotalJobItems+
                					'<br/>Number of Batches Processed......: '+ jobDetails.JobItemsProcessed+
                					'<br/>Number of Batches Failed......: '+ jobDetails.NumberOfErrors+
                					'<br/>Batch Job Owner Email Address.....: '+ jobDetails.CreatedBy.Email+
                    				'<br/>Total Created Account Records are.....: '+ totalRecords +
                					'<br/><br/> Please Contact on the below address, if any queries. <br/><br/>'+
                					'***<i>This is a System-Generated Email. Please Do Not Reply.</i><br/><br/>'+
                					'Thanks & Regards, <br/>Customer Support Center, <br/>Tesla Inc.';
           		sEmail.setHtmlBody(emailContent);
           
           		Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {sEmail});           	
       }
    }
}