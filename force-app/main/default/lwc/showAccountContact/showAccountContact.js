import { LightningElement, track } from 'lwc';
import getAccount from '@salesforce/apex/getAccountContacts.getAccount';
import findContactByAccountName from '@salesforce/apex/ContactController.findContactByAccountName';

export default class ShowAccountContact extends LightningElement {
    @track accounts;
    @track displaymeassage;
       
    handleClick(event) {
        this.accounts.forEach(element => {
            if(event.target.value == element.Name){
                
                if(element.switchContact == 'utility:chevrondown'){
                    element.displayContact = false;
                    element.switchContact = 'utility:chevronright';
                }
                else if(element.switchContact == 'utility:chevronright'){
                    element.switchContact = 'utility:chevrondown';  
                    element.displayContact = true; 
                    console.log("data=========="+JSON.stringify(this.accounts.Contacts[AccountId]));
                    //  for(let contct in this.accounts.Contacts){

                        //  for(let check in contct){
                        //     console.log("data=========="+JSON.stringify(check));
                            
                        // }
                    //  }
                }
                               
                
            }

        });

    }

    displayAccounts(){
        this.accounts = [];
        getAccount()
        .then(data =>{
            data.forEach(element => {
                element.displayContact = false;
                element.switchContact = 'utility:chevronright';
                this.accounts.push(element);
            });
        })
        .catch(error => {
			console.log(JSON.stringify(error));
        });
    }

    connectedCallback(){
        this.displayAccounts();
    }
   
}