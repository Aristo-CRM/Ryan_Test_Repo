/* ---------------------------------------------------
    Author:     Kashyap Murthy
    Company:    Sqware Peg
    Description: 
        QuoteLineItemTriggerHandler the logical part of the trigger framework. 
    
    Test Class: 
    Pages: N.A.
    History:
        Initial creation 2018/05/29

*/

public class QuoteLineItemTriggerHandler extends TriggerHandler{
    
    private List<QuoteLineItem> oldList = null;
    private List<QuoteLineItem> newList = null;
    private Map<Id,QuoteLineItem> oldMap = null;
    private Map<Id,QuoteLineItem> newMap = null;
    
    protected override void handleSubTrigger() {
        oldList = (List<QuoteLineItem>)this.oldListSobject;
        newList = (List<QuoteLineItem>)this.newListSobject;
        oldMap = (Map<Id,QuoteLineItem>)this.oldMapSobject;
        newMap = (Map<Id,QuoteLineItem>)this.newMapSobject;        
    }
    
    protected override void beforeInsert(){
    	BeforeInsertQuoteLineItem.populatePriceBookEntry(newList); 
        QuoteLineItem item = new QuoteLineItem();
    }
    protected override void beforeUpdate(){}
    
    protected override void beforeDelete(){}
    protected override void afterInsert(){}
    
    protected override void afterUpdate(){}    
    protected override void afterDelete(){}    
    protected override void afterUndelete(){}
    
}