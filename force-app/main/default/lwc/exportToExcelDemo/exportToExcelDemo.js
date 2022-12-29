import {  LightningElement,  track  } from "lwc";  
import getContacts from "@salesforce/apex/ExportToExcelDemoController.getContacts";  
  const columns = [{  
      label: "Quantity",  
      fieldName: "contactName",  
      type: "text"  
    },  
    {  
      label: "Price",  
      fieldName: "contactEmail",  
      type: "text"  
    }  
  ];  
  export default class ExportToExcelDemo extends LightningElement {  
    @track hrefdata;  
    @track contactList;  
    @track contactColumns = columns;  
    connectedCallback() {  
      this.getContacts();  
    }  
    getContacts() {  
      getContacts()  
        .then(result => {  
          this.contactList = result;  
        })  
        .catch(error => {  
          this.error = error;  
          console.log(this.error);  
        });  
    }  
    exportToCSV() {  
      let columnHeader = ["Quantiy", "Price","Total"];  // This array holds the Column headers to be displayd
      let jsonKeys = ["contactName", "contactEmail","ContactDetail"]; // This array holds the keys in the json data  
      var jsonRecordsData = this.contactList;  
      console.log('JSON Records Data::'+JSON.stringify(jsonRecordsData));
      let csvIterativeData;  
      let csvSeperator  
      let newLineCharacter;  
      csvSeperator = ",";  
      newLineCharacter = "\n";  
      csvIterativeData = "";  
      csvIterativeData += columnHeader.join(csvSeperator);  
      console.log('line 42::'+csvIterativeData);
      csvIterativeData += newLineCharacter;  
      console.log('line 44::'+csvIterativeData);
      for ( let i = 0; i < jsonRecordsData.length; i++) {  
        let counter = 0;  
        for (let iteratorObj in jsonKeys) { 
          let dataKey = jsonKeys[iteratorObj];  
          console.log('Outer loop debug log::'+ i +'  Inner Loop debug log::'+typeof dataKey); 
          if (counter > 0) {  csvIterativeData += csvSeperator; }  
          if (  jsonRecordsData[i][dataKey] !== null &&  
            jsonRecordsData[i][dataKey] !== undefined  
          ) {  csvIterativeData += '"' + jsonRecordsData[i][dataKey] + '"';  
          console.log('After Checking Condition if True::::'+csvIterativeData);
          } else if(jsonRecordsData[i][dataKey] !== null || 
            jsonRecordsData[i][dataKey] !== undefined){    
          console.log('After Checking Condition if False::::'+csvIterativeData);
          if(dataKey=="ContactDetail"){
            let temp=i+2;
            csvIterativeData += '=A'+temp+'*B'+temp+'';
        
          }else {
            csvIterativeData += '""';
          }
          } 

          counter++;  
        }  
        csvIterativeData += newLineCharacter;  
      }  
      console.log("csvIterativeData", csvIterativeData);  
      this.hrefdata = "data:text/csv;charset=utf-8," + encodeURI(csvIterativeData);  
    }  
  }