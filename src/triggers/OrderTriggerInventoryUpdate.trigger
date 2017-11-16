trigger OrderTriggerInventoryUpdate on Order (
	before delete,
	after insert, 
	after update) {

	
	public Integer i = 0;

	

if (Trigger.isUpdate && TriggerHandler.firstRun) {
	    	//call handler.after method
    	List<order> orderinform = [SELECT AccountId, Name, Status, OrderNumber, 
    							  (SELECT Pricebookentry.Product2Id,UnitPrice, Quantity, OrderId, Inventory_Activity__c,Move_Type__c FROM OrderItems),
    							  (SELECT Name, Move_Type__c FROM Inventory_Activity_List__r)    													
	    					       FROM Order where Id = :Trigger.new];
	    Order order = orderinform.get(0);
	    RecordType MSSI = [select Id, name from RecordType where Name = 'MSSI' and SobjectType = 'Inventory_Activity__c' limit 1];

	if(order.Status =='Activated'){

			for(OrderItem item: order.OrderItems){

					if(item.Inventory_Activity__c == null || item.Move_Type__c != 'MSSI'){ 

							Product2 product = [SELECT id, ProductCode FROM Product2 WHERE id =: item.Pricebookentry.Product2Id];

			    list<Channel_Inventory__c> ChanIven = [Select id, Available_Quantity__c from Channel_Inventory__c 
	     											   where Account__c =: order.AccountId and Product__c =: product.id];


	     		if (ChanIven.size() > 0){//Search Inventory records

	     					//0. Update Previous Inventory Activity XSSI status
	     					if (item.Inventory_Activity__c != null){
	     						Inventory_Activity__c InvActXSSI = new Inventory_Activity__c();
	     						InvActXSSI.id = item.Inventory_Activity__c;
								InvActXSSI.CI_Update_Status__c = 'Cancelled';
								update InvActXSSI;
	     					}

	     					//1. Create Inventory Activity MSSI
	     					Channel_Inventory__c ChannelInvent = ChanIven.get(0);			     				     			
			     			Order ordr = orderinform.get(0);
			     			Decimal qty = ChannelInvent.Available_Quantity__c;

			     			CreateInventoryActivity CreateMSSI = new CreateInventoryActivity();
			     			Inventory_Activity__c InvAct = CreateMSSI.CreateInvActMSSI(ChannelInvent, ordr, item, product, item.Quantity);
			     			//system.debug('****************************'+item.Quantity);


			     			//2. Create Inventory list
			     			CreateInvActList InvActlist = new CreateInvActList();
			     			Inventory_Activity_List__c Inventorylist = InvActlist.CreateInvActList(ordr, InvAct);


			     			//3. Update Inventory Quantity
			     			ChannelInvent.Available_Quantity__c = qty + item.Quantity;   
				     		update ChannelInvent;


				     		//4. Update Item and add Inventory activity information
				     		item.Inventory_Activity__c = InvAct.id;
				    		update item;


	     		} else {//Create Inventory records

	     					Order ordr = orderinform.get(0);

	     					//1. Create Channel Inventory Record
	     					CreateInventoryRecord ChannelInv = new CreateInventoryRecord();
	     					Channel_Inventory__c ChannelInventory = ChannelInv.CreateInventoryRecord(ordr, item, product);

	     					//2. Create Inventory Activity
				     		Order ordr2 = orderinform.get(0);

				     		CreateInventoryActivity CreateMSSI = new CreateInventoryActivity();
				     		Inventory_Activity__c InvAct2 = CreateMSSI.CreateInvActMSSI(ChannelInventory, ordr, item, product, item.Quantity);	


				     		//3. Create Inventory list
			     			CreateInvActList InvActlist = new CreateInvActList();
			     			Inventory_Activity_List__c Inventorylist = InvActlist.CreateInvActList(ordr, InvAct2);


			     			//4. Update Item and add Inventory activity information
			     			item.Inventory_Activity__c = InvAct2.id;
				     		update item;
						}//End of //Create Inventory records
					} else if (item.Move_Type__c == 'MSSI'){//if(item.Inventory_Activity__c == null)

							//This happened when change order status back to active
							Inventory_Activity__c InvActStatusI = new Inventory_Activity__c();
							
							InvActStatusI.id = item.Inventory_Activity__c;
							
							InvActStatusI.CI_Update_Status__c = 'Submit';

							update InvActStatusI;
				}
											}//for(OrderItem item: order.OrderItems)
	} else if(order.Status =='Draft') {//End of if(order.Status =='Activated')||Start of if(order.Status =='Draft') 

			for(OrderItem item: order.OrderItems){

				if(item.Inventory_Activity__c != null){

							Inventory_Activity__c InvActStatusDraft = new Inventory_Activity__c();

							InvActStatusDraft.id = item.Inventory_Activity__c;

							InvActStatusDraft.CI_Update_Status__c = 'Rollback';

							update InvActStatusDraft;

					}//end of if(item.Inventory_Activity__c != null)
			}//end of for(OrderItem item: order.OrderItems)
	} else if (order.Status =='Cancelled') {//else if(order.Status =='Draft')


			for(OrderItem item: order.OrderItems){

							Product2 product = [SELECT id, ProductCode FROM Product2 WHERE id =: item.Pricebookentry.Product2Id];

							list<Inventory_Activity__c> InvActlist = [Select Channel_Inventory__c From Inventory_Activity__c 
																	WHERE ID =: item.Inventory_Activity__c];
						if(InvActlist.size() > 0){

							list<Channel_Inventory__c> ChannelInvCan = [Select id, Available_Quantity__c From Channel_Inventory__c 
																	where Account__c =: order.AccountId and Product__c =: product.id];


						if (ChannelInvCan.size()>0){


							Decimal qty = -item.Quantity;


							Order orde = orderinform.get(0);
							Channel_Inventory__c ChannelInveCancel = ChannelInvCan.get(0);
							Inventory_Activity__c InvActCanel = InvActlist.get(0);


							//1. Update Previous Inventory Activity status to Cancelled
							InvActCanel.CI_Update_Status__c = 'Cancelled';
							update InvActCanel;

							//2. Create New Inventory Cannellation Activity
					     	CreateInventoryActivity CreateXSSI = new CreateInventoryActivity();
		      				Inventory_Activity__c InvAct2 = CreateXSSI.CreateInvActXSSI(ChannelInveCancel, orde, item, product, qty);

		      				//3. Update Channel Inventory Available Quantity
							ChannelInveCancel.Available_Quantity__c = ChannelInveCancel.Available_Quantity__c - math.abs(qty);
							system.debug('-----------------------------------' + ChannelInveCancel.Available_Quantity__c +'----'+qty);
							Update ChannelInveCancel;

							//4. Update Item information to delete inventory activity 
							Item.Inventory_Activity__c = InvAct2.id;
							update item;

							//5. Create Inventory list
			     			CreateInvActList InvActlist2 = new CreateInvActList();
			     			Inventory_Activity_List__c Inventorylist = InvActlist2.CreateInvActList(orde, InvAct2);

				}//if (InvAclist.size() > 0)
			 }
			}//end of for(OrderItem item: order.OrderItems)
		}//
	TriggerHandler.firstRun = false;
	}//Trigger.isUpdate
if (Trigger.isDelete) {//call after delete
			    	List<order> orderinform = [SELECT AccountId, Name, Status,OrderNumber, 
    							  (SELECT Pricebookentry.Product2Id,UnitPrice, Quantity, OrderId, Inventory_Activity__c,Move_Type__c FROM OrderItems),
    							  (SELECT Name, Move_Type__c FROM Inventory_Activity_List__r) 						
	    					       FROM Order where Id = :Trigger.old];

	    			Order orde = orderinform.get(0);


	    if(orde!=null){

					    	for(OrderItem item: orde.OrderItems){

					    	if(item.Inventory_Activity__c != null){


					    	Inventory_Activity__c InvActDele = [Select Channel_Inventory__c From Inventory_Activity__c 
					    										WHERE ID =: item.Inventory_Activity__c];
					    	Channel_Inventory__c ChannelInveCancel = [Select Available_Quantity__c From Channel_Inventory__c 
					    										WHERE ID =: InvActDele.Channel_Inventory__c];
							Product2 product = [SELECT id, ProductCode FROM Product2 WHERE id =: item.Pricebookentry.Product2Id];

							InvActDele.CI_Update_Status__c = 'Cancelled';

							
							update InvActDele;

							//1. Create Inventory Cannellation Activity
							CreateInventoryActivity CreateXSSI = new CreateInventoryActivity();
							Inventory_Activity__c InvAct3 = CreateXSSI.CreateInvActXSSI(ChannelInveCancel, orde, item, product, -item.Quantity);


							//2. Update Channel Inventory
							ChannelInveCancel.Available_Quantity__c = ChannelInveCancel.Available_Quantity__c - item.Quantity;
							ChannelInveCancel.Available_Quantity__c = ChannelInveCancel.Available_Quantity__c;
							Update ChannelInveCancel;
				}
			}
		}
	    
	}//End of call after delete
}//Level1