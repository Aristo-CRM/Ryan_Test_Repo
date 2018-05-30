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
public class TaskUtilTest { 
    
    private static List<Account> accounts = null;
    private static List<Contact> contacts = null;
    
    public static testMethod void taskUpdate() {
        
        InitializeDefaultTestData();
        
        List<Task> tasks = new List<Task> {
            TestObjectFactory.CreateTask('test task #1', 'Call', accounts.get(0).Id, contacts.get(0).Id, system.today()),
            TestObjectFactory.CreateTask('test task #2', 'Call', accounts.get(0).Id, contacts.get(0).Id, system.today()),
            TestObjectFactory.CreateTask('test task #3', 'Meeting', accounts.get(1).Id, contacts.get(1).Id, system.today()),
            TestObjectFactory.CreateTask('test task #4', 'Meeting', accounts.get(0).Id, contacts.get(0).Id, system.today()),
            TestObjectFactory.CreateTask('test task #5', 'Meeting', accounts.get(0).Id, contacts.get(0).Id, system.today())
        };
            
        test.startTest(); 
        
        insert tasks;    
        
        tasks.get(0).Subject = 'Changed';
        update tasks.get(0);
        delete tasks.get(2);
        undelete tasks.get(2);
        
        test.stopTest();
        
        List<Account> checkAccounts = [
            SELECT Id, Actual_Quarterly_Number_of_Meetings__c, Actual_Quarterly_Number_of_Calls__c
            FROM Account
            WHERE Id = :accounts.get(0).Id];
        
        system.assertEquals(2, checkAccounts.get(0).Actual_Quarterly_Number_of_Meetings__c);
        system.assertEquals(2, checkAccounts.get(0).Actual_Quarterly_Number_of_Calls__c);            
    }
    
    public static testMethod void taskSync() {
        
        InitializeDefaultTestData();
        RunTrigger__c disableTriggerFramework = new RunTrigger__c(Is_Disabled__c = true);
        insert disableTriggerFramework;
        
        List<Task> tasks = new List<Task> {
            TestObjectFactory.CreateTask('test task #1', 'Call', accounts.get(0).Id, contacts.get(0).Id, system.today()),
            TestObjectFactory.CreateTask('test task #2', 'Call', accounts.get(0).Id, contacts.get(0).Id, system.today()),
            TestObjectFactory.CreateTask('test task #3', 'Meeting', accounts.get(1).Id, contacts.get(1).Id, system.today()),
            TestObjectFactory.CreateTask('test task #4', 'Meeting', accounts.get(0).Id, contacts.get(0).Id, system.today()),
            TestObjectFactory.CreateTask('test task #5', 'Meeting', accounts.get(0).Id, contacts.get(0).Id, system.today())
        };
        
        insert tasks;                

        List<Account> checkAccounts = [
            SELECT Id, Actual_Quarterly_Number_of_Meetings__c, Actual_Quarterly_Number_of_Calls__c
            FROM Account
            WHERE Id = :accounts.get(0).Id];
        
        system.assertEquals(0, checkAccounts.get(0).Actual_Quarterly_Number_of_Meetings__c);
        system.assertEquals(0, checkAccounts.get(0).Actual_Quarterly_Number_of_Calls__c);
        
        disableTriggerFramework.Is_Disabled__c = false;
        update disableTriggerFramework;
        
        test.startTest();
        
        UpdateQuarterTaskCountersScheduler uqtcs = new UpdateQuarterTaskCountersScheduler();
        String sch = '0 0 23 * * ?'; 
        system.schedule('UpdateQuarterTaskCountersScheduler-Test', sch, uqtcs); 
        
        test.stopTest();
    }
    
    public static void InitializeDefaultTestData() {
        accounts = new List<Account> {
            TestObjectFactory.CreateAccount('Test Account 123-789'),
            TestObjectFactory.CreateAccount('Test Account 234-890')
        };
        
        insert accounts;
        
        contacts = new List<Contact> {
            TestObjectFactory.CreateContact('fistName 1', 'lastName 1', accounts.get(0).Id),
            TestObjectFactory.CreateContact('fistName 2', 'lastName 2', accounts.get(1).Id)
        };
           
        insert contacts;
    }   
}