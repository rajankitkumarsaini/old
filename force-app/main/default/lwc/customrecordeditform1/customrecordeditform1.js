import { LightningElement, wire, track,api } from "lwc";

import { getRecord, updateRecord } from "lightning/uiRecordApi";
import { getObjectInfo } from "lightning/uiObjectInfoApi";

import CASE_OBJECT from '@salesforce/schema/Case';
import SUBJECT_FIELD from '@salesforce/schema/Case.Subject';
import DESCRIPTION_FIELD from '@salesforce/schema/Case.Description';
import CASE_ORIGIN from '@salesforce/schema/Case.Origin';
import PRIORITY_FIELD from '@salesforce/schema/Case.Priority';
import CASE_REASON from '@salesforce/schema/Case.Reason';


export default class Customrecordeditform1 extends LightningElement {
  @api recordId;
  caseRecord = {}; // * Old value of contact fields

  @track
  caseRecordEditable = {}; // * Updated value of contact fields

  @wire(getRecord, {
    recordId: "$recordId",
    fields: [
        SUBJECT_FIELD,
        DESCRIPTION_FIELD,
        CASE_ORIGIN,
        PRIORITY_FIELD,
        CASE_REASON
    ]  
  })
  caseRecordResult({ data, error }) {
    if (data) {
      console.log(data);
      console.log(JSON.stringify(data));
      this.caseRecord = data; // * Pass by reference
      this.caseRecordEditable = JSON.parse(JSON.stringify(data)); // * Pass by value
    }
    if (error) {
      console.log(error);
    }
  }

  @wire(getObjectInfo, { objectApiName: CASE_OBJECT })
  caseObjectInfo;

  get caseFields() {
    let caseFieldsArray = [],
      key = 0;
    if (this.caseRecordEditable && this.caseObjectInfo.data) {
      for (let field in this.caseRecordEditable.fields) {
        if (
          Object.prototype.hasOwnProperty.call(
            this.caseRecordEditable.fields,
            field
          )
        ) {
          caseFieldsArray.push({
            key: key++,
            apiName: field,
            label: this.caseObjectInfo.data.fields[field].label,
            value: this.caseRecordEditable.fields[field].value
          });
        }
      }
    }
    return caseFieldsArray;
  }

  updateCaseField(event) {
    let name = event.target.name;
    console.log(name);
    if (
      Object.prototype.hasOwnProperty.call(
        this.caseRecordEditable.fields,
        name
      ) &&
      this.caseRecordEditable.fields[name]
    ) {
      console.log(this.caseRecordEditable.fields[name].value);
      this.caseRecordEditable.fields[name].value = event.target.value;
    }
    console.log(this.caseRecordEditable);
  }

  saveRecord() {
    let case1 = {};
    case1.fields = { ...this.caseRecordEditable.fields };
    for (let field in case1.fields) {
      if (Object.prototype.hasOwnProperty.call(case1.fields, field)) {
        case1.fields[field] = case1.fields[field].value;
      }
    }
    case1.fields.Id = this.caseRecordEditable.id.slice();
    console.log(JSON.stringify(case1));
    updateRecord(case1)
      .then(() => {
        console.log("Record Updated");
      })
      .catch((error) => {
        console.log("Unable to update record");
        console.log(JSON.stringify(error));
        console.log(error.body.message);
      });
  }

  resetForm(event) {
    console.log(JSON.stringify(this.caseRecord));
    console.log(JSON.stringify(this.caseRecordEditable));
    this.caseRecordEditable = JSON.parse(JSON.stringify(this.caseRecord));
  }
}