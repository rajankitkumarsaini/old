import { LightningElement, wire,api } from "lwc";
import { getRecord } from "lightning/uiRecordApi";
import { getObjectInfo } from "lightning/uiObjectInfoApi";
import CASE_OBJECT from '@salesforce/schema/Case';
import SUBJECT_FIELD from '@salesforce/schema/Case.Subject';
import DESCRIPTION_FIELD from '@salesforce/schema/Case.Description';
import CASE_ORIGIN from '@salesforce/schema/Case.Origin';
import PRIORITY_FIELD from '@salesforce/schema/Case.Priority';
import CASE_REASON from '@salesforce/schema/Case.Reason';
import CASE_CASENUMBER from '@salesforce/schema/Case.CaseNumber';





export default class Parentcustomrecordeditform extends LightningElement {
  @api recordId;
  @api CaseNumber;
  
  @wire(getRecord, {
    recordId: "$recordId",
    fields: [
      SUBJECT_FIELD,
      DESCRIPTION_FIELD,
      CASE_ORIGIN,
      PRIORITY_FIELD,
      CASE_REASON,
      CASE_CASENUMBER
    ] 
  })
  caseRecord;

  @wire(getObjectInfo, { objectApiName: CASE_OBJECT })
  caseObjectInfo;

  get caseFields() {
    let caseFieldsArray = [],
      key = 0;
    if (this.caseRecord.data && this.caseObjectInfo.data) {
      console.log("Case Record Data -->");
      console.log(JSON.stringify(this.caseRecord.data));
      console.log("Case Object Info Data -->");
      console.log(JSON.stringify(this.caseObjectInfo.data));

      for (let field in this.caseRecord.data.fields) {
        if (
          Object.prototype.hasOwnProperty.call(
            this.caseRecord.data.fields,
            field
          )
        ) {
          console.log(field);
          caseFieldsArray.push({
            key: key++,
            apiName: field,
            label: this.caseObjectInfo.data.fields[field].label,
            value: this.caseRecord.data.fields[field].value
          });
        }
      }
    }
    return caseFieldsArray;
  }
  handleOnload(){
    CaseNumber=this.caseRecord.data.fields.CaseNumber.value;
    console.log(CaseNumber);
  }
}