import { LightningElement, api, wire,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord } from 'lightning/uiRecordApi';
const FIELDS = ['Contact.Name', 'Contact.Phone'];

export default class RecordFormExample extends LightningElement {
  @api recordId;
    contact;
    name;
    phone;
    phonestr;
    

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    wiredRecord({ error, data }) {
        if (error) {
            let message = 'Unknown error';
            if (Array.isArray(error.body)) {
                message = error.body.map(e => e.message).join(', ');
            } else if (typeof error.body.message === 'string') {
                message = error.body.message;
            }
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error loading contact',
                    message,
                    variant: 'error',
                }),
            );
        } else if (data) {
            this.contact = data;
            this.name = this.contact.fields.Name.value;
            this.phone = this.contact.fields.Phone.value;
            if ((typeof this.phone) === (typeof 'string')){
              console.log('Record Phone number is:', this.phone);
              
            }
            else{
              
              alert('Record Phone field is Empty');
              
            }
        }
    }
}