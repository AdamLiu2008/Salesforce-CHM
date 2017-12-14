public interface InventoryActivity
    {
        Inventory_Activity__c createInventoryActivity(Channel_Inventory__c ChannelInventory,Channel_Inventory__c ResaleInventory, Account partner, Account resales, Product2 product, Integer qty);
    }