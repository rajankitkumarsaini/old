import { LightningElement,api,wire,track} from 'lwc';
import getLeadtoAccountMappings from '@salesforce/apex/AccountLeadMappings.getLeadtoAccountMappings';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import ACCOUNT_MAPPINGS from '@salesforce/schema/Account_Mappings__c';
import ACCOUNT_FIELDS from '@salesforce/schema/Account_Mappings__c.Account_Fields__c';
const COLS=[
    { label:'Lead Fields',type:'Text', fieldName:'Lead_Fields__c'},
     { label:'Account Fields', type:'accountFieldPicklist',fieldName: 'Account_Fields__c',
        typeAttributes:{
             options: {fieldName:'picklistOptions'},
             value: {fieldName:'Account Fields'},
             placeholder:'choose Account Field'
             
        }
    }
    
];


export default class LeadFieldMapping extends LightningElement{
    
    columns=COLS;
    accountMappings=[];
    accountMappingsPicklist=[];

    @wire(getObjectInfo,{objectApiName:ACCOUNT_MAPPINGS})
    accountMappingsObjectMetadata;
    @wire(getPicklistValues,{
        recordTypeId:'$accountMappingsObjectMetadata.data.defaultRecordTypeId',
        fieldname:ACCOUNT_FIELDS 
    })
    accountMappingsPicklistValues({data,error}){
        if(data){
            console.log('picklist values${data}');
            this.accountMappingsPicklist=data.values;
            this.fetchAccountMappings();
        }
        else if(error){
            console.log('picklist values  ${error}');
        }
    }
    fetchAccountMappings(){
        getLeadtoAccountMappings()
        .then((result)=>{
            let options=[];
            for(var key in this.accountMappingsPicklist){
                options.push( { label:this.accountMappingsPicklist[key].label,value:this.accountMappingsPicklist.value});
            }
            this.accountMappings=result.map((record)=>{
                return{
                    ...record,
                    'picklistOptions':options
                }
            });
            this.error=undefined;
        })
        .catch((error)=>{
            this.error=error;
            this.accountMappings=undefined;
        })
    }
//    @wire(getLeadtoAccountMappings)
//    listOfAccountMappings({data,error}){
//     if(data){
//         this.accountMappings=data;
//         this.error=undefined;
//     }
//     else if(error){
//         this.accountMappings=undefined;
//         this.error=error;
//     }
//    }

}