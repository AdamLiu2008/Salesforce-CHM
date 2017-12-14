trigger email2Account on Account (after insert, after update){

	    //get account name and select criteria from custom setting
    	Account acct = [SELECT Id, Name, Email_Address__c, Email_status__c FROM Account where Id = :Trigger.new];
    	list<selectAccount__c> selectName = [select Account_Name__c from selectAccount__c];

    	//Email prepare
    	EmailTemplate et=[Select Body, Subject, HtmlValue  from EmailTemplate where name = 'EmailTemplate' limit 1];
    	String AccountName = acct.Name;
    	String toEmail = acct.Email_Address__c;
    	String toCCEmail = 'adamliu2008@gmail.com';

    	if (selectName.size() > 0){

    		for(selectAccount__c selName: selectName){

    			if( AccountName == selName.Account_Name__c){

    				string Emailbody = et.body.replace('[!Account.Name]', AccountName);

    				sendEmailFromMailgun.sendEmailResponse(acct.id, Emailbody, et.subject, toEmail, toCCEmail);

    			}
    		}
    	}
}