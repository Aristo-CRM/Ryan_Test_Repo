@RestResource(urlMapping='/GetOppOrQuote/*')
global with sharing class GetOpportunityOrQuoteDetails {

    @HttpGet
    global static String doGet() {
        String result;
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String searchId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);

        if (String.isNotBlank(searchId)){
            if (searchId.startsWith('006')){
                // Opportunity oppResult = [SELECT Id, Name, Region__c  FROM Opportunity WHERE Id = :searchId];
                String oppQuery = ' SELECT  Account.Name, Account.Phone, Account.Website, Account.Industry, Account.Description, '+
                        QueryUtils.getCommaSeparatedFields('Opportunity') + ' FROM Opportunity WHERE ID =: searchId';
                List<Opportunity> oppList = Database.query(oppQuery);

                return RestServiceUtil.getOpportunityDetails(oppList[0]);
            }
            if (searchId.startsWith('0Q0')){
                Quote quoteResult = [SELECT Id, Name, (SELECT Id FROM QuoteLineItems) FROM Quote WHERE Id = :searchId];
                return RestServiceUtil.getQuoteDetails(quoteResult);
            }
        }

        return null;
    }
}