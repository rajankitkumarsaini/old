import { LightningElement,api } from 'lwc';
import { updateRecord } from "lightning/uiRecordApi";
import CASE_OBJECT from "@salesforce/schema/Case";
import ID_FIELD from "@salesforce/schema/Case.Id";
import Status_FIELD from "@salesforce/schema/Case.Status";

export default class Updatecasestatus extends LightningElement {

    @api recordId;
    
    Status;
    New;
    Working;
    Escalate;

    Handlechange(e)
    {
          if(e.target.Status === "New"){
          this.selectedValue = e.target.value;
          console.log(this.Status);
          }
          else if(e.target.Status === "Working")
          { 
            this.selectedValue = e.target.value;
            console.log(this.Status);
          }
          else if(e.target.Status === "Escalate")
          {
            this.selectedValue = e.target.value;
            console.log(this.Status);
          }
    }

    
    updateDoTransaition(event){
        this.selectedValue = this.template.querySelector('lightning-input-type').value; //event.target.value;
        const fields = {};
        fields[ID_FIELD.fieldApiName] = this.recordId;
        fields[Status_FIELD.fieldApiName] = this.selectedValue;
        const recordInput = { fields : fields };
        updateRecord(recordInput)
        .then((record) => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Case has been transitioned to "'+this.selectedValue+'" successfully.',
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
      
    }
    updateHardWareCategory(event){

        
        let theValue = this.template.querySelector('[data-id="dcID"]').value;
        
       // let theValue = this.template.querySelector('[data-id="dcID"]').value;
        //let theValue = this.template.querySelector('[data-id="securityId"]').value;
    
    }

    closeModalTransition(event){
        this.isTransitionViewOn=false;
    }




}