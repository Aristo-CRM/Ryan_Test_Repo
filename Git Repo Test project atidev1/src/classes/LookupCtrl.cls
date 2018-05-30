public class LookupCtrl {
	@AuraEnabled
    public static Object GetRecentItems(List<String> objectTypes) {
        Map<String, List<SObject>> result = new Map<String, List<SObject>>();
        
        List<RecentlyViewed> temp = [
            SELECT Id, Name, LastName, FirstName, Type, Alias, IsActive, Title, Email, LastViewedDate, LastReferencedDate, Language
            FROM RecentlyViewed
            WHERE Type IN :objectTypes
            ORDER BY LastViewedDate DESC];
        
        for (RecentlyViewed rv :temp) {
            if (!result.containsKey(rv.Type))
                result.put(rv.Type, new List<SObject>());
            result.get(rv.Type).add(rv);
        }
        
        return result;
    }

    @AuraEnabled
    public static Map<String, Object> GetSearchResults(String objectType, String searchTxt, Integer requestId) {
        Schema.DescribeSobjectResult objDesc = Schema.describeSObjects(new string[] { objectType })[0];
        Map<String, Schema.SObjectField> fieldMap = objDesc.fields.getMap();
        DescribeFieldResult nameField = null;

        if (!objDesc.isAccessible()) throw new NoAccessException();

        for (Schema.SObjectField field :fieldMap.values()) {
            DescribeFieldResult fieldDesc = field.getDescribe();
            if (fieldDesc.isNameField()) {
                nameField = fieldDesc;
                break;
            }
        }

        // Prevent SOQL injection
        searchTxt = searchTxt
            .replace('\'', '')
            .replace('*', '%');

        string sql = 
            'SELECT Id, ' + nameField.getName() +
            '  FROM ' + objDesc.getName() +
            ' WHERE ' + nameField.getName() + ' LIKE \'' + searchTxt + '%\'' +
            ' LIMIT 2';

        system.debug(sql);


        Map<String, Object> result = new Map<String, Object> {
            'field' => new Map<String, Object> {
                'name' => nameField.getName()
            },

            'object' => new Map<String, Object> {
                'Label' =>  objDesc.getLabel(),
                'LabelPlural' =>  objDesc.getLabelPlural()
            }
        };
        
        result.put('requestId', requestId);
        result.put('results', (List<SObject>)Database.query(sql));
        system.debug(result);
        return result;
    }
}