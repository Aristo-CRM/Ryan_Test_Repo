@isTest
public class ATIQuoteDraftCtrlTest {
    public static testMethod void runTest() {
        Product2 product = TestObjectFactory.createProduct('prd');
        Account acc = TestObjectFactory.createAccount('test acc');
        insert new SObject[] { acc, product };

        Customer_Preference__c cp = TestObjectFactory.createCustomerPreference(acc.Id, product.Id);        
        Opportunity opp = TestObjectFactory.createNewOpportunity(acc.Id, 'Test Opp');

        insert new SObject[] { opp, cp };
        
        Quote_Tool_Drafts__c quoteTool = TestObjectFactory.CreateNewQuoteToolDrafts(opp.Id);
        insert quoteTool;
        
        test.startTest();
        String conversionLines = 'new conversion';
        String quoteLines = 'new quoteLines';
        ATIQuoteDraftCtrl.SetQuoteDetails(quoteTool.Id, quoteLines, conversionLines, '', '');
        
        Map<String, Object> result = ATIQuoteDraftCtrl.GetQuoteDetails(quoteTool.Id);
        Map<String, Object> resultOpp = ATIQuoteDraftCtrl.GetQuoteDetails(opp.Id);
        Quote_Tool_Drafts__c quote = (Quote_Tool_Drafts__c)result.get('QuoteDetail');
        system.assertEquals(quote.ConversionLineItems__c, conversionLines, 'conversionLines should be changed');
        system.assertEquals(quote.QuoteLineItems__c, quoteLines, 'quoteLines should be changed');
        
        test.stopTest();
    }
    
    public static testMethod void testPicklistValues() {
        // PreDefined / configured picklists
        List<QuoteFormPicklist__mdt> picklists = [
            SELECT Id, Label__c, DeveloperName
            FROM QuoteFormPicklist__mdt];
        
        List<String> picklistNames = new List<String>();
        for (QuoteFormPicklist__mdt item :picklists)
            pickListNames.add(item.DeveloperName);

        // DependingOn Existing Field picklists
        List<String> existingFields = new List<String> {
            'Opportunity.StageName',
            'Account.Region__c',
            'Contact.CurrencyIsoCode',
            'Account.Sales_Region__c'
        };
		
        test.startTest();

        Map<String, Object> 
            result = ATIQuoteDraftCtrl.GetPicklists(picklistNames, existingFields),
            preDef = (Map<String, Object>)result.get('predefined'),
            basedOn = (Map<String, Object>)result.get('basedOn');

        // Assuming there's always at least 1 picklist value for every picklist 
        system.assertEquals(preDef.size(), picklists.size(), 
            'Number of predefined picklists should be equal');        

        system.assertEquals(basedOn.size(), existingFields.size(), 
            'Number of depending-on picklists should be equal');        

        test.stopTest();
    }
}