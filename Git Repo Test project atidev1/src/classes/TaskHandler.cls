/* ---------------------------------------------------
    Author:     Paul Perry
    Company:    Sqware Peg
    Description: 
        TaskHandler the logical part of the trigger framework. 
    
    Test Class: TaskUtilTest
    Pages: N.A.
    History:
        Initial creation 2018/05/01

*/
public class TaskHandler extends TriggerHandler{

    private List<Task> oldList = null;
    private List<Task> newList = null;
    private Map<Id,Task> oldMap = null;
    private Map<Id,Task> newMap = null;

    protected override void handleSubTrigger() {
        oldList = (List<Task>)this.oldListSobject;
        newList = (List<Task>)this.newListSobject;
        oldMap = (Map<Id,Task>)this.oldMapSobject;
        newMap = (Map<Id,Task>)this.newMapSobject;        
    }

	protected override void beforeInsert(){}
	protected override void beforeUpdate(){}	
	protected override void beforeDelete(){}
    
	protected override void afterInsert(){
        TaskUtil.UpdateQuarterlyAccountTasks(newList);
    }
    
    protected override void afterUpdate(){
        TaskUtil.UpdateQuarterlyAccountTasks(newList);
    }
	
    protected override void afterDelete(){
        TaskUtil.UpdateQuarterlyAccountTasks(oldList);
    }
    
	protected override void afterUndelete(){
        TaskUtil.UpdateQuarterlyAccountTasks(newList);
    }      
}