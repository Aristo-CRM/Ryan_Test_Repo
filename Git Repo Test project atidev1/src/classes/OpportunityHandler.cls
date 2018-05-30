/* ---------------------------------------------------
    Author:     Paul Perry
    Company:    Sqware Peg
    Description: 
        OpportunityHandler the logical part of the trigger framework. 
    
    Test Class: 
    Pages: N.A.
    History:
        Initial creation 2018/04/30

*/
public class OpportunityHandler extends TriggerHandler{

    private List<Opportunity> oldList = null;
    private List<Opportunity> newList = null;
    private Map<Id,Opportunity> oldMap = null;
    private Map<Id,Opportunity> newMap = null;

    protected override void handleSubTrigger() {
        oldList = (List<Opportunity>)this.oldListSobject;
        newList = (List<Opportunity>)this.newListSobject;
        oldMap = (Map<Id,Opportunity>)this.oldMapSobject;
        newMap = (Map<Id,Opportunity>)this.newMapSobject;        
    }

	protected override void beforeInsert(){}
	protected override void beforeUpdate(){
		
		Date dNewCloseDate;
		Date dOldCloseDate;
		
		for (Opportunity oIterator :newList) { 
            //Bulk trigger handler so that you can mass update opportunities and this fires for all'
            // gets new values for updated rows
            
            dNewCloseDate = oIterator.CloseDate; // get the new closedate 
            dOldCloseDate = oldMap.get(oIterator.Id).CloseDate; //get the old closedate for this opportunity

            System.debug(new object[] { 
                dOldCloseDate, 
                '->', 
                dNewCloseDate, 
                dOldCloseDate.monthsBetween(dNewCloseDate) > 0 });
            
            // If opp has been pushed out to next month (or more months)
            if (dOldCloseDate.monthsBetween(dNewCloseDate) > 0) {
                if (oIterator.PushCount__c == null) oIterator.PushCount__c = 1;
                else oIterator.PushCount__c++;           
            }
        }
	}
	
	protected override void beforeDelete(){}
	protected override void afterInsert(){}
    
	protected override void afterUpdate(){}    
	protected override void afterDelete(){}    
	protected override void afterUndelete(){}
}