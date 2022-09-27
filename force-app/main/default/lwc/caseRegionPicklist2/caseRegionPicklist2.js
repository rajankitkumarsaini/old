import { LightningElement,wire } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import PRIORITY_FIELD from '@salesforce/schema/Case.Priority';
import CASE_REASON from '@salesforce/schema/Case.Reason';
import CASE_ORIGIN from '@salesforce/schema/Case.Origin';



export default class CaseRegionPicklist2 extends LightningElement {
    selectedCasePriority;
    selectedcaseReason;
    selectedCaseOrigin;
    @wire(getPicklistValues, {
        recordTypeId: '012000000000000AAA',
        fieldApiName: PRIORITY_FIELD
    }) priorityValues;

     @wire(getPicklistValues, {
        recordTypeId: '012000000000000AAA',
        fieldApiName: CASE_REASON
    }) reasonValues;

    @wire(getPicklistValues, {
        recordTypeId: '012000000000000AAA',
        fieldApiName: CASE_ORIGIN
    }) originValues;
     
     handlePriorityChange(event){
        this.selectedCasePriority = event.target.value;
    }
    
    handleReasonChange(event){
        this.selectedcaseReason = event.target.value;
    }

    handleOriginChange(event){
        this.selectedCaseOrigin = event.target.value;
    }
}