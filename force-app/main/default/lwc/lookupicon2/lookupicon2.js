import { LightningElement,wire,track,api } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { registerListener, unregisterAllListeners, fireEvent } from 'c/pubsub';
import getContacts from '@salesforce/apex/ContactSearchController.getContacts';                
export default class lookupicon2 extends LightningElement {
    @api accountId;
    @track contactName = '';
    @track contactList = [];     
    @track contactId; 
    @track objectApiName='Contact'; 
    @track isshow=false;
    @track messageResult=false;
    @track isShowResult = true;   
    @track showSearchedValues = false; 
    @wire(CurrentPageReference) pageRef;
    connectedCallback() {
        registerListener('sendaccoundId', this.getStart, this);
    } 
    getStart(data1){
        this.accountId=data1;
        console.log('accountId::'+this.accountId);
    } 
    @wire(getContacts, {accountId: '$accountId',
                        contactName:'$contactName'})
    retrieveContacts ({error, data}) {
       this.messageResult=false;
       if (data) {
           // TODO: Error handling 
           console.log('data::'+data.length);
           if(data.length>0 && this.isShowResult){
               this.contactList = data;                    
               this.showSearchedValues = true; 
               this.messageResult=false;
           }            
           else if(data.length==0){
               this.contactList = [];                
               this.showSearchedValues = false;
               if(this.contactName!='')
                   this.messageResult=true;               
           }  
               
       } else if (error) {
           // TODO: Data handling
           this.contactId =  '';
           this.contactName =  '';
           this.contactList=[];           
           this.showSearchedValues = false;
           this.messageResult=true;   
       }
   }
   
   handleClick(event){
    this.isShowResult = true;   
    this.messageResult=false;        
  }
  handleKeyChange(event){       
    this.messageResult=false; 
    this.contactName = event.target.value;
  }  
  handleParentSelection(event){        
    this.showSearchedValues = false;
    this.isShowResult = false;
    this.messageResult=false;
    //Set the parent calendar id
    this.contactId =  event.target.dataset.value;
    //Set the parent calendar label
    this.contactName =  event.target.dataset.label;      
    console.log('contactId::'+this.contactId);    
    const selectedEvent = new CustomEvent('selected', { detail: this.contactId });
        // Dispatches the event.
    this.dispatchEvent(selectedEvent);    
}
disconnectedCallback() {
    unregisterAllListeners(this);
}

}