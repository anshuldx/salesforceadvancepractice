trigger testBeforeInsert on Account (before insert) {
    for(Account accnt: Trigger.New)  {
        //accnt.name='vrushu';
        accnt.test__c=accnt.nameformula__c;
    
    }  
}