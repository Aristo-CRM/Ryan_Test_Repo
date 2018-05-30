/* ---------------------------------------------------
    Author:     Paul Perry
    Company:    Sqware Peg
    Description: 
        TaskUtilTest - Used to test custom task rollup functionality for accounts
		including Batch and scheduler for syncing per Fiscal Quarter

    Test Class:
		TaskUtil, TaskTrigger, UpdateQuarterTaskCountersBatch and UpdateQuarterTaskCountersScheduler
    Pages: N.A.
    History:
        Initial creation 2018/05/01

*/
@isTest
public class DocuSignStatusUtilTest {
    // Container to store temporarily created users during test
    public static List<User> users = null;    
    
    /*
     * This test method creates 4 DocuSign status records for 4 different
     * users. After that is verified whether the record access between the
     * users is setup properly.
     */ 
    public static testMethod void testAccess() {
		// Create 4 users
        InitializeDefaultTestData();
        
        List<Id> docAccess = new List<Id>();
        Map<Id, Set<Id>> docAccessByUser = new Map<Id, Set<Id>>();
        
        // Call Start test to prevent mixed DML
        test.startTest();
        // Impersonate all of the 4 users
        for (User usr :users) {
            // Create a new DocuSign status Record on behalf of user
            system.runAs(usr) {
                dsfs__DocuSign_Status__c docStatus = new dsfs__DocuSign_Status__c();
                insert docStatus;
                docAccess.add(docStatus.Id);
            }
        }
		
        // Verify access for all of the 4 users
        for (User usr :users) {
            system.runAs(usr) {
                system.debug(TestObjectFactory.whoIs(usr));
                
                // Fetch all records on behalf of user
                List<dsfs__DocuSign_Status__c> readDocStatus = [
                    SELECT Id, OwnerId
                	FROM dsfs__DocuSign_Status__c
                	WHERE Id IN :docAccess];
                
                system.debug(new object[] {readDocStatus.size(), readDocStatus});
                
                // Keep track of what's visible to who
                for (dsfs__DocuSign_Status__c doc :readDocStatus) {
                    if (!docAccessByUser.containsKey(usr.Id)) docAccessByUser.put(usr.Id, new Set<Id>());
                    docAccessByUser.get(usr.Id).add(doc.OwnerId);
                }
            }
        }
        
        test.stopTest();
        
        // Verify whether access is configured poperly
        System.assertEquals(
            docAccessByUser.get(users.get(0).Id).contains(users.get(1).Id), true, 
            'cfoUser Should have access to records created by bdeUser1');
        System.assertEquals(
            docAccessByUser.get(users.get(1).Id).contains(users.get(0).Id), false, 
            'bdeUser1 Should not have access to records created by cfoUser');        
        System.assertEquals(
            docAccessByUser.get(users.get(1).Id).contains(users.get(2).Id), true, 
            'bdeUser1 Should have access to records created by bdeUser1');        
        System.assertEquals(
            docAccessByUser.get(users.get(3).Id).contains(users.get(2).Id), false, 
            'bdeUser2 Should not have access to records created by bdeUser3');     
    }
    
    /*
     * Test method to cover all methods of the trigger framework for 
     * DocuSign Status object.
     */ 
    public static testMethod void testDbActions() {
        test.startTest();

        dsfs__DocuSign_Status__c docStatus = new dsfs__DocuSign_Status__c();
        insert docStatus;
        docStatus.dsfs__Subject__c = 'changed value';
        update docStatus;
        delete docStatus;
        undelete docStatus;
        
        test.stopTest();
    }
    
    /*
     * Method used to create 4 users with given role and profile
     * */
    private static void InitializeDefaultTestData() {  
        users = new List<User> {
            TestObjectFactory.CreateNewUser('cfoUser', 'ATI CFO', 'Global CFO'),
            TestObjectFactory.CreateNewUser('bdeUser1', 'ATI US - Salespeople', 'Sales Team - North NSW'),
            TestObjectFactory.CreateNewUser('bdeUser2', 'ATI US - Salespeople', 'Sales Team - North NSW'),        
            TestObjectFactory.CreateNewUser('bdeUser3', 'ATI US - Salespeople', 'Sales Team - Metro')
        };
            
        insert users;
    }        
}