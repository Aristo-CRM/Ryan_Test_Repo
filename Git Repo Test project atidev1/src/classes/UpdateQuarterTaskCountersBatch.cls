/* ---------------------------------------------------
    Author:     Paul Perry
    Company:    Sqware Peg
    Description: 
        UpdateQuarterTaskCountersBatch class is used to reset all task counters on accounts
    
    Test Class: TaskUtilTest
    Pages:
    History:
        Initial creation 2018/05/01

*/
global class UpdateQuarterTaskCountersBatch implements Database.Batchable<SObject> {
    // contains the query that's used to run the batch
    String query;
    
    // Constructor for UpdateQuarterTaskCountersBatch class
    global UpdateQuarterTaskCountersBatch(string query) {
        this.query = query;
    }
    
    // Start method that is fired whenever the batch is started
    global Database.QueryLocator start(Database.BatchableContext BC) {
        system.debug(new object[] {'Batch update quarterly task counters for account records has started!', BC});
        return Database.getQueryLocator(query);
    }

    // Execute method that's called for every chunk of the batch
    // This method contains the actual functionality
    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        // Container to store the account records for updates
        List<Account> accounts = new List<Account>();
        
        // Reset the account's counters to 0
        for (sObject acc :scope) 
            accounts.add((Account)acc);

        Integer processed = TaskUtil.SyncAccounts(accounts);
            
        system.debug(processed + ' account records updated');
    }
    
    // Finish method is fired whenever the batch has finished
    global void finish(Database.BatchableContext BC) {
        system.debug(new object[] {'Batch update quarterly task counters for account records has finished!', BC });
    }
}