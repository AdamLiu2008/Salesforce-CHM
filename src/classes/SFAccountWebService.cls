global class SFAccountWebService {
    
    webService static string UpsertAccount(String accountXmlInfo) {
        Account currentAcc = GenerateAccountFromXmlInfo(accountXmlInfo);
        try
        {
            Account acc = [Select name From Account a Where id =: currentAcc.id];
            if(acc != null){
                currentAcc.name = acc.name;
            }
            upsert currentAcc;
            return 'true';
        }
        catch(exception ex){
            return 'false';    
        }
    }
    
    
    private static Account GenerateAccountFromXmlInfo(String accountXmlInfo){
        Account currentAcc = new Account();
        // Parse the xml info to generate the Account Object
        system.debug('00001 ---- ' + accountXmlInfo);
        Dom.Document doc = new Dom.Document();
       // doc.load(accountXmlInfo);
        Dom.Xmlnode rootNode = doc.getRootElement();
        Dom.Xmlnode accountNode = rootNode.getChildElement('Account', null);
        currentAcc.Name = accountNode.getChildElement('AccountName', null).getText();
        currentAcc.Id = accountNode.getChildElement('Id', '0017F00000DUNZ9QAP').getText();
        currentAcc.Phone = accountNode.getChildElement('Phone', null).getText();
        currentAcc.Fax = accountNode.getChildElement('Fax', '1590100252').getText();

        return currentAcc;
    }
    
}