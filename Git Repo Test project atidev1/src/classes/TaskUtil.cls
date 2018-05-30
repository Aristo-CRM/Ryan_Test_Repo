/* ---------------------------------------------------
    Author:     Paul Perry
    Company:    Sqware Peg
    Description: 
        Task Util class contains all operations related to tasks
    
    Test Class: TaskUtilTest
    Pages: N.A.
    History:
        Initial creation 2018/05/01

*/
public class TaskUtil {
    /*
     * This method is used to launch the batch. This can be done using the Apex scheduler
     *  or using Anonymous Execute using the Developer Console
     */ 
    public static void StartUpdateBatch() {
         String query = 
            'SELECT Id, Actual_Quarterly_Number_of_Meetings__c, Actual_Quarterly_Number_of_Calls__c ' +
            'FROM Account ' +
            'WHERE LastModifiedDate >= Last_Fiscal_Quarter';
        
        UpdateQuarterTaskCountersBatch updateBatch = new UpdateQuarterTaskCountersBatch(query);
        Id batchId = Database.ExecuteBatch(updateBatch);
        system.debug(new Object[] { 'Start batch:', batchId});  
    }

    public static Integer SyncAccounts(List<Account> accountList) {
        // Container to store the account records for updates
        Map<Id, Account> 
            updates = new Map<Id, Account>(),
            accounts = new Map<Id, Account>(accountList);
        
        // Grab all the number of tasks, grouped by AccountId and Task Type
        List<AggregateResult> result = [
            SELECT WhatId, Type, COUNT(Id) nmbr
             FROM Task
            WHERE Type IN ('Call', 'Meeting')
              AND ActivityDate >= LAST_QUARTER
              AND WhatId IN :accounts.keySet()
            GROUP BY WhatId, Type];
        
        // Update the account quarterly numbers with the most actual amount
        // in case >0 
        for (AggregateResult res :result) {
            string typeName = (string)res.get('Type');
            Id accId = (Id)res.get('WhatId');
            Integer cnt = (Integer)res.get('nmbr');
            Account 
                currentAcc = accounts.get(accId),
                newAcc = updates.containsKey(accId) ? updates.get(accId) : null;
                                    
            if (typeName == 'Meeting' && currentAcc.Actual_Quarterly_Number_of_Meetings__c != cnt) {
                if (newAcc == null) updates.put(accId, new Account(Id = accId, Actual_Quarterly_Number_of_Meetings__c = cnt));
                else newAcc.Actual_Quarterly_Number_of_Meetings__c = cnt;
            } else if (typeName == 'Call') {
                if (newAcc == null) updates.put(accId, new Account(Id = accId, Actual_Quarterly_Number_of_Calls__c = cnt));
                currentAcc.Actual_Quarterly_Number_of_Calls__c = cnt;       
            }
        } 
        
        // Store the account record updates to the system
        if (updates.size() > 0)
            update updates.values();

        return updates.size();
    }
    
    /*
     * Custom dev RollUp solution for tasks related to accounts
     * type of Call or Meeting. Count the number of tasks related
     * to the account for this quarter and store the amount in 
     * related account record fields.
     * */
    public static void UpdateQuarterlyAccountTasks(List<Task> taskList) {
        // Capture these type of Tasks
        Set<String> typeNames = new Set<String> {
            'Call', 'Meeting'   
        };
            
        // Account prefix, filter out all the others
        string accPrefix = '001';
        List<Task> tasks = FilterTasks(taskList, accPrefix);  
        
        // Get the startdate of current Fiscal Quarter
        Date startDateFQ = CurrentStartOfFY();
        
        // Keep track of all accounts that are involved
        Set<Id> accountIds = new Set<Id>();
        for (Task task :tasks) 
            if (typeNames.contains(task.Type))
                accountIds.add(task.WhatId);
        
        Map<Id, Integer> 
            cntCalls = new Map<Id, Integer>(),
            cntMeetings = new Map<Id, Integer>();
        
        // Get all tasks type of Call and Meeting
        // to get the actual number of records
        // within current Fiscal Quarter
        List<Task> existingTasks = [
            SELECT Id, WhatId, Type
            FROM Task
            WHERE Type = 'Call'
              AND WhatId IN :accountIds
              AND IsClosed = true
              AND ActivityDate >= Last_Fiscal_Quarter];
        
        // Loop through all the recods and start counting number of meeting and call tasks
        for (Task task :existingTasks) 
            if (!cntCalls.containsKey(task.WhatId)) cntCalls.put(task.WhatId, 1);
            else cntCalls.put(task.WhatId, cntCalls.get(task.WhatId) + 1);

        List<Event> existingEvents = [
            SELECT Id, WhatId, Type, EndDateTime 
            FROM Event
            WHERE Type = 'Meeting'
              AND WhatId IN :accountIds
              AND StartDateTime >= Last_Fiscal_Quarter
              AND EndDateTime < :system.now()];    

        for (Event event :existingEvents)
            if (!cntMeetings.containsKey(event.WhatId)) cntMeetings.put(event.WhatId, 1);
            else cntMeetings.put(event.WhatId, cntMeetings.get(event.WhatId) + 1);

        
        // Container for all involved accounts to be updated
        Map<Id, Account> accounts = new Map<Id, Account>();
        // Generate a field update for FQ number of calls for each account
        for (Id accId :cntCalls.keySet()) 
            accounts.put(accId, new Account(Id = accId, Actual_Quarterly_Number_of_Calls__c = cntCalls.get(accId)));
        
        // Generate a field update for FQ number of meetings for each account
        for (Id accId :cntMeetings.keySet()) 
            if (accounts.containsKey(accId)) 
                accounts.get(accId).Actual_Quarterly_Number_of_Meetings__c = cntMeetings.get(accId);
            else accounts.put(accId, new Account(Id = accId, Actual_Quarterly_Number_of_Meetings__c = cntMeetings.get(accId)));     
        
        // Store account record updates to the system
        update accounts.values();
    }  
    
    /*
     * Filter out any task that has is WhatId set to an object other then given prefix
     * */
    private static List<Task> FilterTasks(List<Task> input, string prefix) {
        List<Task> result = new List<Task>();
        for (Task task :input)
            if (((String)task.WhatId).substring(0,3).equals(prefix))
                result.add(task);
        
        return result;
    }
    
    /*
    * Get the startdate of the current quarter
    *  as configured within the system
    * */
    public static Date CurrentStartOfFY() {
        Period currentFQ = [
            SELECT StartDate 
            FROM Period 
            WHERE Type = 'Quarter' 
              AND StartDate = THIS_FISCAL_QUARTER];

        return currentFQ.StartDate;
    } 
}