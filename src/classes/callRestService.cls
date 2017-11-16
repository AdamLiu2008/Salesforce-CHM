global class callRestService {

	public void callRestService() {

        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();
    
        req.setEndpoint('http://www.thomas-bayer.com/sqlrest/CUSTOMER/18/');
        req.setMethod('GET');
        //req.setHeader('Content-Type', 'application/json');
        //req.setHeader('Accept', 'application/json');
        //req.setBody('');
        req.setCompressed(true); // otherwise we hit a limit of 32000
    
        try {
            res = http.send(req);
            system.debug('-----000001----- successful response: ' + res);
            system.debug('-----000001----- successful response string: ' + res.toString());
             system.debug('-----000001----- successful response STATUS: '+res.getStatus());
             system.debug('-----000001----- successful response STATUS_CODE: '+res.getStatusCode());
             system.debug('-----000001----- successful response Content: ' + res.getBody());
        } catch(System.CalloutException e) {
            System.debug('-----000002----- Callout error: '+ e);
            System.debug('-----000003----- failed response:' + res.toString());
        }
    
    }
}