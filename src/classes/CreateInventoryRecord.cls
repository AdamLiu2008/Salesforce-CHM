public with sharing class CreateInventoryRecord {
	

	public Channel_Inventory__c CreateInventoryRecord(Order ord, Orderitem item, Product2 product) {

						Channel_Inventory__c ChannelInvent2 = new Channel_Inventory__c();
						ChannelInvent2.Account__c = ord.AccountId;
						ChannelInvent2.Available_Quantity__c = item.Quantity;
						//ChannelInvent2.Change_Date__c =
						//ChannelInvent2.COGS__c =
						//ChannelInvent2.COGS_Unit__c =
						//ChannelInvent2.Distribution_Channel__c = 
						ChannelInvent2.Price_Unit__c = 1;
						ChannelInvent2.Product__c =product.id;
						//ChannelInvent2.Protectable_Price__c = 
						//ChannelInvent2.Sales_Org__c
						ChannelInvent2.Transaction_Effective_Date__c = system.today();
						ChannelInvent2.Unit_of_Measure__c = 'Each';
						
						Insert ChannelInvent2;

						Return ChannelInvent2;
		
	}
}