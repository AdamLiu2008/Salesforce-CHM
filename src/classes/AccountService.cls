global class AccountService {

	webservice static String createCustomer(string name, string phone, string city){
		Account objA = new Account();
		objA.name= name;
		objA.phone= phone;
		objA.BillingCity= city;

		Insert objA;

		if(objA.Id!=NULL)
			Return 'Success';
		else
			Return 'failure';
		

	}


}