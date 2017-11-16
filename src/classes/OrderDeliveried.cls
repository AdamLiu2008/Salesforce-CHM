public with sharing class OrderDeliveried {

	public Order Ord { get; set; }
	

	public OrderDeliveried(ApexPages.Standardcontroller stdController) {

			 this.Ord = [SELECT id, Status,RecordTypeId FROM Order WHERE ID =: stdController.getId()];
		
	}


	 public PageReference OrderDeliveried () {

	 	if(Ord.Status =='Delivery'){

	 			Recordtype rt = [Select id from Recordtype where name =: 'Order Stage3'];

	 			Ord.Status = 'Activated';
	 		
	 			Ord.RecordTypeId = rt.id;

 			PageReference OrderPage = new ApexPages.Standardcontroller(Ord).save();
        	
        	OrderPage.setRedirect(true);
        	
        	return OrderPage;
		}

		PageReference OrderPage2 = new ApexPages.Standardcontroller(Ord).view();

			return OrderPage2;
	 }
}