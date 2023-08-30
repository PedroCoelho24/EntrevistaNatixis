import { LightningElement, api, wire } from 'lwc';
import getRelatedRecords from '@salesforce/apex/relatedObjectsTableController.listOfRelatedObjects';

const columns = [
		{ label: 'Id', fieldName: 'objectId' },
		{ label: 'Name', fieldName: 'name'}
	];

export default class RelatedObjectsTable extends LightningElement {
	@api recordId;
	records = [];
	error = "Something went wrong";
	errorCheck = false;
	isLoading = true;
	columns = columns;

	connectedCallback() {
		console.log(this.recordId);
		let resultList = [];
		getRelatedRecords({recordId: this.recordId})
		.then((result) => {
			console.log('result');
			console.log(result);
			console.log(result[0]);
			console.log(result[0].name);
			this.records = result;
			for (let index = 0; index < 1000; index++) {
				this.records.push(result[0]);
				this.records.push(result[1]);

			}

			console.log(this.records);

		})
		.catch((error) => {
			console.log('In connected call back error....');
			this.error = error;
			this.errorCheck = true;
			console.log('Error is', this.error);
		});
		this.isLoading = false;
	}
}