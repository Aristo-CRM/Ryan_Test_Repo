/* ---------------------------------------------------
    Author:     Paul Perry
    Company:    Sqware Peg
    Description:  
        UpdateQuarterTaskCountersScheduler class is used to schedule the UpdateQuarterTaskCountersBatch 
        that is used to reset all task counters on accounts

        To be scheduled: 1st of the month (manual) or 1st of every quarter (using developer console)
    
    Test Class: TaskUtilTest
    Pages:
    History:
        Initial creation 2018/05/01

*/
global class UpdateQuarterTaskCountersScheduler implements Schedulable {
    // Execute method that is fired whenever the scheduled instance is executed
    global void execute(SchedulableContext sc) {
        // Start the batch
        TaskUtil.StartUpdateBatch();
    }
}