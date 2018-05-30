/* ---------------------------------------------------
	Author: 	Paul Perry
	Company:	Sqware Peg
	Description: 
		Trigger framework, used to separate triggers from logic.
		Additional feature is the ability to "switch off" all 
        trigger logic for migration purposes
	
	Test Class:
	Pages:
	History:
		Initial creation 2018/04/11

*/
public virtual class TriggerHandler {
	// Container for oldList containing pre trigger list information, if applicable
	protected List<sObject> oldListSobject;
	// Container for newList containing post trigger list information
	protected List<sObject> newListSobject;
	// Container for oldList containing pre trigger map information, if applicable
	protected Map<Id,sObject> oldMapSobject;
	// Container for newList containing post trigger map information
	protected Map<Id,sObject> newMapSobject;
	
    // Constructor for trigger handler
	public TriggerHandler() {}

	// Use this to fire the trigger
    public void handleTrigger(List<sObject> oldListSobject, List<sObject> newListSobject, Map<Id,sObject> oldMapSobject, Map<Id,sObject> newMapSobject) {
        // Stop execution in case trigger framework is disabled
    	if (TriggersDisabled()) return;
        
		this.oldListSobject = oldListSobject;
		this.newListSobject = newListSobject;
		this.oldMapSobject = oldMapSobject;
		this.newMapSobject = newMapSobject;
        
        // This method is used to initialize all vars at the extension class
		this.handleSubTrigger();
		
        // Call the requested extension class method
		if(Trigger.isExecuting){
			if(Trigger.isBefore) {
				if(Trigger.isUpdate){ this.beforeUpdate();}
				if(Trigger.isInsert){ this.beforeInsert();}
				if(Trigger.isDelete){ this.beforeDelete();}
			}
			if(Trigger.isAfter){
				if(Trigger.isUpdate){ this.afterUpdate();}
				if(Trigger.isInsert){ this.afterInsert();}
				if(Trigger.isDelete){ this.afterDelete();}
				if(Trigger.isUndelete){ this.afterUndelete();}
			}
		}
	}

	//Handler methods for override
	protected virtual void beforeInsert(){}
	protected virtual void beforeUpdate(){}
	protected virtual void beforeDelete(){}
	protected virtual void afterInsert(){}
	protected virtual void afterUpdate(){}
	protected virtual void afterDelete(){}
	protected virtual void afterUndelete(){}
	protected virtual void handleSubTrigger(){}
    
    // Triggers can be deactivated for migration purposes
    //  This can be configured using custom settings
    private boolean TriggersDisabled () {
        List<RunTrigger__c> settings = [
            SELECT Is_Disabled__c
			FROM RunTrigger__c
        	LIMIT 1];
        
        if (settings.size() > 0)
            return settings.get(0).Is_Disabled__c;
        
        return false;
    } 
}