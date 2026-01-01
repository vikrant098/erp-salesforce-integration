global class ERPScheduler implements Schedulable {

    global void execute(SchedulableContext sc) {

        // Load all configured ERP endpoints
        List<ERP_Object__mdt> configs = [
            SELECT DeveloperName, SAP_Endpoint__c
            FROM ERP_Object__mdt
        ];

        for (ERP_Object__mdt cfg : configs) {
            System.enqueueJob(
                new ERPQueueable(cfg.DeveloperName, cfg.SAP_Endpoint__c)
            );
        }
    }
}
