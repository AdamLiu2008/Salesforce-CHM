@isTest
private class testSendEmailFromMailgun {

      //sendEmailResponse(id accID, String response, String responseSubject, String toEmail, String toCCEmail)
      
	
	 static testMethod void testSendEmailSuccess() {
		// Implement test code 
		ID acID = ID.valueOf('0017F00000MNTQ0QAP'); 
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestMockMessageResponse());
        sendEmailFromMailgun.sendEmailResponse(acID, 'Email Content', 'Email Subject', 'adamliu2008@gmail.com', 'adamliu2008@gmail.com');

        Test.stopTest();
	}
	

	 static testMethod void testSendEmailFail() {
		// Implement test code
		ID acID = ID.valueOf('0017F00000MNTQ0QAP'); 
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestMockMessageFailedResponse());
        sendEmailFromMailgun.sendEmailResponse(acID, 'Email Content', 'Email Subject', 'adamliu2008@gmail.com', 'adamliu2008@gmail.com');

        Test.stopTest();

	}
	
}