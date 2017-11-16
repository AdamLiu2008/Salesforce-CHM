public with sharing class DeleteAll {
	
//Used to initialization transaction data


	public static void DeleteOrder() {
		List<order> orders = [SELECT ID, Name, Status, OrderNumber FROM Order];

		for(Order ord: orders){

			ord.status='Draft';

			update ord;
		}

		delete orders;

		
	}


	public static void DeleteInventoryRec(){
		List<Channel_Inventory__c> InventoryRec =[Select ID from Channel_Inventory__c];

		Delete InventoryRec;

	}

	public static void DeleteInventoryAct(){
		List<Inventory_Activity__c> Inventoryact =[Select ID from Inventory_Activity__c];

		Delete Inventoryact;

	}

	public static void DeleteInventoryList(){
		List<Inventory_Activity_List__c> Inventorylist =[Select ID from Inventory_Activity_List__c];

		Delete Inventorylist;

	}

}