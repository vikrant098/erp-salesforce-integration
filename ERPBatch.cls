public class ERPBatch implements Database.Batchable<Map<String,Object>> {

    private String objectName;
    private String json;

    public ERPBatch(String objectName, String json) {
        this.objectName = objectName;
        this.json = json;
    }

    public Iterable<Map<String,Object>> start(Database.BatchableContext bc) {

        List<Object> raw = (List<Object>) JSON.deserializeUntyped(json);
        List<Map<String,Object>> rows = new List<Map<String,Object>>();

        for (Object o : raw) {
            rows.add((Map<String,Object>) o);
        }

        return rows;
    }

    public void execute(Database.BatchableContext bc, List<Map<String,Object>> scope) {
        ERPUpsertService.upsertRecords(objectName, scope);
    }

    public void finish(Database.BatchableContext bc) {}
}
