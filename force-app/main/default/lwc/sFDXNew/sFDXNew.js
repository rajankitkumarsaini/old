import { LightningElement,api } from 'lwc';
import{ShowToastEvent} from 'lightning/platformShowToastEvent';
import UploadDocToS3Server from '@salesforce/apex/S3Controller.UploadDocToS3Server'
export default class sfdxnew extends LightningElement {
    @api recordId;
    fileData
    openfileupload(event){
        const file=event.target.files[0]
        var reader=new FileReader()
        reader.onload=() => {
            this.fileData = {
                // var base64 = reader.result.split(',')[1]
                'filename':file.name,
                'base64':base64,
                'recordId':this.recordId


            }
            console.log(this.fileData)
        }
        reader.readAsDataURL(file)
    }
    handleClick(){
        const{base64,filename,recordId}=this.fileData
        UploadDocToS4Server({recordId}).then(result=>{
            this.fileData=null
            let title='${result} uploaded successfully'
            this.toast(title)
            
        })
    }
    toast(title){
        const toastEvent=new ShowToastEvent({
            title,
            variant:"success"
        })
        this.dispatchEvent(toastEvent)
    }

}