import LightningDatatable from 'lightning/datatable';
import customPicklist from './customPicklist.html';
export default class customTypesGlobal extends LightningDatatable {
    static customTypes ={
        accountFieldPicklist:{
            template:customPicklist,
            standardCellLayout:true,
            typeAttributes:['label','value','placeholder','options']
        }
    }
}