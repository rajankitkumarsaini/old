import { LightningElement,track,api } from 'lwc';
import CASE_OBJECT from '@salesforce/schema/Case';
import SUBJECT_FIELD from '@salesforce/schema/Case.Subject';
import DESCRIPTION_FIELD from '@salesforce/schema/Case.Description';
import ACCOUNT_NAME from '@salesforce/schema/Case.AccountId';
import CASE_ORIGIN from '@salesforce/schema/Case.Origin';
import PRIORITY_FIELDS from '@salesforce/schema/Case.Priority';
import CASE_REASON from '@salesforce/schema/Case.Reason';
import CONTACT_NAME from '@salesforce/schema/Case.ContactId';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';
export default class createCaseLWC extends NavigationMixin(LightningElement) {
    @api subject='';
    @api description='';
    @api caccount;
    @api reason;
    @api origin;
    @api priority;
    @api contact;
    handleChange(event){
        if(event.target.label=='Subject'){
            this.subject =  event.target.value;
        }
        if(event.target.label=='Description'){
            this.description = event.target.value;
        }
    }
    createCase(){
        
        const fields = {};
        fields[SUBJECT_FIELD.fieldApiName] = this.subject;
        fields[DESCRIPTION_FIELD.fieldApiName] = this.description;
        fields[ACCOUNT_NAME.fieldApiName] = this.caccount;
        fields[CASE_REASON.fieldApiName] = this.reason;
        if(this.origin)
        fields[CASE_ORIGIN.fieldApiName] = this.origin;
        else{
            this.origin='Phone';
            fields[CASE_ORIGIN.fieldApiName] = this.origin;
        }
        if(this.priority)
        fields[PRIORITY_FIELD.fieldApiName] = this.priority;
        else{
            this.priority='Medium';
            fields[PRIORITY_FIELDS.fieldApiName] = this.priority;

        }
        fields[CONTACT_NAME.fieldApiName] = this.contact;
        const recordInput = { apiName: CASE_OBJECT.objectApiName, fields };
        createRecord(recordInput)
        .then(account => { 
            this.accountId = account.id;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Case created',
                    variant: 'success',
                }),
            );
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: account.id,
                    objectApiName: 'Case',
                    actionName: 'view'
                },
            });



        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: error.body.message,
                    variant: 'error',
                }),
            );
        });
    }
    handleselected(event){
        this.account=event.detail;
    }
    handleorigin(event){
        this.origin=event.detail;
    }
    handlereason(event){
        this.reason=event.detail;
    }
    handlepriority(event){
        this.priority=event.detail;
    }
    handleContact(event){
        this.contact=event.detail;
    }
}