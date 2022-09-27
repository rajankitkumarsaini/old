trigger CreateRelatedReordQualifiedLead on Lead__c (after insert,after update) {
    if((Trigger.isInsert || Trigger.isUpdate) && Trigger.isAfter ){
         List<Opportunity__C> lstOpportunity = new List<Opportunity__C>();
         List<Account> lstAccount = new List<Account>();
         List<Contact> lstContact = new List<Contact>();
        
        for(Lead__c ldRecord : Trigger.New){
            if(ldRecord.Lead_Status__c=='Closed-Converted'){
                Opportunity__C oprec = new Opportunity__C();
                Account acntrec = new Account();
                Contact contrec = new Contact();
            
            acntrec.Name=ldRecord.First_name__c;
            acntrec.AnnualRevenue=ldRecord.Annual_Revenue__c;
            acntrec.Industry=ldRecord.Industry__c;
            acntrec.Phone=ldRecord.Phone__c;
            acntrec.Rating=ldRecord.Rating__c;
            acntrec.Website=ldRecord.Website__c;
            acntrec.ShippingCity=ldRecord.City__c;
            acntrec.ShippingCountry=ldRecord.Country__c;
            acntrec.ShippingState=ldRecord.State_Province__c;
            lstAccount.Add(acntrec);
            
            
            contrec.MobilePhone=ldRecord.Phone__c;
            contrec.Phone=ldRecord.Phone__c;
            contrec.Email=ldRecord.Email__c;
            contrec.LeadSource=ldRecord.Lead_Source__c;
            lstContact.Add(contrec);
            
            oprec.Amount__c=ldRecord.Annual_Revenue__c;
            oprec.Lead_Source__c=ldRecord.Lead_Source__c;
            oprec.Opportunity_Name__c=ldRecord.Name;
            lstOpportunity.Add(oprec);

            
        }
        if(!lstOpportunity.isEmpty())
            Insert lstOpportunity;
        if(!lstAccount.isEmpty())
            Insert lstAccount;
        if(!lstContact.isEmpty())
            Insert lstContact;
            }
    }
     
}