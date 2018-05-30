({
    handleValueChange : function(component, event, helper) {
        console.log(['Main level: records changed']);
        var compEvents = component.getEvent("mainRecordValueChange"),
        	eventParams = event.getParams(),
        	name = component.get('v.id');

        eventParams.name = name;

        compEvents.setParams(eventParams);        
        compEvents.fire();        
    }	
})