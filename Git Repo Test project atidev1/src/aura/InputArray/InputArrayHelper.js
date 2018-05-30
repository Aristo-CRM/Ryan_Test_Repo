({
	FireNewRecordEvent : function(component, newRecord, helper) {
		console.log(['Fire NewRecord event', event]);
        var compEvents = component.getEvent("recordValueChange"),
            records = component.get('v.records'),     
        	value = component.get('v.value');

        compEvents.setParams( { 
            "name": 'addRecord',
            "value": {
            	"records" : records,
            	"newRecord" : newRecord
            } 
        });
        
        compEvents.fire();  
	}
})