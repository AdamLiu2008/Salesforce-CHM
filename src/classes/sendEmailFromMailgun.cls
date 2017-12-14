/**************************************************************************************************
 * Name: sendEmailFromMailgun
 * Object: N/A
 * Purpose: Call Mailgun to send email (Not for batch process)
 * Author: Adam Liu 
 * Create Date: 2017-12-11
 * Modify History: 
 * 2017-12-11   Adam    Version 001
***************************************************************************************************/
public class sendEmailFromMailgun {

@future (callout=true)
    public static void sendEmailResponse(id accID, String response, String responseSubject, String toEmail, String toCCEmail){

    	String status = '';
    	
    	if(toEmail != '' || response != ''){
            System.debug('*** Email Logic Start Point ***');

            //Prepare API call 
            string sURL =   'https://api.mailgun.net/v3/sandboxfe5d4b40190f464088dc78f187e41889.mailgun.org/messages';
            Blob headerValue = Blob.valueOf('api:key-37843df333f0dc94305daad628cc3a02');
            String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue); 

            //Prepare Http Method
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            Http http = new Http(); 

            //Prepare Email Parameters
			string emailBody;
            string sBody = '';
            String subject = '';                  
            String fromemail = 'NoReply<Help@Help.com>'; 
            String toSetCCEmail ='';


            if(responseSubject != Null){

                subject = EncodingUtil.urlEncode( responseSubject, 'UTF-8');
        	}

        	if(toCCEmail != ''){

                toSetCCEmail= '&cc='+toCCEmail;
            } 

            //Fill in Body for endpoint
            sBody  = response.unescapeHtml4();
            sBody = EncodingUtil.urlEncode(sBody, 'UTF-8');
            emailBody = sURL+'?from='+fromemail+'&to='+toEmail+'&subject='+subject+'&html='+sBody;

            //Fill in Http method
            integer BLength = emailBody.length();
            req.setHeader('Authorization', authorizationHeader);
            req.setHeader('Content-Length', string.valueOf(BLength));
            req.setBody('{ "from": "'+fromemail+'",  "to": "'+toEmail+'", "cc":"'+toCCEmail+'", "subject": "'+subject+'",  "html": "'+sBody+'"}');    
            req.setMethod('POST');   
            req.setEndPoint(emailBody);              

        try{
        
            res = http.send(req);
            
            if( res.getStatusCode() == 200 ){  
            System.debug('*** Email sent ***');
            }
        
        }catch (System.Calloutexception e) {
            
            System.debug(LoggingLevel.Error, '*** Call out Error: ' + e + '***');
            System.debug(LoggingLevel.INFO, '*** Response String: ' + req.toString() + '***');
            
            }  
            
            status = res.getStatus();

            }
        //return status;
        }  
    }


    //Code  Description
        //200 Everything worked as expected
        //400 Bad Request - Often missing a required parameter
        //401 Unauthorized - No valid API key provided
        //402 Request Failed - Parameters were valid but request failed
        //404 Not Found - The requested item doesn’t exist
        //500, 502, 503, 504  Server Errors - something is wrong on Mailgun’s end
