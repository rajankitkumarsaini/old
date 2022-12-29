import LightningDatatable from 'lightning/datatable';
import customPicklist from './customPicklist.html';
export default class CustomTypeGlobal extends LightningDatatable {
    static customTypes ={
        AccountPicklist:{
            template:customPicklist,
            standardCellLayout:true,
            typeAttributes:['label','value','placeholder','options']
        }
    }
}