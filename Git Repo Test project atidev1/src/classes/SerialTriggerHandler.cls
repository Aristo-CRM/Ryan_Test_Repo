public with sharing class SerialTriggerHandler extends TriggerHandler{
    
    private List<Serial__c> oldList = null;
    private List<Serial__c> newList = null;
    private Map<Id,Serial__c> oldMap = null;
    private Map<Id,Serial__c> newMap = null;
    
    protected override void handleSubTrigger() {
        oldList = (List<Serial__c>)this.oldListSobject;
        newList = (List<Serial__c>)this.newListSobject;
        oldMap = (Map<Id,Serial__c>)this.oldMapSobject;
        newMap = (Map<Id,Serial__c>)this.newMapSobject;        
    }
    
    protected override void beforeInsert(){
        Serial__c item = new Serial__c();
    }
    protected override void beforeUpdate(){}
    
    protected override void beforeDelete(){}
    protected override void afterInsert(){}
    
    protected override void afterUpdate(){}    
    protected override void afterDelete(){}    
    protected override void afterUndelete(){}
    
}