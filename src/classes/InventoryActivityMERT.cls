public with sharing class InventoryActivityMERT implements InventoryActivity {
	public Inventory_Activity__c createInventoryActivity(Channel_Inventory__c ChannelInventory, Channel_Inventory__c ResaleInventory, Account partner, Account resales, Product2 product, Integer qty) 
        {

        	RecordType rt = [select Id, name from RecordType where Name = 'MERT' and SobjectType = 'Inventory_Activity__c' limit 1];
          				Inventory_Activity__c InventoryActivity = new Inventory_Activity__c();
          				InventoryActivity.Channel_Partner__c = resales.Id;
          				InventoryActivity.Resale_Customer__c = partner.Id;
          				InventoryActivity.Partner_Branch__c  = partner.Id;
          				InventoryActivity.Product__c = product.Id;
          				InventoryActivity.Reported_Qty__c = qty;
          				InventoryActivity.RecordTypeID = rt.id;
          				InventoryActivity.Channel_Inventory__c=ChannelInventory.id;
			     		insert InventoryActivity; system.debug('Finished Insert MERT:' + InventoryActivity);

			     		return InventoryActivity;

        }
}