/**
 * Created by KashyapMurthy on 11/04/2018.
 */

global class GetOpportunity {

    global class OpportunityInfo {
        webservice String opportunityId;
    }

    webservice static Opportunity getOpportunity(OpportunityInfo info) {
        String searchId = info.opportunityId;
        Opportunity opp = new Opportunity();
        String oppQuery = ' SELECT  Account.Name, Account.Phone, Account.Website, Account.Industry, Account.Description, '+
                QueryUtils.getCommaSeparatedFields('Opportunity') + ' FROM Opportunity WHERE ID =: searchId';
        List<Opportunity> oppList = Database.query(oppQuery);

        if (!oppList.isEmpty())
            opp = oppList[0];

        opp = Database.query(oppQuery);
        

        return opp;

    }
}