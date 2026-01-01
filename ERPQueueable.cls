public class ERPQueueable implements Queueable, Database.AllowsCallouts {

    private String objectName;
    private String endpoint;

    public ERPQueueable(String objectName, String endpoint) {
        this.objectName = objectName;
        this.endpoint = endpoint;
    }

    public void execute(QueueableContext context) {

        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        req.setTimeout(60000);

        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            String responseBody = res.getBody();
            Database.executeBatch(new ERPBatch(objectName, responseBody), 200);
        } else {
            System.debug('ERP call failed: ' + res.getStatus());
        }
    }
}
