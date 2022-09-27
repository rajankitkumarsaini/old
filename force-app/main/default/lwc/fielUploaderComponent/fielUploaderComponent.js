import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import createTheCase from '@salesforce/apex/CreateCaseRecord.createTheCase'

export default class FielUploaderComponent extends NavigationMixin(LightningElement) {
    @api recId;
    @api caseCreationButton=false;
    @api showfileuploaderComponent=false;
    
    @api subject='';
    @api description='';
    
    get acceptedFormats() {
        return ['.pdf', '.png','.txt'];
    }

    handleUploadFinished(event) {
        // Get the list of uploaded files
        const uploadedFiles = event.detail.files;
        
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Case created Successfully!!!',
                variant: 'success',
            }),
        );
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.recId,
                objectApiName: 'Case',
                actionName: 'view'
            },
        });
    }
    
    handleChange(event){
        if(event.target.label=='Subject'){
            this.subject =  event.target.value;
            console.log('====================='+ this.subject );
        }
        if(event.target.label=='Description'){
            this.description = event.target.value;
            console.log('====================='+ this.description );
        }
    }
    
    handleClick1(){
        console.log('=====================');
        createTheCase({ description: this.description,subject:this.subject })
        .then(result => {
            this.recId = result;
            if(result){
                this.showfileuploaderComponent=true;
                this.caseCreationButton=true;
            }
        })
        .catch(error => {
            this.error = error;
        });
    }

}