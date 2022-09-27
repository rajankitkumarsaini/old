import { LightningElement ,wire,track,api } from 'lwc';
import getMyCase from "@salesforce/apex/CaseController.fetchCase";
import updateMyCase from "@salesforce/apex/CaseController.updateCase";
import { refreshApex } from '@salesforce/apex';
import CASE_CASENUMBER from '@salesforce/schema/Case.CaseNumber';


export default class Updatecase extends LightningElement {
    @api wiredCase;
    @api recordId;
    @api realFormData;
    //@api AccountName;
    
    @wire (getMyCase , { caseId: '$recordId' })
    fetchedCase( resp){
        this.wiredCase = resp;
        console.log('data ::::::' ,resp);
        this.realFormData = {... this.wiredCase.data};
        //AccountName=this.realFormData.Account;
        console.log('data ::::::' ,this.realFormData);
        console.log('type==================', typeof this.realFormData);
        console.log('type==================', Array.isArray(this.realFormData));

 }
 updateValue(event){



    this.realFormData = {...this.realFormData , [event.target.dataset.field] : event.detail.value};
    console.log( this.realFormData);
}
saveRecord(event ){

    updateMyCase({cse : this.realFormData}).then(()=>{
        refreshApex(this.wiredCase);
        console.log('Refresh Apex called');

    });

}
}