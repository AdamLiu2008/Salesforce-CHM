@isTest
public class TestMockMessageResponse implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest req) {
        //creates fake response for DMU Callout
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setStatus('OK');
        return res;
    }
}