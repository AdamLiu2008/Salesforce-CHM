public class InventoryActivityMDTD implements InventoryActivity
    {
        public static Inventory_Activity__c createInventoryActivity(Channel_Inventory__c ChannelInventory, Channel_Inventory__c ResaleInventory, Account partner, Account resales, Product2 product, Integer qty)
        {

        	RecordType rt = [select Id, name from RecordType where Name = 'MDTD' and SobjectType = 'Inventory_Activity__c' limit 1];
          				Inventory_Activity__c InventoryActivity = new Inventory_Activity__c();
          				InventoryActivity.Channel_Partner__c = partner.Id;
          				InventoryActivity.Resale_Customer__c = resales.Id;
          				InventoryActivity.Partner_Branch__c  = resales.Id;
          				InventoryActivity.Product__c = product.Id;
          				InventoryActivity.Reported_Qty__c = qty;
          				InventoryActivity.RecordTypeID = rt.id;
          				InventoryActivity.Channel_Inventory__c= ChannelInventory.id;
          				InventoryActivity.Resale_Inventory__c = ResaleInventory.id;
          				
			     		insert InventoryActivity; system.debug('Finished Insert MDTD:' + InventoryActivity);

			     		return InventoryActivity;

        }
    }