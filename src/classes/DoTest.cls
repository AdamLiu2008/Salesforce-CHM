public with sharing class DoTest
{
//Do it
	public Book__c books { get; set; }


	public DoTest(ApexPages.Standardcontroller stdController)
	{
		books = [SELECT Id
                  FROM Book__c
                  WHERE ID =: stdController.getId()];


	}

	public PageReference sendToCRM () {

		Book__c c= new Book__c(Name = 'Weissman111');

		Insert c;

		System.debug('*** Books: ' + c);

PageReference SAPDMUPage = new ApexPages.Standardcontroller(books).save();
        SAPDMUPage.setRedirect(false);
        
        return SAPDMUPage;


	}
}