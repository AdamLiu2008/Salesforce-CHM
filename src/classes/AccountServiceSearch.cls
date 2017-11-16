global class AccountServiceSearch {

	webservice static String searchCustomer(string name){


		account acc = [Select Id From Account a Where name =: name];      
		
		
		if(acc.id!=NULL)
    		Return acc.Id;
		else
			Return 'failure';

	}
}