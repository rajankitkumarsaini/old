import { LightningElement,api,track,wire } from 'lwc';
import { updateRecord } from "lightning/uiRecordApi";
import CASE_OBJECT from "@salesforce/schema/Case";
import ID_FIELD from "@salesforce/schema/Case.Id";
import PRIORITY_FIELD from '@salesforce/schema/Case.Priority';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { CurrentPageReference } from "lightning/navigation";
import reflectValue from "@salesforce/apex/UrlHelper.reflectValue";

const fields = [PRIORITY_FIELD];
export default class Testserviceconsole extends LightningElement {
    @track displayValue;
    
    @wire(getRecord, { recordId: '$recordId', fields })
    casePriority;
    get priority() {
        return getFieldValue(this.casePriority.data, PRIORITY_FIELD);
    }
    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference) {
          const urlValue = currentPageReference.state.c__myUrlParameter;
          if (urlValue) {
            reflectValue({ recordId: '$recordId' })
              .then((result) => {
                this.displayValue = 'URL Value was: ${result}';
              })
              .catch((error) => {
                this.displayValue = 'Error during processing: ${error}';
              });
          } else {
            this.displayValue = 'URL Value was not set';
          }
        }
      }


    @api recordId;
    @track showModal=false;
    @track disableButtonLow=false;
    @track disableButtonMedium=false;
    @track disableButtonHigh=false;
    @api selectedCasePriority;
     
    
    
    doTransition(event){
        this.showModal=true;
        this.Priority=this.casePriority.data.fields.Priority.value;
        if(this.Priority==="Low"){
            this.disableButtonLow=true;
            this.disableButtonMedium=false;
            this.disableButtonHigh=false;
        }
        else if(this.Priority==="Medium"){
            this.disableButtonMedium=true;
            this.disableButtonLow=false;
            this.disableButtonHigh=false;
        }
        else{
            this.disableButtonHigh=true;
            this.disableButtonLow=false;
            this.disableButtonMedium=false;
        }
        
    }
    Handlechange(event)
    {
        
          if(event.target.value === "Low"){
          this.selectedValue = event.target.value;
          }
          else if(event.target.value === "Medium")
          { 
            this.selectedValue = event.target.value;
          }
          else if(event.target.value === "High")
          {
            this.selectedValue = event.target.value;
          }
    }
    
    updateDoTransition(event){
        console.log('under updation');
       const fields = {};
        fields[ID_FIELD.fieldApiName] = this.recordId;
        fields[PRIORITY_FIELD.fieldApiName] = this.selectedValue;
        const recordInput = {fields, fields};
        updateRecord(recordInput)
        .then((record) => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Case priority has been changed to "'+this.selectedValue+'" successfully.',
                    variant: 'success'
                })
            );
        })
        .catch(error => {
            console.log(error);
            const evt = new ShowToastEvent({
                title: "Error ON Edit - ",
                message: JSON.stringify(error),
                variant: "error",
            });
            this.dispatchEvent(evt);
        });
        this.showModal=false;
      
    }
    

    
    closeModalTransition(event){
        console.log('working fine');
        this.showModal=false;

    }
}