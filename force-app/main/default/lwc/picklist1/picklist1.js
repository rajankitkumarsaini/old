import { LightningElement} from 'lwc';
export default class PickList1 extends LightningElement {
    selectedValue;
    get options() {
        return [
            { label: 'High', value: 'High' },
            { label: 'Medium', value: 'Medium' },
            { label: 'Low', value: 'Low' },
        ];
    }
   
    handleChange(event){        
        this.selectedValue = event.target.value;
    }
   
}