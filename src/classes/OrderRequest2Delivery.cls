public with sharing class OrderRequest2Delivery {

    //private String endPoint = 'http://putsreq.com/JOAUjaG9TQA1PWPMuwap';
    putsreq__c put = putsreq__c.getall().get('URL');
    private String endPoint = put.EndPoint__c;   
    private List<OrderItem> OrdItems;
	
	public Order ord { get; set; }

	public OrderRequest2Delivery(ApexPages.Standardcontroller stdController) {


			this.Ord = [SELECT AccountId, Name, Status, OrderNumber, BillingAddress, ShippingAddress, EffectiveDate, Description  													
	    					       FROM Order where Id =: stdController.getId()];
	    	OrdItems = [SELECT Pricebookentry.Product2Id, UnitPrice, Quantity, OrderId FROM OrderItem where OrderId =:Ord.id];

	}

	public PageReference orderDelivery() {


        HttpRequest req = new HttpRequest();

        req.setEndpoint(endPoint);
        req.setMethod('POST');
        // Sets HTTP time out 2 minutes, unit is millisecond.
        req.setTimeout(120000);

        HttpResponse res = new HttpResponse();
        Http http = new Http();


 		try {
            // Composes the account relationship node.
          	String orderItem = '';

          	for (OrderItem item : OrdItems) {
                orderItem = orderItem +
                '<ProductList>' +
                '<RelationCategory>Items</RelationCategory>' +
                '<ProductID>' + item.Pricebookentry.Product2Id + '</ProductID>' +
                (item.UnitPrice == null ? '<UnitPrice>' + item.UnitPrice + '</UnitPrice>' : '') +
                (item.Quantity == null ? '<Quantity>' + item.Quantity + '</Quantity>' : '') +
                (item.OrderId == null ? '<OrderId>' + item.OrderId + '</OrderId>' : '') +
                '</ProductList>';
            	}

            // Composes the request body
            req.setBody('<?xml version="1.0" encoding="utf-8"?>'+
                        '<objects>' +
                          '<Order>' +
                            (Ord.AccountId == null ? '' : '<AccountId>' + Ord.AccountId + '</AccountId>') +
                            (Ord.Name == null ? '' : '<Name>' + Ord.Name + '</Name>') +
                         	(Ord.Status == null ? '' : '<Status>' + Ord.Status + '</Status>') +
                         	(Ord.OrderNumber == null ? '' : '<OrderNumber>' + Ord.OrderNumber + '</OrderNumber>') +
                         	(Ord.BillingAddress == null ? '' : '<BillingAddress>' + Ord.BillingAddress + '</BillingAddress>') +
                         	(Ord.ShippingAddress == null ? '' : '<ShippingAddress>' + Ord.ShippingAddress + '</ShippingAddress>') +
                         	(Ord.EffectiveDate == null ? '' : '<EffectiveDate>' + Ord.EffectiveDate + '</EffectiveDate>') +
                         	(Ord.Description == null ? '' : '<Description>' + Ord.Description + '</Description>') +
                            (orderItem == null ? '' : orderItem) +
                            '<instance>NA</instance>' +
                          '</Order></objects>');

            // A response object is generated as a result of the request
            System.debug(LoggingLevel.INFO, '*** HTTP Request Body: ' + req.getBody());

            res = http.send(req);
            if (res.getStatusCode() == 200) {
                Ord.Status = 'Delivery';
                System.debug(LoggingLevel.INFO, '*** Success Response String: ' + res.toString());
            } else if (res.getStatusCode() == 500) {
                Ord.Status = 'Fail';
                System.debug(LoggingLevel.INFO, '*** Fail Response String: ' + res.toString());
            }

        } catch (System.Calloutexception e) {
            Ord.Status = 'Fail';
            System.debug(LoggingLevel.Error, '*** Call out Error: ' + e);
            System.debug(LoggingLevel.INFO, '*** Response String: ' + req.toString());
        }

        PageReference Orderpage = new ApexPages.Standardcontroller(Ord).save();
        Orderpage.setRedirect(true); 
       return Orderpage;	
	}
}