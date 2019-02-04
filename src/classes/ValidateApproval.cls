public class ValidateApproval{
    
    Lead leadRecord;
    public ValidateApproval(ApexPages.StandardController stdController){
        leadRecord=(Lead)stdController.getRecord();
        leadRecord=[select id,leadsource,qGlobes__Approval_Started__c from lead where id=:leadRecord.id];    
    
    }
    
    
    public pageReference submitAndProcessApprovalRequest() {
          if(leadRecord.leadsource=='' || leadRecord.leadsource==null){
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Kindly populate the Lead Source in order to submit for the approval'));
              return null;
          }
          /*else if(leadRecord.qGlobes__Approval_Started__c==true){
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Approval process already started'));
              return null;
          }*/
          else{
              
             //String recordID=ApexPages.currentPage().getParameters().get('Id');  
            //User user1 = [SELECT Id FROM User WHERE Alias='SomeStandardUser'];
                
            // Create an approval request for the account
            Approval.ProcessSubmitRequest req1 = 
                new Approval.ProcessSubmitRequest();
            //req1.setComments('Submitting request for approval.');
            //req1.setObjectId(a.id);
            req1.setObjectId(leadRecord.id);
            // Submit on behalf of a specific submitter
            req1.setSubmitterId(UserInfo.getUserID()); 
            
            // Submit the record to specific process and skip the criteria evaluation
            //req1.setProcessDefinitionNameOrId('PTO_Request_Process');
            //req1.setSkipEntryCriteria(true);
            
            // Submit the approval request for the account
            Approval.ProcessResult result = Approval.process(req1);
            leadRecord.qGlobes__Approval_Started__c=true;
            save();
            // Verify the result
            System.assert(result.isSuccess());
            return new pageReference('/'+leadRecord.id);
        }
        return null;
       
    }
    public void save(){
        upsert leadRecord;
    }
}