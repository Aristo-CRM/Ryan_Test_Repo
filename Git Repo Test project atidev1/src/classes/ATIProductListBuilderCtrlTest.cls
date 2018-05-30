@isTest
private class ATIProductListBuilderCtrlTest {
	
	@isTest 
	private static void test_method_one() {

		List<Product2> prodList = TestObjectFactory.createProductList();
		Pricebook2 defPricebook = TestObjectFactory.createPricebook('My pricebook');

		List<sObject> recs = new List<sObject>();
		recs.addAll((List<sObject>)prodList);
		recs.add(defPricebook);
 
		insert recs;
		
		
		List<PricebookEntry> prodEntryList = TestObjectFactory.createPricebookEntries(prodList, Test.getStandardPricebookId());
		insert prodEntryList;
		
		prodEntryList = TestObjectFactory.createPricebookEntries(prodList, defPricebook.Id);

		insert prodEntryList;

		test.startTest();
		
		List<PricebookEntry> result1 = ATIProductListBuilderCtrl.SearchProducts(defPricebook.Id, 'product', null, 101);
		List<PricebookEntry> result2 = ATIProductListBuilderCtrl.GetRecentProducts(defPricebook.Id);

		test.stopTest();
	}
}