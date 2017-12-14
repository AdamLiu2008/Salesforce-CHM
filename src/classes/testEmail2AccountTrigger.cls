@isTest(SeeAllData=true)
public class testEmail2AccountTrigger {
	
	public static testMethod void testAccountUpdate(){


			// Test trigger start                      
		    Account acc = new Account(
		    	name = 'adamliu84' 
		    	);
	        insert acc; 
	        system.debug('----->>> ADDING ACCOUNT: ' + acc);


			//Check Custom setting
	    	list<selectAccount__c> selectName = [select Account_Name__c from selectAccount__c where Account_Name__c =: acc.name];
	    	System.assert(selectName.size() > 0);
    	        
	        
	        // READ Email Template...
	    	EmailTemplate et=[Select Body, Subject, HtmlValue  from EmailTemplate where name = 'EmailTemplate' limit 1];
	    	System.assert(et.body !=null);


	    	//Call API Class
		    ID acID = ID.valueOf('0017F00000MNTQ0QAP'); 
	        Test.startTest();
	        Test.setMock(HttpCalloutMock.class, new TestMockMessageResponse());
	        sendEmailFromMailgun.sendEmailResponse(acID, 'Email Content', 'Email Subject', 'adamliu2008@gmail.com', 'adamliu2008@gmail.com');

	        Test.stopTest();

		}	

}