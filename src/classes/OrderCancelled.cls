public with sharing class OrderCancelled {


	 public Order Ord { get; set; }


	public OrderCancelled(ApexPages.Standardcontroller stdController) {

			 this.Ord = [SELECT id, Status FROM Order WHERE ID =: stdController.getId()];
		
	}


	 public PageReference orderCancelled () {

	 	if(Ord.Status !='Cancelled'){

	 			Ord.Status = 'Cancelled';


 			PageReference OrderPage = new ApexPages.Standardcontroller(Ord).save();
        	
        	OrderPage.setRedirect(true);
        	
        	return OrderPage;
		}

		PageReference OrderPage2 = new ApexPages.Standardcontroller(Ord).view();

			return OrderPage2;
	 }
}