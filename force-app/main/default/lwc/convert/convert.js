import { LightningElement,api } from 'lwc';

export default class Convert extends LightningElement {
    @api listViewIds;
    close(){
		setTimeout(
			function() {
				window.history.back();
			},
			1000
		);
	}
}