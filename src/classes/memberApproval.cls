global class memberApproval {
    webservice static void callApproval(Id localId) { 
                Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                req1.setComments('Submitted for Approval');
                req1.setObjectId(localId);
                Approval.ProcessResult res = Approval.Process(req1);                  
    }
}