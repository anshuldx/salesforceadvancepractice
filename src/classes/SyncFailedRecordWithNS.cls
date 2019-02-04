global class SyncFailedRecordWithNS implements Database.Batchable<sObject>{
   private final String  query;
   global SyncFailedRecordWithNS (String q){
       query=q;
   
   }
   
   global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
   }


   global void execute(Database.BatchableContext BC, 
                       List<sObject> scope){
      
     
   }
   
   


   global void finish(Database.BatchableContext BC){
       
   }
}