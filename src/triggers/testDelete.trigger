trigger testDelete on TestObj__c (after insert,after update) {
    TestObj__c obj=[select id from TestObj__c where id=:Trigger.New[0].id];
    delete obj;
}