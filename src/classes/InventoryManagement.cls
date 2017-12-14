public virtual class InventoryManagement
    {
        // Inventory Activity Shared methods

    public virtual Channel_Inventory__c searchInventoryRec(Account partner, Product2 product) {

    	Channel_Inventory__c ChannelInventory = null;

    		ChannelInventory = [Select id from Channel_Inventory__c where Account__c =: partner.id and Product__c =: product.id LIMIT 1];

    		Return ChannelInventory;

    }

    public virtual Channel_Inventory__c createInventoryRec(Account partner, Product2 product, Integer qty) {

    	Channel_Inventory__c ChannelInventory = new Channel_Inventory__c();

		ChannelInventory.Account__c = partner.id;
		ChannelInventory.Available_Quantity__c = qty;
		ChannelInventory.Price_Unit__c = 1;
		ChannelInventory.Product__c =product.id;
		ChannelInventory.Transaction_Effective_Date__c = system.today();
		ChannelInventory.Unit_of_Measure__c = 'Each';
						
		Insert ChannelInventory;

		Return ChannelInventory;

    }

    public virtual void increaseInventoryRec(Channel_Inventory__c ChannelInventory, Integer qty) {

       ChannelInventory.Available_Quantity__c = ChannelInventory.Available_Quantity__c + qty;

       update ChannelInventory;

    }


    public virtual void decreaseInventoryRec(Channel_Inventory__c ChannelInventory, Integer qty) {

        ChannelInventory.Available_Quantity__c = ChannelInventory.Available_Quantity__c - qty;

       update ChannelInventory;

    }

}