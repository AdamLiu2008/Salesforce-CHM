trigger ageYear on Interaction_Records__c (after update) {

for (Interaction_Records__c Int_Rec: Trigger.new) {

	 Integer NUM = 10;
	 
	 Interaction_Records__c[] Int_Rec_Check = new Interaction_Records__c[NUM];


Int_Rec_Check = [SELECT Id, name FROM Interaction_Records__c WHERE name Like 'test%'];

Integer NUM2 = Int_Rec_Check.SIZE();

FOR (Integer I=0; I<NUM2; I++){

System.debug(Int_Rec_Check[I].name + ' Go to create Trigger ---1');

	 Delete Int_Rec_Check[I];
}


	Interaction_Records__c[] Int_Rec_Triggers = new Interaction_Records__c[NUM];

	 FOR (Integer I=0; I<NUM; I++){
	 		Int_Rec_Triggers[I] = new Interaction_Records__c(name='test '+ I, Number__c=I);
	 		//Insert Int_Rec_Triggers[I];
	 }
	}



	for (Interaction_Records__c Int_Rec: Trigger.new) {

		Interaction_Records__c intRec = new Interaction_Records__c();

			intRec.name = '1';

System.debug('Go to create Trigger ---1');

			
		insert intRec;	
	}
	//DML to insert the Invoice List in SFDC

}