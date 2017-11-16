public with sharing class CreateIR {
    public Book__c theIR {get; set;}
    public String lastError {get; set;}

    public CreateIR() {
        theIR = new Book__c();
        lastError = '';
    }
      
    public PageReference createIR() {
        //createNewIR();
insert theIR;
        
        //PageReference bookPage = new PageReference('/' + theIR.id);
PageReference bookPage = new ApexPages.StandardController(theIR).view();
        
        bookPage.setRedirect(true);
        return bookPage;
  
    }
       
     private void createNewIR() {      
        try {
            insert theIR;
        	} 
        catch(System.Exception ex){
           lastError = ex.getMessage();
        }
    }   
}