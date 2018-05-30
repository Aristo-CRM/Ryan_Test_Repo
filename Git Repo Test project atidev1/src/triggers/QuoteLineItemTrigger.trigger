trigger QuoteLineItemTrigger on QuoteLineItem  (before delete, before insert, before update,
                                    after delete, after insert, after update, after undelete) 
{
    
     // Initiate QuoteLineItemTriggerHandler using trigger framework
    TriggerHandler th = new QuoteLineItemTriggerHandler();
                                        
    // Call trigger logic, and handle logic using trigger framework
    th.handleTrigger(trigger.old, trigger.new, trigger.oldMap, trigger.newMap);   

    

}