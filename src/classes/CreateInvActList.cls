public with sharing class CreateInvActList {
	

	public Inventory_Activity_List__c CreateInvActList(Order ord, Inventory_Activity__c InvAct) {

					    Inventory_Activity_List__c InvActList = new Inventory_Activity_List__c();
				     	InvActList.Order__c = ord.id;
				     	InvActList.Inventory_Activity__c = InvAct.id;

				     	insert InvActList;

				     	Return InvActList;
		
	}
}