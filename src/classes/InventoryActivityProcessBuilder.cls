public with sharing class InventoryActivityProcessBuilder{
	

    @InvocableMethod
    public static void QuoteDelete(List<Id> OpportunityIds)
    {
        List<Quote> Quotes =[select id from quote
                          where Opportunity.id in :OpportunityIds
                       and Status != 'Accepted'];
        delete Quotes;
   }
}