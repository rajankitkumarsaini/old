import { LightningElement, track, wire} from 'lwc';
import getFollowedCases from '@salesforce/apex/SC_FollowedCaseList.getFollowedCases';
import {refreshApex} from '@salesforce/apex';

export default class NewFollowedCase extends LightningElement {
    @track caseList;
    @track errors;
    @track columns = [
        { label: 'Case Number', fieldName: 'CaseURL', type: 'url',
            typeAttributes: {
                label: { fieldName: 'CaseNumber' }
                }
        },
        { label: 'Status', fieldName: 'Status'},
        { label: 'Priority', fieldName: 'Priority'},
        { label: 'Subject', fieldName: 'Subject'}
    ];
    connectedCallback(){
        getFollowedCases()
        .then(result=>{
        this.caseList= result;
        if(this.caseList){
            this.caseList=result;
           this.caseList.forEach(item => item['CaseURL'] = '/lightning/r/Case/' +item['Id'] +'/view');

        }
            //Set HyperLink.
            let tempCaseList = [];

            result.forEach((record) => {
                let tempCase = Object.assign({}, record);
                tempCase.CaseURL = '/' + tempCase.Id;
                tempCaseList.push(tempCase);

            });
        
      this.caseList = tempCaseList;
        this.error = undefined;

        })
        .catch(error=>{
            this.error= error;
        })

    }


    refreshTimeline(){
        getFollowedCases()
        .then(result=>{
        this.caseList= result;
        if(this.caseList){
            this.caseList.forEach(item => item['CaseURL'] = '/lightning/r/Case/' +item['Id'] +'/view');

        }
            //Set HyperLink.
           /*let tempCaseList = [];

            result.forEach((record) => {
                let tempCase = Object.assign({}, record);
                tempCase.CaseNumber = '' + tempCase.Id;
                tempCaseList.push(tempCase);

            });
        
        this.caseList = tempCaseList;
        refreshApex(this.caseList);
        this.error = undefined;*/

        })
        .catch(error=>{
            this.error= error;
        })
    }
}