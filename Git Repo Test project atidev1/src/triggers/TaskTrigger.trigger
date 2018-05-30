trigger TaskTrigger on Task (before delete, before insert, before update, after delete, 
                             after insert, after update, after undelete) {
    
    // Initiate TaskHandler using trigger framework
    TriggerHandler th = new TaskHandler();
                                        
    // Call trigger logic, and handle logic using trigger framework
    th.handleTrigger(trigger.old, trigger.new, trigger.oldMap, trigger.newMap);
}