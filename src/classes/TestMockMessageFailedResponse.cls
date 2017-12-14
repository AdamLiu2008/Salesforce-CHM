@isTest
public class TestMockMessageFailedResponse implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest req) {
        //creates fake response for DMU Callout
        HttpResponse res = new HttpResponse();
        res.setStatusCode(500);
        res.setStatus('Server Errors');
        return res;
    }
}