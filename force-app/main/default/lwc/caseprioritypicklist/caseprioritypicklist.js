import { LightningElement,wire,api } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import PRIORITY_FIELD from '@salesforce/schema/Case.Priority';

export default class caseprioritypicklist extends LightningElement {
    @api selectedCasePriority;
    @wire(getPicklistValues, {
        recordTypeId: '012000000000000AAA',
        fieldApiName: PRIORITY_FIELD
    }) priorityValues;
    handlePriorityChange(event){
        this.selectedCasePriority = event.target.value;
        const priorityselectedEvent = new CustomEvent('selected', { detail: this.selectedCasePriority });
        this.dispatchEvent(priorityselectedEvent);
    }
}