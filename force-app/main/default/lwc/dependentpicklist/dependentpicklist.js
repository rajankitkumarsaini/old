import { LightningElement,wire,api} from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { registerListener, unregisterAllListeners, fireEvent } from 'c/pubsub';
import GetStatesByCountry from '@salesforce/apex/GetStatesNameByCountryController.GetStatesByCountry';

export default class dependentpicklist extends LightningElement {
    stateOptionsList;
    selectedState;
    @api countryName;
    @wire(CurrentPageReference) pageRef;
    connectedCallback() {
        registerListener('sendSelectedCountryName', this.getStart, this);
    }
    getStart(data1){
        this.countryName=data1;
        console.log('countryName::'+this.countryName);

    }  
    @wire(GetStatesByCountry, {countryName: '$countryName'})
    retrieveContacts ({error, data}){
        let tempArray=[];
        if(data){
            let tempArray=[];
           console.log(data);
           for(let key in data)
           {
              tempArray.push({label:data[key]});
           }
           this.stateOptionsList=tempArray;
        }

    } 
    handleCountryChange(event){
        this.selectedState = event.target.value;
        this.template.querySelector('select.selectStateList').value = this.selectedState;
    } 
}