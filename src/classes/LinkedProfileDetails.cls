/**
*"LinkedProfileDetails" class contains the method
* to call the LinkedIn API to get the basic profile
* details of a LinkedIn account. 
*/
global class LinkedProfileDetails {

/**
*This method uses LinkedIn API key and Endpoint
*values stored in custom settings in step 6.
*/

    webService static void details( String recordid) {    
        /*String mykey = LinkedIn_API_Setting__c.getInstance( 'LinkedIn API Key' ).Value__c;
        system.debug(mykey);
        String endpoint  = LinkedIn_API_Setting__c.getInstance( 'LinkedIn Endpoint' ).Value__c;*/
        //qGlobes__LinkedIn_API_Setting__mdt
        
        String mykey = [SELECT Id,Value__c FROM qGlobes__LinkedIn_API_Setting__mdt WHERE developername='LinkedIn_API_Key' limit 1].Value__c;
        system.debug('####mykey###'+mykey);
        String endpoint  = [SELECT Id,Value__c FROM qGlobes__LinkedIn_API_Setting__mdt WHERE developername='LinkedIn_Endpoint' limit 1].Value__c;
/**
*HttpRequest and HttpResponse class methods
*are used to get the data 
*/  
        
        HttpRequest httpReq  = new HttpRequest();
        Http http            = new Http();
        HttpResponse httpRes = new HttPResponse();
        
        httpReq.setMethod( 'GET' );
        httpReq.setEndpoint( endpoint );
        
/** Make sure to replace the access token generated in 1st step with 
below mentioned token assigned to authorizationHeader string variable
**/
        String authorizationHeader = 'Bearer AQWeA78EZzq6DOz5wYSkSh_pDWC4ffOSal2gRa4rNRUQWpFE912F0mVT419cPjgTzju_1PfDgfbMzoztV--3T4BdivrY-3sOIEu1oke5nyEQd9PL4YOQoYOJSmVvW87cjBbgMwV6xELytClReYVV_SczdHiff6a0wRMVLC3uWGKImeJux7fStREoaH87sN-f83R3vivZdjAbAMvw3fO4r5OwaCQe0lHeTbMRl_Yxq4TFITXyqGNDDYK7qTEiKHwCabZ5matYlzW_svv5GlHMfGGPYFG4Magn9oYiCzmxo4Z7vCT9VYtmjLUu-bYMWsveOrcEmuGMWQdhxFyrAm9abW8ESsq6AQ';
        httpReq.setHeader('Authorization', authorizationHeader);
        
        httpRes = http.send( httpReq );
        
        System.debug('#####response body########:'+httpRes.getBody());
/**
* JSONParser class is used
* to map relevant data to 
* custom object fields
*/        
         JSONParser fname1 = JSON.createParser( httpRes.getBody() );
  /* nextToken() is a method used to parse JSON response in the form of key value
 pairs  */  
     
         fname1.nextToken();
         fname1.nextToken();
         fname1.nextToken();
         
         JSONParser lname1 = JSON.createParser( httpRes.getBody() );
         lname1.nextToken();
         lname1.nextToken();
         lname1.nextToken();
         lname1.nextToken();
         lname1.nextToken();
         lname1.nextToken();
         lname1.nextToken();
         lname1.nextToken();
         lname1.nextToken();
         
         JSONParser headline1 = JSON.createParser( httpRes.getBody() );
         headline1.nextToken();
         headline1.nextToken();
         headline1.nextToken();
         headline1.nextToken();
         headline1.nextToken();
         
         JSONParser prolink1 = JSON.createParser( httpRes.getBody() );
         prolink1.nextToken();
         prolink1.nextToken();
         prolink1.nextToken();
         prolink1.nextToken();
         prolink1.nextToken();
         prolink1.nextToken();
         prolink1.nextToken();
         prolink1.nextToken();
         prolink1.nextToken();
         prolink1.nextToken();
         prolink1.nextToken();
         prolink1.nextToken();
         prolink1.nextToken();
               
        string fname = fname1.getText(); 
        string lname = lname1.getText();
        string headline = headline1.getText();
        string prolink = prolink1.getText(); 
        
        system.debug(fname);
        LinkedIn_Profile__c lp = new LinkedIn_Profile__c();
        
        lp.First_Name__c = fname;
        lp.Last_Name__c = lname;
        lp.Headline__c = headline;
        lp.Profile_URL__c = prolink;
        
        lp.id = recordid;
        
        system.debug(lp.First_Name__c);
 
      update lp;
    }                                                                  
}