public with sharing class CreateInventoryActivity {
	


	public Inventory_Activity__c CreateInvActMSSI(Channel_Inventory__c ChannelInvent, Order ordr, OrderItem item, Product2 product, Decimal qty) {


						RecordType rt = [select Id, name from RecordType where Name = 'MSSI' and SobjectType = 'Inventory_Activity__c' limit 1];
										
						system.debug('---------------Check recordtype ID information-------' + rt);

						Inventory_Activity__c InvAct = new Inventory_Activity__c();
				     	InvAct.Channel_Inventory__c = ChannelInvent.id;
				     	InvAct.Channel_Partner__c = ordr.AccountId;
				     	InvAct.CI_Update_Status__c = 'Submit';
				     	InvAct.RecordTypeID = rt.id;
				     	//InvAct.Credit_Memo__c =' ';
				     	//InvAct.Distribution_Channel__c =orderinform[0].Distribution_Channel__c;
				     	InvAct.Effective_Date__c = system.today();
				     	//InvAct.External_Product_ID__c = '';
				     	//InvAct.Partner_Branch__c = ; //Come from Account.
				     	InvAct.Product__c = product.id;
				     	//InvAct.Reported_Cost__c = ;
				     	InvAct.Reported_Qty__c = qty;

				     	InvAct.Resale_Customer__c = ordr.AccountId;
				     	//InvAct.Resale_Invoice__c
				     	//InvAct.Resale_Invoice_Date__c
				     	InvAct.Resale_Price__c = item.UnitPrice;
				     	//InvAct.Resale_Ship_Date__c
				     	//InvAct.Sales_Organization__c =orderinform[0].Distribution_Channel__c;
				     	//InvAct.Total_Consumed_Value__c
				     	InvAct.Channel_Inventory__c=ChannelInvent.id;
				     	InvAct.Order_Number__c = ordr.OrderNumber;

			     		insert InvAct;
			     		system.debug('---------------Insert InvAct1----------------' + InvAct);

			     		Return InvAct;

		
	}
	public Inventory_Activity__c CreateInvActXSSI(Channel_Inventory__c ChannelInveCancel, Order ordr, OrderItem item, Product2 product, Decimal qty) {

						//Create Inventory Cannellation Activity
						RecordType rt = [select Id, name from RecordType where Name = 'XSSI' and SobjectType = 'Inventory_Activity__c' limit 1];
						Inventory_Activity__c InvAct = new Inventory_Activity__c();
				     	InvAct.Channel_Inventory__c = ChannelInveCancel.id;
				     	InvAct.Channel_Partner__c = ordr.AccountId;
				     	InvAct.CI_Update_Status__c = 'Submit';
				     	InvAct.RecordTypeID = rt.id;
				     	//InvAct.Credit_Memo__c =' ';
				     	//InvAct.Distribution_Channel__c =orderinform[0].Distribution_Channel__c;
				     	InvAct.Effective_Date__c = system.today();
				     	//InvAct.External_Product_ID__c = '';
				     	//InvAct.Partner_Branch__c = ; //Come from Account.
				     	InvAct.Product__c = item.Pricebookentry.Product2Id;
				     	//InvAct.Reported_Cost__c = ;
				     	InvAct.Reported_Qty__c = -item.Quantity;
				     	InvAct.Resale_Customer__c = ordr.AccountId;
				     	//InvAct.Resale_Invoice__c
				     	//InvAct.Resale_Invoice_Date__c
				     	InvAct.Resale_Price__c = item.UnitPrice;
				     	//InvAct.Resale_Ship_Date__c
				     	//InvAct.Sales_Organization__c =orderinform[0].Distribution_Channel__c;
				     	//InvAct.Total_Consumed_Value__c
				     	InvAct.Order_Number__c = ordr.OrderNumber;
						
						Insert InvAct;
						system.debug('---------------Insert InvAct2----------------' + InvAct);

						Return InvAct;
										


	}

}