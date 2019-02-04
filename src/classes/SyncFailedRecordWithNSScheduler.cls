global class SyncFailedRecordWithNSScheduler implements Schedulable{
    global void execute(SchedulableContext SC) {
        SyncFailedRecordWithNS bacthObj = new SyncFailedRecordWithNS ('select id,name from opportunity limit 1') ;
        //Database.executeBatch(bacthObj);
        NetsuiteWebserviceCallout.syncRecordWithNetsuite ('0069000000LqZkB');
    }
}