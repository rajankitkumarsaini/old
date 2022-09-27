import { LightningElement } from 'lwc';

export default class NewCaseP extends LightningElement {
    
    closeAction() {
        var close = true;
        const closeclickedevt = new CustomEvent('closeclicked', {
            detail: { close }
        });

         // Fire the custom event
         this.dispatchEvent(closeclickedevt); 
    }
}