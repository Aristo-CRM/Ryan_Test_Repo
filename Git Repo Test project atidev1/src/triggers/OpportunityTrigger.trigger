trigger OpportunityTrigger on Opportunity (before delete, before insert, before update,
                                    after delete, after insert, after update, after undelete) {
    
    // Initiate OpportunityHandler using trigger framework
    TriggerHandler th = new OpportunityHandler();
                                        
    // Call trigger logic, and handle logic using trigger framework
    th.handleTrigger(trigger.old, trigger.new, trigger.oldMap, trigger.newMap);
}