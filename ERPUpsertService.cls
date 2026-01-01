public class ERPUpsertService {

    public static void upsertRecords(String objectName, List<Map<String,Object>> data) {

        ERP_Object__mdt obj =
            [SELECT Target_Object__c, External_Id_Field__c
             FROM ERP_Object__mdt
             WHERE DeveloperName = :objectName
             LIMIT 1];

        List<ERP_Field_Mapping__mdt> fields =
            [SELECT SAP_Field__c, Salesforce_Field__c
             FROM ERP_Field_Mapping__mdt
             WHERE Object_Name__c = :objectName];

        List<SObject> records = new List<SObject>();

        for (Map<String,Object> row : data) {

            SObject rec =
                Schema.getGlobalDescribe()
                      .get(obj.Target_Object__c)
                      .newSObject();

            for (ERP_Field_Mapping__mdt f : fields) {
                if (row.containsKey(f.SAP_Field__c)) {
                    rec.put(f.Salesforce_Field__c, row.get(f.SAP_Field__c));
                }
            }
            records.add(rec);
        }

        upsert records obj.External_Id_Field__c;
    }
}
