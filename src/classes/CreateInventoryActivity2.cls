public with sharing class CreateInventoryActivity2{
	public CreateInventoryActivity2(string moveType, Account partner, Account resales, Product2 product, Integer qty) {
			
		InventoryActivity InvAct = null; 
		Channel_Inventory__c parterInv = null;
		Channel_Inventory__c resalesInv = null;

		InventoryManagement InvenManager = new InventoryManagement();

		parterInv = InvenManager.searchInventoryRec(partner, product);
		resalesInv = InvenManager.searchInventoryRec(partner, product);

		if(resalesInv == null){
			resalesInv = InvenManager.createInventoryRec(partner, product, qty);
		}



		if( moveType == 'MDTD') 
		{ 
			InvAct = new InventoryActivityMDTD();
			InvAct.createInventoryActivity(parterInv, resalesInv, partner, resales, product, qty);

			InvenManager.increaseInventoryRec(resalesInv, qty);
			InvenManager.decreaseInventoryRec(parterInv, qty);


		}else if( moveType == 'MSST') 
		{ 
			InvAct = new InventoryActivityMSST();
			InvAct.createInventoryActivity(parterInv, resalesInv, partner, resales, product, qty); 

			InvenManager.decreaseInventoryRec(parterInv, qty);


		}else if( moveType == 'MERT') 
		{ 
			InvAct = new InventoryActivityMERT();
			InvAct.createInventoryActivity(parterInv, resalesInv, partner, resales, product, qty); 

			InvenManager.increaseInventoryRec(parterInv, qty);

		}
	}
}