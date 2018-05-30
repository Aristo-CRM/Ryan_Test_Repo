public without sharing class CustomInputCtrl {
	
    @AuraEnabled
    public static Object GetFieldProperties(string objectName, string fieldName) {    
        Schema.DescribeSobjectResult objDesc = Schema.describeSObjects(new string[] { objectName })[0];
        system.debug(new Object[] {'Object', objDesc});
        Schema.SObjectField objField = objDesc.fields.getMap().get(fieldName);
		system.debug(objField);
        // Field not found
        if (objField == null) throw new NoAccessException();        
        return GetFieldInfo(objField);
    }
  
    @AuraEnabled
    public static List<Object> GetFieldsProperties(string objectName, List<String> fieldNames) {    
        List<Object> result = new List<Object>();
        Schema.DescribeSobjectResult objDesc = Schema.describeSObjects(new string[] { objectName })[0];
        system.debug(new Object[] {'Object', objDesc});

        for (String fieldName :fieldNames) {
            Schema.SObjectField objField = objDesc.fields.getMap().get(fieldName);
            Object record = GetFieldInfo(objField);
            result.add(record);                
        }

        return result;
    }

    private static Object GetFieldInfo(Schema.SObjectField objField) {
        // Field not found
        if (objField == null) throw new NoAccessException();

        DescribeFieldResult fieldProps = objField.getDescribe();

        // User has Access to this field
        if (!fieldProps.isAccessible()) throw new NoAccessException();
        
        system.debug(new Object[] {'objField', objField});

        //return objField;
        List<Map<String, Object>> pickValues = new List<Map<String, Object>>();
        for (PicklistEntry pe :fieldProps.getPicklistValues()) {
            pickValues.add(new Map<String, Object> {
                'label' => pe.getLabel(),  
                'name' => pe.getValue(),  
                'active' => pe.IsActive(),  
                'defaultValue' => pe.IsDefaultValue()
            });
        }

        List<String> references = null;
        if (fieldProps.getReferenceTo() != null) {
            references = new List<String>();
            for (Schema.sObjectType item :fieldProps.getReferenceTo())
                    references.add(item.getDescribe().getName());
        }                

        Map<String, Object> record = new Map<String, Object> {
            'type' => fieldProps.getType().name().toLowerCase(),
            'label' => fieldProps.getLabel(),
            'name' => fieldProps.getName(),
            'length' => fieldProps.getLength(), 
            'picklistValues' => pickValues,
            'nillable' => fieldProps.isNillable(),
            'accessible' => fieldProps.isAccessible(),
            'scale' => fieldProps.getScale(),
            'updateable' => fieldProps.isUpdateable(),
            'restrictedPicklist' => fieldProps.isRestrictedPicklist(),
            'referenceTo' => references
        };

        return record;
    }
}