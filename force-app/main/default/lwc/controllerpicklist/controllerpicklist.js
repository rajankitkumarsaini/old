import { LightningElement,wire } from 'lwc';
import getCountries from '@salesforce/apex/GetCountriesController.getCountries';
import { CurrentPageReference } from 'lightning/navigation';
import { fireEvent } from 'c/pubsub';
export default class Controllerpicklist extends LightningElement {
    countryOptionsList;
    selectedCountry;
    @wire(CurrentPageReference) pageRef;
    @wire(getCountries) 
    retrieveCountries({error,data}){
        let tempArray=[];
        if(data){
            let tempArray=[];
           console.log(data);
           for(let key in data)
           {
              tempArray.push({label:key});
           }
           this.countryOptionsList=tempArray;
        }
    
            
    }
    handleCountryChange(event){
        this.selectedCountry = event.target.value;
        fireEvent(this.pageRef,'sendSelectedCountryName',this.selectedCountry);
        this.template.querySelector('select.selectCountryList').value = this.selectedCountry;
    }
}