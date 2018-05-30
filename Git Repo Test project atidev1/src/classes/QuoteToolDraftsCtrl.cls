global class QuoteToolDraftsCtrl {
    
    @AuraEnabled
    public static Map<string, Object> GetRecordDetails(Id recordId) {
        if (!HasReadAccess(recordId)) 
            throw new QuoteToolException('No access to this record');
        
        Map<string, Object> result = new Map<string, Object>();
        
        return result;
    }
    
    @AuraEnabled
    public static Map<String, Object> UpdateRecord(Map<String, Object> data) {
        string recordId;
        if (data.containsKey('Id')) {
            recordId = (String)data.get('Id');
            if (!HasEditAccess(recordId)) 
                throw new QuoteToolException('No access to this record');
        } else if (!Quote_Tool_Drafts__c.sObjectType.getDescribe().accessible) {
            throw new QuoteToolException('No access to create new records');
        }
        
        Map<String, Object> result = new Map<String, Object>();
        return result;
    }
    
    @AuraEnabled
    public static Map<string, Object> GetPicklistValues(List<String> picklistNames, List<String> picklistObjects) {
/*        List<QuoteToolSetting__mdt> items = [
            SELECT Id, Label, Value__c, Setting__c
            FROM QuoteToolSetting__mdt
            WHERE Setting__c IN :picklistNames
            ORDER BY Setting__c, Value__c];
        
        Map<string, List<Object>> result = new Map<string, List<Object>>();
        for (QuoteToolSetting__mdt item :items) {
            if (!result.containsKey(item.Setting__c))
                result.put(item.Setting__c, new List<Object>());
            result.get(item.Setting__c).add(item);
        }
        
        if (picklistObjects.contains('Contact')) 
            result.put('Contact', [SELECT Id, Name FROM Contact LIMIT 80]);
        
        if (picklistObjects.contains('Account')) 
            result.put('Account', [SELECT Id, Name FROM Account LIMIT 80]);
                
        if (picklistObjects.contains('Product')) 
            result.put('Product', [SELECT Id, Name FROM Product2 LIMIT 80]);
                
        return result;*/
        return null;
    }
    
    private static Boolean HasEditAccess(Id recordId) {
        UserRecordAccess access = [
            SELECT RecordId, HasEditAccess
            FROM UserRecordAccess 
            WHERE UserId = :userInfo.getUserId() 
              AND RecordId = :recordId];
        
        return access.HasEditAccess;
    }
    
    private static Boolean HasReadAccess(Id recordId) {
        UserRecordAccess access = [
            SELECT RecordId, HasReadAccess
            FROM UserRecordAccess 
            WHERE UserId = :userInfo.getUserId() 
              AND RecordId = :recordId];
        
        return access.HasReadAccess;
    }
    
    public class QuoteToolException extends Exception {}
}