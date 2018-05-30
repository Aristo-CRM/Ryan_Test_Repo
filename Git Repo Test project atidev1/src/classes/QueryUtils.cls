public class QueryUtils {
    
    public static String getCommaSeparatedFields (String sObjectName){
        
        Map<String, Schema.SObjectType> global_describe = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> object_fields_map = global_describe.get(sObjectName).getDescribe().fields.getMap();
        
        List<String> fieldList = new List<String>();
        Set<String> fieldSet = new Set<String>();
        fieldSet.addAll(object_fields_map.keySet());
        
        fieldList.addAll(fieldSet);
        
        String fields = String.join(fieldList, ',');
        
        return fields;
    }
    
    ///services/apexrest/GetOppOrQuote/0060k000005V7Vx
    
}