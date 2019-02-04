global class ExampleBatchClass implements Database.Batchable<sObject>,Database.AllowsCallouts{
     private string query;
     global ExampleBatchClass(String query){
                // Batch Constructor
                this.query=query;
     }
     
     // Start Method
     global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator(query);
     }
    
   // Execute Logic
    global void execute(Database.BatchableContext BC, List<sObject>scope){
           // Logic to be Executed batch wise 
           updatePicklistMetadata.UpdatedPickListValues(scope[0].id);     
   
    }
   
    global void finish(Database.BatchableContext BC){
         // Logic to be Executed at finish
    }
 }