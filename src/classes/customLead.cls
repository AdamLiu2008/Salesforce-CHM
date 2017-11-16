global class customLead
{
 public Interaction_Records__c objStudents{get;set;}
   
    webservice static void coversion(string student) 
    { 
    Interaction_Records__c objStudents=new Interaction_Records__c();
     
         objStudents=[SELECT ID,Name FROM Interaction_Records__c WHERE id=:student];

        objStudents.language__c = 'Hello World';

        Interaction_Records__c intRec = new Interaction_Records__c();

        intRec.Name='TEST0003';
        intRec.language__c = 'Hello';

        Account objAcc = new Account();
        objAcc = [Select ID,Name from Account Where AccountNumber = '123'];

        intRec.Customer__c = objAcc.Id;
        intRec.Customer_Group__c = 'Entry Level'+';'+'Group Level';
        intRec.Device_Type__c = 'Computer';
        intRec.Operating_System__c='Windows';
        intRec.Service_Type__c= 'Sales';
   
        System.debug('Go to create');

        Insert intRec;

        update objStudents;

          
     //   Account objAcc=new Account();
     //    objAcc.Name=objStudents.Name;
     //    Insert objAcc;
          
     //    contact Objcon=new contact();
     //    Objcon.Lastname=objStudents.Name;
     //    Insert Objcon;
          
         
     //    Opportunity objOpp= new Opportunity();
     //    objOpp.Name=objStudents.Name + 'Hello World';
     //    objOpp.StageName='Active';
     //    objOpp.CloseDate=System.Today();
 
     //    Insert objOpp;
    }
}