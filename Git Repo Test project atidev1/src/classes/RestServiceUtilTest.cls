/* ---------------------------------------------------
    Author:     Paul Perry
    Company:    Sqware Peg
    Description: 
        This class is a test class for the RestServiceUtil
    
    Test Class: (current)
    Pages: N.A.
    History:
        Initial creation 2018/04/20


*/

@isTest
public class RestServiceUtilTest {
/* Test class by SqwarePeg */

    private static Opportunity opp = null;
    private static Quote quote = null;
    
    //Initial Test Data
    //Add Logic to Create data required
    static void SetUp(){
        Account acc = new Account(
            Name = 'test acc',
            Phone = '+61 21 1234 5678',
            Website = 'www.example.com.au',
            Industry = 'Marketing',
            Description = 'desc'
        );
        
        insert acc;
        
        opp = new Opportunity(
            name = 'test op',
            accountId = acc.Id,
            StageName = 'Forecast',
            CloseDate = System.today().addMonths(1)
        );
        
        insert opp;
        
        quote = new Quote(
            name = 'test quote',
            OpportunityId = opp.Id
        );
        
        insert quote;
        
        test.StartTest();
    }
    
    //Tear Down 
    //Add Logic to delete data that has been created
    static void TearDown(){
        test.StopTest();
    }
    
    // Test Method: getOpportunityDetails
    public static testmethod void Test_getOpportunityDetails(){
        SetUp();
                    
        System.Assert(RestServiceUtil.getOpportunityDetails(opp) != '');
        TearDown();
    }
    // Test Method: getQuoteDetails
    public static testmethod void Test_getQuoteDetails(){
        SetUp();
               
        System.Assert(RestServiceUtil.getQuoteDetails(quote) != '');
        TearDown();
    }
}