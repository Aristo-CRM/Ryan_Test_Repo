public class BeforeInsertQuoteLineItem {
    public static void populatePriceBookEntry (List<QuoteLineItem> newList) {
        Map<String, QuoteLineItem> qliMap = new Map<String, QuoteLineItem>();
        Map<String, PriceBookEntry> pbeMap = new Map<String, PriceBookEntry>();
        Set<String> productCodeSet = new Set<String>();
        
        
        for (QuoteLineItem qliIter : newList){    
            qliMap.put(qliIter.PRODUCTACTID__c, qliIter);
            productCodeSet.add(qliIter.PRODUCTACTID__c);
        }
        
        for (PriceBookEntry pbeIter : [SELECT Id, IsActive, IsDeleted, Jurisdiction__c, Name, Product2Id, ProductCode FROM PricebookEntry where ProductCode IN :productCodeSet]){
        	pbeMap.put(pbeIter.ProductCode, pbeIter);    
        }
        
        for (String key : qliMap.keySet()) {
        	PriceBookEntry pbe = pbeMap.get(key);   
            if (pbe != null){
            	QuoteLineItem qliItem = qliMap.get(key);  
                qliItem.PricebookEntryId = pbe.Id;
                qliItem.Product2Id       = pbe.Product2Id;
            }
        }
    }
}