public with sharing class CustomProductLookupController {

	public Product2 Product {get;set;} // new Product to create
  	public List<Product2> results{get;set;} // search results
  	public string searchString{get;set;} // search keyword

  public CustomProductLookupController() {
    //product = new Product2();
    // get the current search string
    searchString = System.currentPageReference().getParameters().get('H');
    runSearch();  
  }

  // performs the keyword search
  public PageReference search() {
    runSearch();
    return null;
  }

  // prepare the query and issue the search command
  private void runSearch() {
    // TODO prepare query string for complex serarches & prevent injections
    results = performSearch(searchString);               
  } 

  // run the search and return the records found. 
  private List<product2> performSearch(string searchString) {

    String soql = 'select name from product2';
    if(searchString != '' && searchString != null)
      soql = soql +  ' where name LIKE \'%' + searchString +'%\'';
    soql = soql + ' limit 25';
    System.debug(soql);
    return database.query(soql); 

  }

  // save the new product record
  //public PageReference saveAccount() {
    // reset the product
  //  product = new Product2();
  //  return null;
  //}

  // used by the visualforce page to send the link to the right dom element
  public string getFormTag() {
    return System.currentPageReference().getParameters().get('frm');
  }

  // used by the visualforce page to send the link to the right dom element for the text box
  public string getTextBox() {
    return System.currentPageReference().getParameters().get('txt');
  }

}