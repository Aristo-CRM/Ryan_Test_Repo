public class ATIProductListBuilderCtrl {

	private static Set<String> productFamilies = new Set<String> {
		'EGM', 'Conversions'
	};
	 
	@AuraEnabled
	public static List<PriceBookEntry> SearchProducts(Id pricebookId, String search, Integer offset, Integer resLimit) {
		String searchStr = '%' + search + '%';

		if (offset == null) offset = 0;		
		if (resLimit == null || resLimit > 100) resLimit = 100;

		List<PriceBookEntry> result = [
			SELECT Id, Product2.Name, Product2.Description, Product2.Family, UnitPrice, Product2.Jurisdiction__c
			FROM PriceBookEntry 
			WHERE Pricebook2Id = :pricebookId
			  AND Product2.Family IN :productFamilies
			  AND (Product2.Name LIKE :searchStr OR Product2.Description LIKE :searchStr)
			ORDER BY Product2.Name
			LIMIT :resLimit OFFSET :offset];

		return result;
	}

	@AuraEnabled
	public static List<PriceBookEntry> GetRecentProducts(Id pricebookId) {
		List<sObject> recentlyViewedProducts = [
			SELECT Id
    		FROM RecentlyViewed
    		WHERE Type = 'Product2'];

		Set<Id> recentProdIds = new Set<Id>();
		for (sObject item :recentlyViewedProducts)
			recentProdIds.add(item.Id);

		List<PriceBookEntry> result = [
			SELECT Id, Product2.Name, Product2.Description, Product2.Family, UnitPrice, Product2.Jurisdiction__c
			FROM PriceBookEntry 
			WHERE Pricebook2Id = :pricebookId
			  AND Product2Id IN :recentProdIds
			  AND Product2.Family IN :productFamilies
			ORDER BY Product2.Name];
		
		return result;
	}	
}