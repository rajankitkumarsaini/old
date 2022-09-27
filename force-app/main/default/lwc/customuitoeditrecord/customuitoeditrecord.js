import { LightningElement,api,wire,track } from 'lwc';
import {updateRecord } from "lightning/uiRecordApi";
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import getContacts from '@salesforce/apex/ContactSearchController.getContacts';
import fetchCase from '@salesforce/apex/FetchCaseRecords.fetchCase';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAccounts from '@salesforce/apex/AccountSearchController.getAccounts';
import CASE_OBJECT from '@salesforce/schema/Case';
import CASE_REASON from '@salesforce/schema/Case.Reason';
import CONTACT_NAME from '@salesforce/schema/Case.ContactId';
import ACCOUNT_NAME from '@salesforce/schema/Case.AccountId';
import ID_FIELD from '@salesforce/schema/Case.Id';


export default class Customuitoeditrecord extends LightningElement {
    @api wiredCase;
    @api showdata;
    @api realFormData;
    //contact variables
    @api accountId;
    @track contactName = '';
    @track contactList = [];     
    @track contactId; 
    @track objectApiName='Contact'; 
    @track isshow1=false;
    @track messageResult1=false;
    @track isShowResult1 = true;   
    @track showSearchedValues1 = false;

    //lookup1 variables
    @track accountName = '';
    @track accountList = [];     
    @track accountId; 
    @track isshow=false;
    @track messageResult=false;
    @track isShowResult = true;   
    @track showSearchedValues = false; 
    //picklist variables
    @api recordId;
    @api selectedcaseReason;//value for Showing fetch from Case
    //getting values for showing purpose
    @wire (fetchCase , { caseId: '$recordId' })
    fetchedCase(resp){
        this.wiredCase = resp;
        this.realFormData = {... this.wiredCase.data};
        console.log('data ::::::' ,this.realFormData);
        console.log('type====+++++',typeof this.realFormData);
        console.log('object 1 value', this.realFormData[0]);
        this.accountName=this.realFormData[0];
        this.contactName=this.realFormData[1];
        this.selectedcaseReason=this.realFormData[2];
       
       // console.log(data.length);
       // for(let key in data){
       //     console.log('yahi hai kya ankit',data[key]);
       // }
 }

    @wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: CASE_REASON })
    reasonValues;
    @wire(getAccounts, {actName:'$accountName'})
    retrieveAccounts ({error, data}) {
        this.messageResult=false;
        if (data) {
             if(data.length>0 && this.isShowResult){
                this.accountList = data;                
                this.showSearchedValues = true; 
                this.messageResult=false;
            }            
            else if(data.length==0){
                this.accountList = [];                
                this.showSearchedValues = false;
                if(this.accountName!='')
                    this.messageResult=true;               
            }  
                
        } else if (error) {
            this.accountId =  '';
            this.accountName =  '';
            this.accountList=[];           
            this.showSearchedValues = false;
            this.messageResult=true;   
        }
    }   

//lookup2
@wire(getContacts, {accountId: '$accountId',
                        contactName:'$contactName'})
    retrieveContacts ({error, data}) {
       this.messageResult1=false;
       if (data) {
           // TODO: Error handling 
           console.log('data::'+data.length);
           if(data.length>0 && this.isShowResult1){
               this.contactList = data;                    
               this.showSearchedValues1 = true; 
               this.messageResult1=false;
           }            
           else if(data.length==0){
               this.contactList = [];                
               this.showSearchedValues1 = false;
               if(this.contactName!='')
                   this.messageResult1=true;               
           }  
               
       } else if (error) {
           // TODO: Data handling
           this.contactId =  '';
           this.contactName =  '';
           this.contactList=[];           
           this.showSearchedValues1 = false;
           this.messageResult1=true;   
       }
   } 
   //lookup2
   handleClick1(event){
    this.isShowResult1 = true;   
    this.messageResult1=false;        
  }   
  //lookup2
  handleKeyChange1(event){       
    this.messageResult1=false; 
    this.contactName = event.target.value;
  }  
  //lookup2
  handleParentSelection1(event){        
    this.showSearchedValues1 = false;
    this.isShowResult1 = false;
    this.messageResult1=false;
    //Set the parent calendar id
    this.contactId =  event.target.dataset.value;
    //Set the parent calendar label
    this.contactName =  event.target.dataset.label;      
    console.log('contactId::'+this.contactId);    
        
}

//lookup1
    handleClick(event){
        this.isShowResult = true;   
        this.messageResult=false;        
      }
//lookup1
handleKeyChange(event){       
    this.messageResult=false; 
    this.accountName = event.target.value;
  } 
//lookup1
handleParentSelection(event){        
    this.showSearchedValues = false;
    this.isShowResult = false;
    this.messageResult=false;
    //Set the parent calendar id
    this.accountId =  event.target.dataset.value;
    //Set the parent calendar label
    this.accountName =  event.target.dataset.label;      
    console.log('accountId::'+this.accountId);
        
}
//lookup1
handleOpenModal(event){
    this.isshow = true;
   }
//lookup1
handleCloseModal(event){
    this.isshow = false;
}   

//pikclist
    handleReasonChange(event) {
        this.selectedcaseReason = event.target.value;
        
    }
    
    SaveCase() {
        console.log('save case fire hua aage dekh');
        const fields = {};
        fields[ID_FIELD.fieldApiName] = this.recordId;
        console.log('save case fire hua aage dekh recordId',this.recordId);
        fields[CASE_REASON.fieldApiName] = this.selectedcaseReason;
        console.log('save case fire hua aage dekh reason',this.selectedcaseReason);
        fields[ACCOUNT_NAME.fieldApiName] = this.accountId;
        console.log('save case fire hua aage dekh account id',this.accountId);
        fields[CONTACT_NAME.fieldApiName] = this.contactId;
        console.log('save case fire hua aage dekh contactid',this.contactId);
        const recordInput = { apiName: CASE_OBJECT.objectApiName, fields };
        updateRecord(recordInput).then((record) => {
            console.log(record);
          });
    }
}