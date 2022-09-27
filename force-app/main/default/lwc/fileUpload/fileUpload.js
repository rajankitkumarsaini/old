import { LightningElement,api } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import UploadDocToS3Server from '@salesforce/apex/S3Controller.UploadDocToS3Server'
//import uploadFile from '@salesforce/apex/FileUploaderClass.uploadFile'
export default class FileUpload extends LightningElement {
    @api recordId;
         fileData;
         openfileUpload(event){
             const file=event.target.files[0];
             var reader=new FileReader();
             reader.onload=()=>{
                 var base64 =reader.result.split(',')[1];
                 this.fileData={
                     'filename':file.name,
                     'base64':base64,
                     'recordId':this.recordId
                 }
                 console.log(this.fileData);
             }
             reader.readAsDataURL(file);
        }
        handleClick(event){
            const {base64,filename,recordId}=this.fileData;
            UploadDocToS3Server({recordId}).then(result=>{
                this.fileData=null;
                let title='{$filename} uploaded successfully!!';
                this.toast(title);

            })

        }
        toast(title){
            const toastEvent=new ShowToastEvent({
                title,
                variant:"Success"
            });
            this.dispatchEvent(toastEvent);
        }
    
}