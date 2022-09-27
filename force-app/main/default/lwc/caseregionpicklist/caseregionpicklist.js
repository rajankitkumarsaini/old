import { LightningElement,wire,api } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import CASE_REASON from '@salesforce/schema/Case.Reason';

export default class caseregionpicklist extends LightningElement {
    @api selectedcaseReason;
    @wire(getPicklistValues, {
        recordTypeId: '012000000000000AAA',
        fieldApiName: CASE_REASON
    }) reasonValues;
    handleReasonChange(event){
        this.selectedcaseReason = event.target.value;
        const reasonselectedEvent = new CustomEvent('selected', { detail: this.selectedcaseReason });
        this.dispatchEvent(reasonselectedEvent);
    }
}