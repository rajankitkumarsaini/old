import { LightningElement,wire,api } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import CASE_ORIGIN from '@salesforce/schema/Case.Origin';

export default class caseoriginpicklist extends LightningElement {
    @api selectedCaseOrigin;
    @wire(getPicklistValues, {
        recordTypeId: '012000000000000AAA',
        fieldApiName: CASE_ORIGIN
    }) originValues;
    handleOriginChange(event){
        this.selectedCaseOrigin = event.target.value;
        const originselectedEvent = new CustomEvent('selected', { detail: this.selectedCaseOrigin });
        this.dispatchEvent(originselectedEvent);
    }
}