global class NetsuiteWebserviceCallout {
   
   
    @future (callout=true)
    //WebService static void createRecord ( String recordType, String entityid, String externalid, String companyname ) {
    WebService static void syncRecordWithNetsuite (String recordID){
        System.debug('######Future method called#####');
    }
    
}