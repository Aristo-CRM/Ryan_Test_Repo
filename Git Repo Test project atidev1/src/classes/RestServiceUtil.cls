/* ---------------------------------------------------
    Author:     Kashyap Murthy
    Company:    Sqware Peg
    Description: Wrapperclass for webservice
    
    Test Class: (current)
    Pages: N.A.
    History:
        Initial creation 2018/04/09

*/

global with sharing class RestServiceUtil {

    /**
     * Service Class to process the Opportunity and prepare the JSON to be passed back to the requested user.
     * Method has the data related Opportunity, Account details.
     * @param opp
     *
     * @return
     */
    public static String getOpportunityDetails (Opportunity opp){
        String result;
        OpportunityWrapper.OpportunityResult oppWrapper = new OpportunityWrapper.OpportunityResult();
        oppWrapper.Id = opp.Id;
        oppWrapper.name = opp.name;
        oppWrapper.accountName = opp.Account.Name;
        oppWrapper.accountPhone = opp.Account.Phone;
        oppWrapper.accountWebsite = opp.Account.Website;
        oppWrapper.accountIndustry = opp.Account.Industry;
        oppWrapper.accountDescription = opp.Account.Description;


        result = JSON.serialize(oppWrapper, true);
        
        System.debug('result --->'+result);
        return result;
    }

    /**
     * Service Class to process the Quote and prepare the JSON to be passed back to the requested user.
     * Method has the data related Quote Line Item, Quote, Opportunity, Account details.
     * @param quote
     *
     * @return
     */
    public static String getQuoteDetails (Quote quote){
        String result;
        
        QuoteWrapper.QuoteResult quoteWrapper = new QuoteWrapper.QuoteResult();
        quoteWrapper.Id = quote.Id;
        quoteWrapper.name = quote.name;
        result = JSON.serialize(quoteWrapper, true);
        
        System.debug('result --->'+result);
        
        return result;    
    }

}