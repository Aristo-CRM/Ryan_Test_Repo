public class ATIQuoteDraftLineItemsCtrl {
	@AuraEnabled
    public static List<Object> GetFieldsProperties(string objectName, List<String> fieldNames) {    
        return CustomInputCtrl.GetFieldsProperties(objectName, fieldNames);
    }
}