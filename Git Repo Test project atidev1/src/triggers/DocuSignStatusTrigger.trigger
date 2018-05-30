/* ---------------------------------------------------
	Author: 	Paul Perry
	Company:	Sqware Peg
	Description: 
		Trigger for Docusign. The logic is moved to DocuSignStatusHandler.
	
	Test Class: N.A.
	Pages: N.A.
	History:
		Initial creation 2018/04/30

*/
trigger DocuSignStatusTrigger on dsfs__DocuSign_Status__c (before delete, before insert, before update,
                                    after delete, after insert, after update, after undelete) {
    
    // Initiate DocuSignStatusHandler using trigger framework
    TriggerHandler th = new DocuSignStatusHandler();
                                        
    // Call trigger logic, and handle logic using trigger framework
    th.handleTrigger(trigger.old, trigger.new, trigger.oldMap, trigger.newMap);
}