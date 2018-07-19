public class CBURLUtil
{
    
    
    public CBURLUtil(){
        
    }
public String getUrl()
{
    return 'https://hariacme-test.chargebee.com';
}

public String getApiKey()
{
    return 'test_QDeLZmGWRsKGhtg3zcueJZTJob2SRisFq';
}



public static String buildURLString(String url, String paramName, String paramValue){
    if(paramValue != null && !paramValue.equals('')){
        if(url == null || url == ''){
            url = '';
            url = url + paramName + '=' + EncodingUtil.urlEncode(paramValue, 'UTF-8');
        }else{
            url = url + '&' + paramName + '=' + EncodingUtil.urlEncode(paramValue, 'UTF-8');
        }
    }
    return url;
}

public static String sendRequest(String endpointURL, String bodyData, CBURLUtil urlUtil, boolean needAuth){
        HttpRequest reqData = new HttpRequest();
        Http http = new Http(); 
        reqData.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        reqData.setHeader('Connection','keep-alive');
        reqData.setTimeout(20000); 
        reqData.setEndpoint(endpointURL);
        if(needAuth){
            String username = urlUtil.getApiKey();
            Blob headerValue = Blob.valueOf(username + ':');
            String authorizationHeader = 'BASIC ' +
            EncodingUtil.base64Encode(headerValue);
            reqData.setHeader('Authorization', authorizationHeader); 
        }                              
        reqData.setMethod('POST');
        if( bodyData != null ){
            reqData.setBody(bodyData);
        }
        String responseFromNet;  
        try{
            HTTPResponse res = http.send(reqData);
            responseFromNet = res.getBody();
        }
        catch(Exception exp)
        {
            System.debug('endpointURL-'+ endpointURL + '\n exception '+exp);
            responseFromNet = 'exception '+exp;
        }
        return responseFromNet;
}

     public static String getIdFromResponse(String responseFromNet){
        String ext_id = null;
        if(responseFromNet != null && responseFromNet.startsWith('{'))
        {
            JSONParser parser = JSON.createParser(responseFromNet);
            while (parser !=null && parser.nextToken() != null) 
            {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'id'))
                {
                     parser.nextToken();   
                     ext_id = parser.getText();
                     return ext_id;
                }
            }
        }
        return ext_id;
    }
    
    public static String getValueFromResponse(String responseFromNet, String key){
        String value = null;
        if(responseFromNet != null && responseFromNet.startsWith('{'))
        {
            JSONParser parser = JSON.createParser(responseFromNet);
            while (parser !=null && parser.nextToken() != null) 
            {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == key))
                {
                     parser.nextToken();   
                     value = parser.getText();
                     return value;
                }
            }
        }
        return value;
    }
    
    public static Map<String, Object> convertMap(String jsonInput){
       Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(jsonInput);
       return m;
      
   }
   
    public static List<Object> convertList(String jsonInput){
       List<Object> m = (List<Object>)JSON.deserializeUntyped(jsonInput);
       return m;
      
    }
}