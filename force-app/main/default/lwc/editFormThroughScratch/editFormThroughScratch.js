import { LightningElement,api,wire } from 'lwc';
import fetchCase from "@salesforce/apex/CaseController1.fetchCase";

export default class EditFormThroughScratch extends LightningElement {
    @api recordId;
    @api wiredcase;
    @wire (fetchCase , { caseId: '$recordId' })
    fetchedCase(data){
        
       console.log(data);

 }
}