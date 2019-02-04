public class CaseValidateApproval{
    //Variables
    boolean approvalLockFlag;
    //getter-setters
    public string comments{get;set;}
    public boolean showFieldsSection{get;set;}
    
    public Case caseRecord {get;set;}
    public CaseValidateApproval(ApexPages.StandardController stdController){
        caseRecord=(Case)stdController.getRecord();
        caseRecord=[select id,Type,Approval_Discretion_Tier__c,Regulated_Unregulated__c from case where id=:caseRecord.id]; 
        showFieldsSection=false; 
        approvalLockFlag=false;  
    
    }
    
    public void decideSectionsToDisplay(){
        String errorFieldString='';
        if( (caseRecord.Type=='' || caseRecord.Type==null)||
              (caseRecord.Approval_Discretion_Tier__c=='' || caseRecord.Approval_Discretion_Tier__c==null)||
              (caseRecord.Regulated_Unregulated__c=='' || caseRecord.Regulated_Unregulated__c==null)
          
          
          ){
              if((caseRecord.Type=='' || caseRecord.Type==null))
                 errorFieldString+='Type,'; 
              if((caseRecord.Approval_Discretion_Tier__c=='' || caseRecord.Approval_Discretion_Tier__c==null))
                 errorFieldString+='Approval Discretion Tier, ';
              if((caseRecord.Regulated_Unregulated__c=='' || caseRecord.Regulated_Unregulated__c==null))
                 errorFieldString+='Regulated / Unregulated';
              errorFieldString=errorFieldString.trim();
              errorFieldString=errorFieldString.removeEnd(',');
              showFieldsSection=true;
              //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please populate the following mandatory fields ('+ errorFieldString +') in order to submit for approval'));
              
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'<b> Computer says "No". Any of the case values:</b>\n'+errorFieldString));
              //return null;
          }
    }
    public pageReference submitAndProcessApprovalRequest() {
          
          if(Approval.isLocked(caseRecord.Id)){
              approvalLockFlag=true;
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'The approval process is already in progress.'));
              return null;
           } 
           else{    
                // Create an approval request for the account
                Approval.ProcessSubmitRequest req1 = 
                    new Approval.ProcessSubmitRequest();
                req1.setComments('Submitting request for approval.');
                //req1.setObjectId(a.id);
                req1.setObjectId(caseRecord.id);
                // Submit on behalf of a specific submitter
                req1.setSubmitterId(UserInfo.getUserID()); 
                 // Submit the record to specific process and skip the criteria evaluation
                //req1.setProcessDefinitionNameOrId('PTO_Request_Process');
                //req1.setSkipEntryCriteria(true);
                String approvalErrorString='';
                // Submit the approval request for the account
                Database.Error[] errors;
                try{
                    Approval.ProcessResult result = Approval.process(req1);
                    errors= result.getErrors();
                    System.debug('####errors#####'+errors);
                    if(errors.size()>0){
                        for(Database.Error error: errors){
                            approvalErrorString+=error.getMessage();    
                        }
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Error Occured in Approval Process: '+approvalErrorString));
                        return null;
                    }
                   
                }
                catch(Exception e){
                    
                    
                }
                return null;
                //return new pageReference('/'+caseRecord.id);
             }   
            
       
    }
    public pageReference save(){
        String errorFieldString='';
        if( (caseRecord.Type=='' || caseRecord.Type==null)||
              (caseRecord.Approval_Discretion_Tier__c=='' || caseRecord.Approval_Discretion_Tier__c==null)||
              (caseRecord.Regulated_Unregulated__c=='' || caseRecord.Regulated_Unregulated__c==null)
          
         ){
              if((caseRecord.Type=='' || caseRecord.Type==null))
                 errorFieldString+='Type, '; 
              if((caseRecord.Approval_Discretion_Tier__c=='' || caseRecord.Approval_Discretion_Tier__c==null))
                 errorFieldString+='Approval Discretion Tier, ';
              if((caseRecord.Regulated_Unregulated__c=='' || caseRecord.Regulated_Unregulated__c==null))
                 errorFieldString+='Regulated / Unregulated';
              showFieldsSection=true;
              errorFieldString=errorFieldString.trim();
              errorFieldString=errorFieldString .removeEnd(',');
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'<b> Computer says "No". Any of the case values:</b>\n'+errorFieldString));
              return null;
          }
        else{
            
            update caseRecord;
            submitAndProcessApprovalRequest();
            if(!approvalLockFlag)
                return new pageReference('/'+caseRecord.id);
            else
                return null;
        }
    }
}