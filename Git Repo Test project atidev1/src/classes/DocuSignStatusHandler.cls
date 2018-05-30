/* ---------------------------------------------------
	Author: 	Paul Perry
	Company:	Sqware Peg
	Description: 
		Trigger logic is for DocuSignStatus object. 

		Once signed, the output PDF doc is uploaded as an attachment related to a 
		DocuSignStatus record. The record should be visible by Role hierarchy and
		also, in case the record is owned by a Sales Manager, being shared with 
		the user's team members as well. The logic for this is handled in the 
		method below. 
	
	Test Class: N.A.
	Pages: N.A.
	History:
		Required for Sprint #6
		Initial creation 2018/04/30

*/
public class DocuSignStatusHandler extends TriggerHandler{
	// Containers for trigger parameters
    private List<dsfs__DocuSign_Status__c> oldList = null;
    private List<dsfs__DocuSign_Status__c> newList = null;
    private Map<Id,dsfs__DocuSign_Status__c> oldMap = null;
    private Map<Id,dsfs__DocuSign_Status__c> newMap = null;

    // Initialize variables
    protected override void handleSubTrigger() {
        oldList = (List<dsfs__DocuSign_Status__c>)this.oldListSobject;
        newList = (List<dsfs__DocuSign_Status__c>)this.newListSobject;
        oldMap = (Map<Id,dsfs__DocuSign_Status__c>)this.oldMapSobject;
        newMap = (Map<Id,dsfs__DocuSign_Status__c>)this.newMapSobject;        
    }

	protected override void beforeInsert(){}
	protected override void beforeUpdate(){}
	protected override void beforeDelete(){}

    /*
	 * Once inserted, custom sharing will be applied
	 * */
	protected override void afterInsert(){
        DocuSignStatusUtil.ShareRecords(newList);   
    }
    
	protected override void afterUpdate(){
        // 
    }    
        
	protected override void afterDelete(){}    
	protected override void afterUndelete(){}
}